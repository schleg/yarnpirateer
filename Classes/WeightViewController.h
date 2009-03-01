//
//  WeightViewController.h
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/8/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Yarn.h"
#import "Weight.h"

@interface WeightViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	UITableView *tableView;
	NSMutableArray *weights;
	IBOutlet UIBarButtonItem *addButton;
	IBOutlet UIBarButtonItem *editButton;
	IBOutlet UIBarButtonItem *deleteButton;
	NSIndexPath *_lastClickedIndexPath;
	BOOL _editing;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *weights;
@property (nonatomic, retain) UIBarButtonItem *addButton;
@property (nonatomic, retain) UIBarButtonItem *editButton;
@property (nonatomic, retain) UIBarButtonItem *deleteButton;

- (IBAction)add;
- (IBAction)edit;
- (IBAction)delete;

@end
