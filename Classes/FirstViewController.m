//
//  FirstViewController.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/7/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController

@synthesize tableView, yarns, deleteButton, addButton, titleLabel;

- (NSMutableArray *)yarns {
	if(nil == yarns) {
		self.yarns = [[[NSMutableArray alloc] init] autorelease];
		NSMutableArray *allYarns = [Yarn all];
		for(int i=0; i<[allYarns count]; i++) {
			Yarn *yarn = [allYarns objectAtIndex:i];
			if (YES == [yarn.brand isselected] || YES == [yarn.weight isselected]) {
				[self.yarns addObject:yarn];
			}
		}
	}
	return yarns;
}

- (IBAction)add {
	[self.tabBarController setSelectedIndex:3];
}

- (IBAction)delete {
	if([tableView isEditing]) {
		[tableView setEditing:NO animated:YES];
		[deleteButton setStyle:UIBarButtonItemStyleBordered];
		deleteButton.title = @"Delete";
	} else {
		[tableView setEditing:YES animated:YES];
		[deleteButton setStyle:UIBarButtonItemStyleDone];
		deleteButton.title = @"Done";
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.yarns count];
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"default-cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
		cell = [[UITableViewCell alloc] init];
		Yarn *yarn = ((Yarn *)[self.yarns objectAtIndex:indexPath.row]);
		cell.text = [NSString stringWithFormat:@"%@ (%d yds)", yarn.name, yarn.quantity];
    }
    return cell;
}

- (void)tableView:(UITableView *)_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		[[self.yarns objectAtIndex:indexPath.row] delete];
        [self.yarns removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }
    [tableView endUpdates];
}

- (void)viewWillAppear:(BOOL)animated {
	yarns = nil;
	yarnCells = nil;
	[tableView reloadData];
	UINavigationController *newYarnNavController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:3];
	[newYarnNavController popToRootViewControllerAnimated:NO];	
	float uiFontSize = 18.0f;
	titleLabel.font = [UIFont boldSystemFontOfSize:uiFontSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
	[deleteButton release];
	[addButton release];
	[titleLabel release];
	[yarns release];
	[tableView release];
    [super dealloc];
}

@end