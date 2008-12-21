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

- (void)tableView:(UITableView *)_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		[[self.brands objectAtIndex:indexPath.row] delete];
        [self.brands removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }  if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
    [tableView endUpdates];
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