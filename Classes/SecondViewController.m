//
//  SecondViewController.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/7/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController

@synthesize tableView, brands, addButton, editButton;

- (NSMutableArray *)brands {
	if(nil == brands) {
		self.brands = [Brand all];
	}
	return brands;
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
	}
    return cell;
}

NSIndexPath *lastClickedIndexPath;

- (void)tableView:(UITableView *)_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	lastClickedIndexPath = indexPath;
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		Brand *brand = [[self.brands objectAtIndex:indexPath.row] retain];
		int yarnCount = [[Yarn byBrand:brand.name] count];
		if(yarnCount > 0) {
			NSString *messageSingular = [NSString stringWithFormat:@"There is %d yarn in the '%@' brand", yarnCount, brand.friendlyName];
			NSString *messagePlural = [NSString stringWithFormat:@"There are %d yarns in the '%@' brand", yarnCount, brand.friendlyName];
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
			Brand *selectedBrand = [self.brands objectAtIndex:lastClickedIndexPath.row];
			NSMutableArray *yarnsForBrand = [Yarn byBrand:selectedBrand.name];
			for(int i=0;i<[yarnsForBrand count];i++) {
				[[yarnsForBrand objectAtIndex:i] delete];
			}
			[selectedBrand delete];
			[self.brands removeObjectAtIndex:lastClickedIndexPath.row];
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:lastClickedIndexPath] withRowAnimation:YES];
			break;
		}
		default:
			break;
	}
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Brand *brand = [self.brands objectAtIndex:indexPath.row];
	UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
	if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
		cell.accessoryType = UITableViewCellAccessoryNone;
		[brand setIsselected:NO];
	} else {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
		[brand setIsselected:YES];
		NSLog(@"Setting %@ to %d", brand.name, [brand isselected]);
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
	[editButton release];
	[addButton release];
	[brands release];
	[tableView release];
    [super dealloc];
}

@end