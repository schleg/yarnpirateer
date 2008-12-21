//
//  SelectBrandView.h
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weight.h"
#import "Brand.h"
#import "AddYarnViewController.h";

@interface SelectWeightViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate> {
	IBOutlet UIButton *selectWeightButton;
	IBOutlet UIPickerView *weightPicker;
	IBOutlet UITextField *weightNameTextField;
	IBOutlet UILabel *weightNameLabel;
	NSMutableArray *weights;
	Weight *selectedWeight;
	Brand *selectedBrand;
}

@property (nonatomic, retain) UIButton *selectWeightButton;
@property (nonatomic, retain) UIPickerView *weightPicker;
@property (nonatomic, retain) NSMutableArray *weights;
@property (nonatomic, retain) Weight *selectedWeight;
@property (nonatomic, retain) Brand *selectedBrand;
@property (nonatomic, retain) UITextField *weightNameTextField;
@property (nonatomic, retain) UILabel *weightNameLabel;

- (IBAction)selectWeight:(id)sender;

@end
