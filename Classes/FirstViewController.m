//
//  FirstViewController.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/7/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController

@synthesize tableView, yarns, editButton, titleLabel;

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
    return [self.yarns count];
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"default-cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellId] autorelease];
    }
	Yarn *yarn = [self.yarns objectAtIndex:indexPath.row];
	cell.text = yarn.name;
    return cell;
}

- (void)tableView:(UITableView *)_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		[[self.yarns objectAtIndex:indexPath.row] delete];
        [self.yarns removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }  if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
    [tableView endUpdates];
}

- (void)viewWillAppear:(BOOL)animated {
	yarns = nil;
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
	[editButton release];
	[titleLabel release];
	[yarns release];
	[tableView release];
    [super dealloc];
}

@end