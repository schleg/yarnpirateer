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

@interface YarnViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIAlertViewDelegate> {
	UITableView *tableView;
	NSMutableArray *yarns;
	IBOutlet UIBarButtonItem *addButton;
	IBOutlet UIBarButtonItem *editButton;
	NSMutableArray *yarnCells;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *yarns;
@property (nonatomic, retain) UIBarButtonItem *addButton;
@property (nonatomic, retain) UIBarButtonItem *editButton;

- (IBAction)add;
- (IBAction)edit;
- (IBAction)sort;

@end