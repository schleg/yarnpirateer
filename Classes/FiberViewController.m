//
//  FiberViewController.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/8/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "FiberViewController.h"

@interface UIAlertView (extended)
- (UITextField *)textFieldAtIndex:(int)index;
- (void)addTextFieldWithValue:(NSString *)value label:(NSString *)label;
@end

@implementation FiberViewController

@synthesize tableView, fibers, addButton, editButton, deleteButton;

- (NSMutableArray *)fibers {
	if(nil == fibers) {
		self.fibers = [Fiber all];
	}
	return fibers;
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
	UIAlertView *promptForName = [[UIAlertView alloc] initWithTitle:@"Add a New Fiber" message:@"Please type new fiber name below" delegate:self cancelButtonTitle:@"Don't Add" otherButtonTitles:@"Add Fiber",nil];
	[promptForName addTextFieldWithValue:@"" label:@"New Fiber Name"];
	[promptForName show];
	[promptForName release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.fibers count];
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"default-cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellId] autorelease];
    }
	Fiber *fiber = [self.fibers objectAtIndex:indexPath.row];
	cell.text = [NSString stringWithFormat:@"%@ (%d)", fiber.friendlyName, [[Yarn byFiber:fiber.name] count]];
	
	if(YES == [fiber isselected]) {
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
	_lastClickedIndexPath = indexPath;
	Fiber *fiber = [self.fibers objectAtIndex:indexPath.row];
	UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
	if(NO == _editing) {
		if (NO == [fiber isselected]) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
			[fiber setIsselected:YES];
			//NSLog(@"Setting %@ to %d", fiber.name, [fiber isselected]);
		} else {
			cell.accessoryType = UITableViewCellAccessoryNone;
			[fiber setIsselected:NO];
			//NSLog(@"Setting %@ to %d", fiber.name, [fiber isselected]);
		}		
	} else {
		UIAlertView *promptForName = [[UIAlertView alloc] initWithTitle:@"Edit Fiber Name" message:@"Please edit the fiber name below" delegate:self cancelButtonTitle:@"Don't Save" otherButtonTitles:@"Save Fiber",nil];
		[promptForName addTextFieldWithValue:fiber.friendlyName label:@"Fiber Name"];
		[promptForName show];
		[promptForName release];
	}
	self.fibers = nil;
	[tableView reloadData];
}

- (void)tableView:(UITableView *)_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	_lastClickedIndexPath = indexPath;
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		Fiber *fiber = [[self.fibers objectAtIndex:indexPath.row] retain];
		int yarnCount = [[Yarn byFiber:fiber.name] count];
		if(yarnCount > 0) {
			NSString *messageSingular = [NSString stringWithFormat:@"There is %d yarn in the '%@' fiber", yarnCount, fiber.friendlyName];
			NSString *messagePlural = [NSString stringWithFormat:@"There are %d yarns in the '%@' fiber", yarnCount, fiber.friendlyName];
			NSString *message = yarnCount > 1 ? messagePlural : messageSingular;
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"HOLD ON!" message:message delegate:self cancelButtonTitle:@"Don't delete" otherButtonTitles:@"Delete All",nil];
			[alert show];
			[alert release];
		} else {
			Fiber *selectedFiber = [self.fibers objectAtIndex:_lastClickedIndexPath.row];
			[selectedFiber delete];
			[self.fibers removeObjectAtIndex:_lastClickedIndexPath.row];
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:_lastClickedIndexPath] withRowAnimation:YES];
		}
    }
	if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
    [tableView endUpdates];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	UITextField *fiberNameField = [alertView textFieldAtIndex:0];
	switch (buttonIndex) {
		case 0:
		{
			[tableView reloadData];
			break;			
		}
		case 1:
		{
			if(_editing)
			{
				Fiber *selectedFiber = [self.fibers objectAtIndex:_lastClickedIndexPath.row];
				if([fiberNameField.text length] == 0) {
					[alertView dismissWithClickedButtonIndex:0 animated:YES];
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FYI" message:@"The fiber name was not changed because a fiber name was not entered" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
					[alert show];
					[alert release];
				} else {
					selectedFiber.friendlyName = fiberNameField.text;
					[selectedFiber update];
					self.fibers = nil;
					[tableView reloadData];
				}	
			} else {
				if(nil == _lastClickedIndexPath) {
					if([fiberNameField.text length] == 0) {
						[alertView dismissWithClickedButtonIndex:0 animated:YES];
						UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FYI..." message:@"A fiber was not added because a fiber name was not entered" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
						[alert show];
						[alert release];
					} else {
						CFUUIDRef uuidObj = CFUUIDCreate(nil);
						NSString *fiberUUID = (NSString*)CFUUIDCreateString(nil, uuidObj);
						CFRelease(uuidObj);
						Fiber *newFiber = [[Fiber alloc] initWithName:fiberUUID friendlyName:fiberNameField.text selected:YES];
						[newFiber create];
						[fiberUUID release];
						[newFiber release];
						self.fibers = nil;
						[tableView reloadData];
					}
				} else {
					Fiber *selectedFiber = [self.fibers objectAtIndex:_lastClickedIndexPath.row];
					NSMutableArray *yarnsForFiber = [Yarn byFiber:selectedFiber.name];
					for(int i=0;i<[yarnsForFiber count];i++) {
						[[yarnsForFiber objectAtIndex:i] delete];
					}
					[selectedFiber delete];
					[self.fibers removeObjectAtIndex:_lastClickedIndexPath.row];
					[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:_lastClickedIndexPath] withRowAnimation:YES];
				}				
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
	fibers = nil;
	[tableView reloadData];
}

- (void)dealloc {
	[addButton release];
	[editButton release];
	[deleteButton release];
	[fibers release];
	[tableView release];
    [super dealloc];
}

@end
