//
//  FirstViewController.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/7/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "FirstViewController.h"
#import "YarnCell.h"

@implementation FirstViewController

@synthesize tableView, yarns, addButton, editButton;

int alertViewIndex = -1;
int actionSheetIndex = -1;
NSString *yarnCellNibName = @"SortByBrandYarnCell";

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
		editButton.title = @"Remove";
	} else {
		[tableView setEditing:YES animated:YES];
		[editButton setStyle:UIBarButtonItemStyleDone];
		editButton.title = @"Done";
	}
}

- (IBAction)sort {
	actionSheetIndex = 2;
	UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Sort By Brand",@"Sort By Weight",@"Sort By Fiber",nil];
	[sheet showInView:self.view];
	[sheet release];	
}

- (IBAction)add {
	[self.tabBarController setSelectedIndex:3];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	UITextField *textField = [[alertView textFieldAtIndex:0] retain];
	Yarn *yarn = [self.yarns objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
	switch (alertViewIndex) {
		case 0:
		{
			switch (buttonIndex) {
				case 1:
				{
					yarn.name = textField.text;
					[yarn update];
					break;
				}
				default:
					break;
			}	
			break;
		}
		case 1:
		{
			switch (buttonIndex) {
				case 1:
				{
					yarn.quantity = atoi([textField.text UTF8String]);
					[yarn update];
					break;
				}
				default:
					break;				
			}
			break;
		}
		default:
			break;
	}
	yarns = nil;
	yarnCells = nil;
	[tableView reloadData];
	alertViewIndex = -1;
}

- (void)sortYarn:(NSString *)nibName {
	yarnCellNibName = nibName;
	yarns = nil;
	yarnCells = nil;
	[tableView reloadData];	
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (actionSheetIndex) {
		case 1:
		{
			switch (buttonIndex) {
				case 0:
				{
					Yarn *yarn = [self.yarns objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
					NSString *title = @"Change Name";
					UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save",nil];
					[alertView addTextFieldWithValue:yarn.name label:@"Enter Name Here"];
					[[alertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDefault];
					alertViewIndex = 0;
					[alertView show];
					break;			
				}
				case 1:
				{
					Yarn *yarn = [self.yarns objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
					NSString *title = [NSString stringWithFormat:@"Quantity for \"%@\"", yarn.name];
					UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save",nil];
					[alertView addTextFieldWithValue:[NSString stringWithFormat:@"%d",yarn.quantity] label:@"0"];
					[[alertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
					alertViewIndex = 1;
					[alertView show];
					break;			
				}
				default:
					break;
			}
		}
		case 2:
		{
			switch(buttonIndex) {
				case 0:
				{
					[self sortYarn:@"SortByBrandYarnCell"];
					break;
				}
				case 1:
				{
					[self sortYarn:@"SortByWeightYarnCell"];
					break;
				}
				case 2:
				{
					[self sortYarn:@"SortByFiberYarnCell"];
					break;
				}
				default:
					break;
			}
		}
	}
	actionSheetIndex = -1;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	actionSheetIndex = 1;
	UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Change Name",@"Change Quantity",nil];
	[sheet showInView:self.view];
	[sheet release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.yarns count];
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellId = @"yarn-cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
		Yarn *yarn = ((Yarn *)[self.yarns objectAtIndex:indexPath.row]);
		cell = [[YarnCell yarnCellWithYarn:yarn nibName:yarnCellNibName] cell];
    }
	
    return cell;
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 110.0f;
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
	[addButton release];
	[editButton release];
	[yarns release];
	[tableView release];
    [super dealloc];
}

@end