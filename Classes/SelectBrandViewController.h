//
//  SelectBrandView.h
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Brand.h"
#import "SelectWeightViewController.h"

@interface SelectBrandViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate> {
	IBOutlet UINavigationController *navigationController;
	IBOutlet UIButton *selectBrandButton;
	IBOutlet UIPickerView *brandPicker;
	IBOutlet UITextField *brandNameTextField;
	IBOutlet UILabel *addNewLabel;
	IBOutlet UILabel *brandNameLabel;
	NSMutableArray *brands;
	Brand *selectedBrand;
}

@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) UIButton *selectBrandButton;
@property (nonatomic, retain) UIPickerView *brandPicker;
@property (nonatomic, retain) NSMutableArray *brands;
@property (nonatomic, retain) Brand *selectedBrand;
@property (nonatomic, retain) UITextField *brandNameTextField;
@property (nonatomic, retain) UILabel *brandNameLabel;

- (IBAction)selectBrand:(id)sender;

@end
