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
#import "EditYarnViewController.h";

@interface SelectFiberViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate> {
	IBOutlet UIButton *selectFiberButton;
	IBOutlet UIPickerView *fiberPicker;
	IBOutlet UITextField *fiberNameTextField;
	IBOutlet UILabel *fiberNameLabel;
	NSMutableArray *fibers;
	Weight *selectedWeight;
	Brand *selectedBrand;
	Fiber *selectedFiber;
}

@property (nonatomic, retain) UIButton *selectFiberButton;
@property (nonatomic, retain) UIPickerView *fiberPicker;
@property (nonatomic, retain) NSMutableArray *fibers;
@property (nonatomic, retain) Weight *selectedWeight;
@property (nonatomic, retain) Brand *selectedBrand;
@property (nonatomic, retain) Fiber *selectedFiber;
@property (nonatomic, retain) UITextField *fiberNameTextField;
@property (nonatomic, retain) UILabel *fiberNameLabel;

- (IBAction)selectFiber:(id)sender;

@end
