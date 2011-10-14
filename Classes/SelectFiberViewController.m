//
//  SelectBrandView.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "SelectFiberViewController.h"

@implementation SelectFiberViewController

@synthesize selectFiberButton, fiberPicker, fibers, selectedFiber, selectedWeight, selectedBrand, fiberNameTextField, fiberNameLabel;

- (NSMutableArray *)fibers {
	if(nil == fibers) {
		self.fibers = [Fiber all];
	}
	return fibers;
}

- (void)viewWillAppear:(BOOL)animated {
	self.fibers = nil;
	[fiberPicker reloadAllComponents];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Select Fiber";
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
	self.navigationItem.rightBarButtonItem = cancelButton;
	[cancelButton release];
	fiberNameTextField.returnKeyType = UIReturnKeyDone; 
	fiberNameTextField.delegate = self;
	
	float uiFontSize = 18.0f;
	
	fiberNameTextField.font = [UIFont fontWithName:fiberNameTextField.font.fontName size:uiFontSize];
	selectFiberButton.titleLabel.font = [UIFont boldSystemFontOfSize:uiFontSize];
	fiberNameLabel.font = [UIFont boldSystemFontOfSize:uiFontSize];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[fiberNameTextField resignFirstResponder];
	if ([textField.text length] > 0) {
		selectedFiber = [[Fiber alloc] init];
		selectedFiber.friendlyName = textField.text;
		[fiberPicker selectRow:0 inComponent:0 animated:YES];
	}
	return YES;
}

- (void)cancel:(id)sender {
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)selectFiber:(id)sender {
	if(nil == selectedFiber) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OOPS!" message:@"Please select a fiber, or enter a new fiber name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}	
	EditYarnViewController *editYarnViewController = [[EditYarnViewController alloc] initWithNibName:@"AddYarnView" bundle:nil];
	editYarnViewController.selectedBrand = selectedBrand;
	editYarnViewController.selectedWeight = selectedWeight;
	editYarnViewController.selectedFiber = selectedFiber;
	[self.navigationController pushViewController:editYarnViewController animated:YES];
	[editYarnViewController release];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	if (row == 0) {
		selectedFiber = nil;
		return;
	}
	[fiberNameTextField setText:@""];
	selectedFiber = [fibers objectAtIndex:row - 1];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [self.fibers count] + 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (row == 0) {
		return nil;
	}
	return [[fibers objectAtIndex:row - 1] friendlyName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
	selectedBrand = nil;
	[selectedBrand release];
	selectedWeight = nil;
	[selectedWeight release];
	[fiberNameLabel release];
	selectedFiber = nil;
	[selectedFiber release];
	[fiberNameTextField release];
	[fibers release];
	[selectFiberButton release];
	[fiberPicker release];
    [super dealloc];
}

@end