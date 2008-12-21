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

- (void)tableView:(UITableView *)_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		[[self.weights objectAtIndex:indexPath.row] delete];
        [self.weights removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }  if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
    [tableView endUpdates];
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
