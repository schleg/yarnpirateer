//
//  SecondViewController.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/7/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"

@interface UIAlertView (extended)
- (UITextField *)textFieldAtIndex:(int)index;
- (void)addTextFieldWithValue:(NSString *)value label:(NSString *)label;
@end

@implementation SecondViewController

@synthesize tableView, brands, addButton, editButton, deleteButton;

- (NSMutableArray *)brands {
	if(nil == brands) {
		self.brands = [Brand all];
	}
	return brands;
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
	UIAlertView *promptForName = [[UIAlertView alloc] initWithTitle:@"Add a New Brand" message:@"Please type new brand name below" delegate:self cancelButtonTitle:@"Don't Add" otherButtonTitles:@"Add Brand",nil];
	[promptForName addTextFieldWithValue:@"" label:@"New Brand Name"];
	[promptForName show];
	[promptForName release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.brands count];
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"default-cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellId];
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellId] autorelease];
    }
	Brand *brand = [self.brands objectAtIndex:indexPath.row];
	cell.text = [NSString stringWithFormat:@"%@ (%d)", brand.friendlyName, [[Yarn byBrand:brand.name] count]];

	if(YES == [brand isselected]) {
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

- (void)tableView:(UITableView *)_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	_lastClickedIndexPath = indexPath;
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		Brand *brand = [[self.brands objectAtIndex:indexPath.row] retain];
		int yarnCount = [[Yarn byBrand:brand.name] count];
		if(yarnCount > 0) {
			NSString *messageSingular = [NSString stringWithFormat:@"There is %d yarn in the '%@' brand", yarnCount, brand.friendlyName];
			NSString *messagePlural = [NSString stringWithFormat:@"There are %d yarns in the '%@' brand", yarnCount, brand.friendlyName];
			NSString *message = yarnCount > 1 ? messagePlural : messageSingular;
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"HOLD ON!" message:message delegate:self cancelButtonTitle:@"Don't Delete" otherButtonTitles:@"Delete All",nil];
			[alert show];
			[alert release];
		} else {
			Brand *selectedBrand = [self.brands objectAtIndex:_lastClickedIndexPath.row];
			[selectedBrand delete];
			[self.brands removeObjectAtIndex:_lastClickedIndexPath.row];
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:_lastClickedIndexPath] withRowAnimation:YES];
		}
    }
	if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
    [tableView endUpdates];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	UITextField *brandNameField = [alertView textFieldAtIndex:0];
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
				Brand *selectedBrand = [self.brands objectAtIndex:_lastClickedIndexPath.row];
				if([brandNameField.text length] == 0) {
					[alertView dismissWithClickedButtonIndex:0 animated:YES];
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FYI" message:@"The brand name was not changed because a brand name was not entered" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
					[alert show];
					[alert release];
				} else {
					selectedBrand.friendlyName = brandNameField.text;
					[selectedBrand update];
					self.brands = nil;
					[tableView reloadData];
				}
			} else {
				if(nil == _lastClickedIndexPath) {
					if([brandNameField.text length] == 0) {
						[alertView dismissWithClickedButtonIndex:0 animated:YES];
						UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FYI" message:@"A brand was not added because a brand name was not entered" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
						[alert show];
						[alert release];
					} else {
						CFUUIDRef uuidObj = CFUUIDCreate(nil);
						NSString *brandUUID = (NSString*)CFUUIDCreateString(nil, uuidObj);
						CFRelease(uuidObj);
						Brand *newBrand = [[Brand alloc] initWithName:brandUUID friendlyName:brandNameField.text selected:YES];
						[newBrand create];
						[brandUUID release];
						[newBrand release];
						self.brands = nil;
						[tableView reloadData];
					}
				} else {
					Brand *selectedBrand = [self.brands objectAtIndex:_lastClickedIndexPath.row];
					NSMutableArray *yarnsForBrand = [Yarn byBrand:selectedBrand.name];
					for(int i=0;i<[yarnsForBrand count];i++) {
						[[yarnsForBrand objectAtIndex:i] delete];
					}
					[selectedBrand delete];
					[self.brands removeObjectAtIndex:_lastClickedIndexPath.row];
					[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:_lastClickedIndexPath] withRowAnimation:YES];
				}				
			}
			break;
		}
		default:
			break;
	}
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	_lastClickedIndexPath = indexPath;
	Brand *brand = [self.brands objectAtIndex:indexPath.row];
	UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
	if(NO == _editing) {
		if (NO == [brand isselected]) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
			[brand setIsselected:YES];
			//NSLog(@"Setting %@ to %d", brand.name, [brand isselected]);
		} else {
			cell.accessoryType = UITableViewCellAccessoryNone;
			[brand setIsselected:NO];
			//NSLog(@"Setting %@ to %d", brand.name, [brand isselected]);
		}		
	} else {
		UIAlertView *promptForName = [[UIAlertView alloc] initWithTitle:@"Edit Brand Name" message:@"Please edit the brand name below" delegate:self cancelButtonTitle:@"Don't Save" otherButtonTitles:@"Save Brand",nil];
		[promptForName addTextFieldWithValue:brand.friendlyName label:@"Brand Name"];
		[promptForName show];
		[promptForName release];
	}
	self.brands = nil;
	[tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
	brands = nil;
	[tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
	[_lastClickedIndexPath release];
	[deleteButton release];
	[editButton release];
	[addButton release];
	[brands release];
	[tableView release];
    [super dealloc];
}

@end