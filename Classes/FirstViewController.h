//
//  FirstViewController.h
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/7/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Yarn.h"

@interface FirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	UITableView *tableView;
	NSMutableArray *yarns;
	IBOutlet UIBarButtonItem *editButton;
	IBOutlet UIBarButtonItem *addButton;
	IBOutlet UILabel *titleLabel;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *yarns;
@property (nonatomic, retain) UIBarButtonItem *editButton;
@property (nonatomic, retain) UIBarButtonItem *addButton;
@property (nonatomic, retain) UILabel *titleLabel;

- (IBAction)edit;
- (IBAction)add;

@end