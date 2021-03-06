//
//  YarnViewController.h
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/7/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Yarn.h"
#import "YarnPirateerAppDelegate.h"
#import "YarnDetailViewController.h"

@interface YarnViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIAlertViewDelegate, UINavigationControllerDelegate> {
	IBOutlet UINavigationController *navigationController;
	UITableView *tableView;
	NSMutableArray *yarns;
	IBOutlet UIBarButtonItem *editButton;
	NSMutableArray *yarnCells;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *yarns;
@property (nonatomic, retain) UIBarButtonItem *editButton;

- (IBAction)edit;
- (IBAction)sort;

@end