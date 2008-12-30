//
//  SecondViewController.h
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/7/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Yarn.h"
#import "Brand.h"

@interface SecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate> {
	UITableView *tableView;
	NSMutableArray *brands;
	IBOutlet UIBarButtonItem *addButton;
	IBOutlet UIBarButtonItem *deleteButton;
	IBOutlet UIBarButtonItem *editButton;
	NSIndexPath *_lastClickedIndexPath;
	BOOL _editing;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *brands;
@property (nonatomic, retain) UIBarButtonItem *addButton;
@property (nonatomic, retain) UIBarButtonItem *deleteButton;
@property (nonatomic, retain) UIBarButtonItem *editButton;

- (IBAction)add;
- (IBAction)edit;
- (IBAction)delete;

@end