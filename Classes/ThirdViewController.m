//
//  ThirdViewController.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/8/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ThirdViewController.h"

@implementation ThirdViewController

@synthesize tableView, weights, addButton, editButton;

- (NSMutableArray *)weights {
	if(nil == weights) {
		self.weights = [Weight all];
	}
	return weights;
}

- (IBAction)edit {
	if([tableView isEditing]) {
		[tableView setEditing:NO animated:YES];
		[editButton setStyle:UIBarButtonItemStyleBordered];
		editButton.title = @"Edit";
	} else {
		[tableView setEditing:YES animated:YES];
		[editButton setStyle:UIBarButtonItemStyleDone];
		editButton.title = @"Done";
	}
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

NSIndexPath *lastClickedIndexPath;

- (void)tableView:(UITableView *)_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	lastClickedIndexPath = indexPath;
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
			Weight *selectedWeight = [self.weights objectAtIndex:lastClickedIndexPath.row];
			NSMutableArray *yarnsForWeight = [Yarn byWeight:selectedWeight.name];
			for(int i=0;i<[yarnsForWeight count];i++) {
				[[yarnsForWeight objectAtIndex:i] delete];
			}
			[selectedWeight delete];
			[self.weights removeObjectAtIndex:lastClickedIndexPath.row];
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:lastClickedIndexPath] withRowAnimation:YES];
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
	[weights release];
	[tableView release];
    [super dealloc];
}

@end
