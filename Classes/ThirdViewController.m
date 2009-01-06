//
//  ThirdViewController.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/8/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ThirdViewController.h"

@interface UIAlertView (extended)
- (UITextField *)textFieldAtIndex:(int)index;
- (void)addTextFieldWithValue:(NSString *)value label:(NSString *)label;
@end

@implementation ThirdViewController

@synthesize tableView, weights, addButton, editButton, deleteButton;

- (NSMutableArray *)weights {
	if(nil == weights) {
		self.weights = [Weight all];
	}
	return weights;
}

- (void)cancelEditing {
	_editing = NO;
	[tableView setEditing:NO animated:YES];
	[editButton setStyle:UIBarButtonItemStyleBordered];
	editButton.title = @"Edit";
	[tableView reloadData];
}

- (void)cancelDeleting {
	[tableView setEditing:NO animated:YES];
	[deleteButton setStyle:UIBarButtonItemStyleBordered];
	deleteButton.title = @"Delete";	
}

- (IBAction)delete {
	if(_editing) {
		[self cancelEditing];		
	}
	if([tableView isEditing]) {
		[self cancelDeleting];
	} else {
		[tableView setEditing:YES animated:YES];
		[deleteButton setStyle:UIBarButtonItemStyleDone];
		deleteButton.title = @"Done";
	}
}

- (IBAction)edit {
	if([tableView isEditing]) {
		[self cancelDeleting];
	}
	if(_editing) {
		[self cancelEditing];
	} else {
		_editing = YES;
		[editButton setStyle:UIBarButtonItemStyleDone];
		editButton.title = @"Done";
		[tableView reloadData];
	}	
}

- (IBAction)add {
	_lastClickedIndexPath = nil;
	UIAlertView *promptForName = [[UIAlertView alloc] initWithTitle:@"Add a New Weight" message:@"Please type new weight name below" delegate:self cancelButtonTitle:@"Don't Add" otherButtonTitles:@"Add Weight",nil];
	[promptForName addTextFieldWithValue:@"" label:@"New Weight Name"];
	[promptForName show];
	[promptForName release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.weights count];
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"default-cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellId] autorelease];
    }
	Weight *weight = [self.weights objectAtIndex:indexPath.row];
	cell.text = [NSString stringWithFormat:@"%@ (%d)", weight.friendlyName, [[Yarn byWeight:weight.name] count]];
	
	if(YES == [weight isselected]) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	} else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}

	if(_editing)
	{
		[tableView deselectRowAtIndexPath:indexPath animated:NO];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
    return cell;
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Weight *weight = [self.weights objectAtIndex:indexPath.row];
	UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
	if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
		cell.accessoryType = UITableViewCellAccessoryNone;
		[weight setIsselected:NO];
	} else {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
		[weight setIsselected:YES];
		NSLog(@"Setting %@ to %d", weight.name, [weight isselected]);
	}
	self.weights = nil;
	[tableView reloadData];
}

- (void)tableView:(UITableView *)_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	_lastClickedIndexPath = indexPath;
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		Weight *weight = [[self.weights objectAtIndex:indexPath.row] retain];
		int yarnCount = [[Yarn byWeight:weight.name] count];
		if(yarnCount > 0) {
			NSString *messageSingular = [NSString stringWithFormat:@"There is %d yarn in the '%@' weight", yarnCount, weight.friendlyName];
			NSString *messagePlural = [NSString stringWithFormat:@"There are %d yarns in the '%@' weight", yarnCount, weight.friendlyName];
			NSString *message = yarnCount > 1 ? messagePlural : messageSingular;
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"HOLD ON!" message:message delegate:self cancelButtonTitle:@"Don't delete" otherButtonTitles:@"Delete All",nil];
			[alert show];
			[alert release];
		} else {
			Weight *selectedWeight = [self.weights objectAtIndex:_lastClickedIndexPath.row];
			[selectedWeight delete];
			[self.weights removeObjectAtIndex:_lastClickedIndexPath.row];
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:_lastClickedIndexPath] withRowAnimation:YES];
		}
    }
	if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
    [tableView endUpdates];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case 0:
		{
			[tableView reloadData];
			break;			
		}
		case 1:
		{
			UITextField *weightNameField = [alertView textFieldAtIndex:0];
			if(nil == _lastClickedIndexPath) {
				if([weightNameField.text length] == 0) {
					[alertView dismissWithClickedButtonIndex:0 animated:YES];
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FYI..." message:@"A weight was not added because a weight name was not entered" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
					[alert show];
					[alert release];
				} else {
					CFUUIDRef uuidObj = CFUUIDCreate(nil);
					NSString *weightUUID = (NSString*)CFUUIDCreateString(nil, uuidObj);
					CFRelease(uuidObj);
					Weight *newWeight = [[Weight alloc] initWithName:weightUUID friendlyName:weightNameField.text selected:YES];
					[newWeight create];
					[weightUUID release];
					[newWeight release];
					self.weights = nil;
					[tableView reloadData];
				}
			} else {
				Weight *selectedWeight = [self.weights objectAtIndex:_lastClickedIndexPath.row];
				NSMutableArray *yarnsForWeight = [Yarn byWeight:selectedWeight.name];
				for(int i=0;i<[yarnsForWeight count];i++) {
					[[yarnsForWeight objectAtIndex:i] delete];
				}
				[selectedWeight delete];
				[self.weights removeObjectAtIndex:_lastClickedIndexPath.row];
				[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:_lastClickedIndexPath] withRowAnimation:YES];
			}
			break;
		}
		default:
			break;
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
	weights = nil;
	[tableView reloadData];
}

- (void)dealloc {
	[addButton release];
	[editButton release];
	[deleteButton release];
	[weights release];
	[tableView release];
    [super dealloc];
}

@end
