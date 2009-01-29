//
//  SelectBrandView.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "SelectWeightViewController.h"

@implementation SelectWeightViewController

@synthesize selectWeightButton, weightPicker, weights, selectedWeight, selectedBrand, weightNameTextField, weightNameLabel, editingYarn;

- (NSMutableArray *)weights {
	if(nil == weights) {
		self.weights = [Weight all];
	}
	return weights;
}

- (void)viewWillAppear:(BOOL)animated {
	self.weights = nil;
	[weightPicker reloadAllComponents];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Select Weight";
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
	self.navigationItem.rightBarButtonItem = cancelButton;
	[cancelButton release];
	weightNameTextField.returnKeyType = UIReturnKeyDone; 
	weightNameTextField.delegate = self;
	
	float uiFontSize = 18.0f;
	
	weightNameTextField.font = [UIFont fontWithName:weightNameTextField.font.fontName size:uiFontSize];
	selectWeightButton.font = [UIFont boldSystemFontOfSize:uiFontSize];
	weightNameLabel.font = [UIFont boldSystemFontOfSize:uiFontSize];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[weightNameTextField resignFirstResponder];
	if ([textField.text length] > 0) {
		selectedWeight = [[Weight alloc] init];
		selectedWeight.friendlyName = textField.text;
		[weightPicker selectRow:0 inComponent:0 animated:YES];
	}
	return YES;
}

- (void)cancel:(id)sender {
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)selectWeight:(id)sender {
	if(nil == selectedWeight) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OOPS!" message:@"Please select a weight, or enter a new weight name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}	
	EditYarnViewController *editYarnViewController = [[EditYarnViewController alloc] initWithNibName:@"AddYarnView" bundle:nil];
	editYarnViewController.selectedBrand = selectedBrand;
	editYarnViewController.selectedWeight = selectedWeight;
	[self.navigationController pushViewController:editYarnViewController animated:YES];
	[editYarnViewController release];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	if (row == 0) {
		selectedWeight = nil;
		return;
	}
	[weightNameTextField setText:@""];
	selectedWeight = [weights objectAtIndex:row - 1];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [self.weights count] + 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (row == 0) {
		return nil;
	}
	return [[weights objectAtIndex:row - 1] friendlyName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
	selectedBrand = nil;
	[selectedBrand release];
	[weightNameLabel release];
	selectedWeight = nil;
	[selectedWeight release];
	[editingYarn release];
	[weightNameTextField release];
	[weights release];
	[selectWeightButton release];
	[weightPicker release];
    [super dealloc];
}

@end