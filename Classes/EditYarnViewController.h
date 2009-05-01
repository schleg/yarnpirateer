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

@interface EditYarnViewController : UIViewController<UITextFieldDelegate, UIActionSheetDelegate> {
	IBOutlet UILabel *selectedBrandLabel;
	IBOutlet UILabel *selectedWeightLabel;
	IBOutlet UILabel *selectedFiberLabel;
	IBOutlet UIButton *saveYarnButton;
	IBOutlet UITextField *yarnNameTextField;
	IBOutlet UITextField *quantityTextField;
	IBOutlet UILabel *yarnNameLabel;
	IBOutlet UILabel *quantityLabel;
	IBOutlet UILabel *quantityTypeLabel;
	IBOutlet UILabel *brandNameLabel;
	IBOutlet UILabel *weightNameLabel;
	IBOutlet UILabel *fiberNameLabel;
	Weight *selectedWeight;
	Brand *selectedBrand;
	Fiber *selectedFiber;
	NSString *selectedQuantityType;
}

@property (nonatomic, retain) Weight *selectedWeight;
@property (nonatomic, retain) Brand *selectedBrand;
@property (nonatomic, retain) Fiber *selectedFiber;
@property (nonatomic, retain) NSString *selectedQuantityType;
@property (nonatomic, retain) UILabel *selectedBrandLabel;
@property (nonatomic, retain) UILabel *selectedWeightLabel;
@property (nonatomic, retain) UILabel *selectedFiberLabel;
@property (nonatomic, retain) UIButton *saveYarnButton;
@property (nonatomic, retain) UITextField *yarnNameTextField;
@property (nonatomic, retain) UITextField *quantityTextField;
@property (nonatomic, retain) UILabel *yarnNameLabel;
@property (nonatomic, retain) UILabel *quantityLabel;
@property (nonatomic, retain) UILabel *quantityTypeLabel;
@property (nonatomic, retain) UILabel *brandNameLabel;
@property (nonatomic, retain) UILabel *weightNameLabel;
@property (nonatomic, retain) UILabel *fiberNameLabel;

- (IBAction)saveYarn:(id)sender;
- (IBAction)chooseQuantityType:(id)sender;

@end
