//
//  EditYarnViewController.h
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/14/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weight.h"
#import "Brand.h"
#import "Yarn.h"
#import "SelectBrandViewController.h"
#import "YarnPirateerAppDelegate.h"

@interface EditYarnViewController : UIViewController<UITextFieldDelegate> {
	IBOutlet UILabel *selectedBrandLabel;
	IBOutlet UILabel *selectedWeightLabel;
	IBOutlet UIButton *saveYarnButton;
	IBOutlet UITextField *yarnNameTextField;
	IBOutlet UITextField *quantityTextField;
	IBOutlet UILabel *yarnNameLabel;
	IBOutlet UILabel *quantityLabel;
	IBOutlet UILabel *brandNameLabel;
	IBOutlet UILabel *weightNameLabel;
	Weight *selectedWeight;
	Brand *selectedBrand;
}

@property (nonatomic, retain) Weight *selectedWeight;
@property (nonatomic, retain) Brand *selectedBrand;
@property (nonatomic, retain) UILabel *selectedBrandLabel;
@property (nonatomic, retain) UILabel *selectedWeightLabel;
@property (nonatomic, retain) UIButton *saveYarnButton;
@property (nonatomic, retain) UITextField *yarnNameTextField;
@property (nonatomic, retain) UITextField *quantityTextField;
@property (nonatomic, retain) UILabel *yarnNameLabel;
@property (nonatomic, retain) UILabel *quantityLabel;
@property (nonatomic, retain) UILabel *brandNameLabel;
@property (nonatomic, retain) UILabel *weightNameLabel;

- (IBAction)saveYarn:(id)sender;

@end
