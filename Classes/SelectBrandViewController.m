//
//  SelectBrandView.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "SelectBrandViewController.h"

@implementation SelectBrandViewController

@synthesize navigationController, selectBrandButton, brandPicker, brands, selectedBrand, brandNameTextField, brandNameLabel;

- (NSMutableArray *)brands {
	if(nil == brands) {
		self.brands = [Brand all];
	}
	return brands;
}

- (void)viewWillAppear:(BOOL)animated {
	self.brands = nil;
	[brandPicker reloadAllComponents];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view.window addSubview:navigationController.view];
	self.navigationItem.title = @"Select Brand";
	brandNameTextField.returnKeyType = UIReturnKeyDone; 
	brandNameTextField.delegate = self;
	
	float uiFontSize = 18.0f;
	
	brandNameTextField.font = [UIFont fontWithName:brandNameTextField.font.fontName size:uiFontSize];
	selectBrandButton.font = [UIFont boldSystemFontOfSize:uiFontSize];
	brandNameLabel.font = [UIFont boldSystemFontOfSize:uiFontSize];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[brandNameTextField resignFirstResponder];
	[brandPicker reloadAllComponents];
	if ([textField.text length] > 0) {
		selectedBrand = [[Brand alloc] init];
		selectedBrand.friendlyName = textField.text;
		[brandPicker selectRow:0 inComponent:0 animated:YES];
	}
	return YES;
}

- (IBAction)selectBrand:(id)sender {
	if(nil == selectedBrand) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OOPS!" message:@"Please select a brand, or enter a new brand name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	SelectWeightViewController *selectWeightViewController = [[SelectWeightViewController alloc] initWithNibName:@"SelectWeightView" bundle:nil];
	selectWeightViewController.selectedBrand = selectedBrand;
	[self.navigationController pushViewController:selectWeightViewController animated:YES];
	[selectWeightViewController release];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	if (row == 0) {
		selectedBrand = nil;
		return;
	}
	[brandNameTextField setText:@""];
	selectedBrand = [brands objectAtIndex:row - 1];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [self.brands count] + 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (row == 0) {
		return nil;
	}
	return [[brands objectAtIndex:row - 1] friendlyName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
	[brandNameLabel release];
	selectedBrand = nil;
	[selectedBrand release];
	[navigationController release];
	[brandNameTextField release];
	[brands release];
	[selectBrandButton release];
	[brandPicker release];
    [super dealloc];
}

@end