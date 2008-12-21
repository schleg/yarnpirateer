//
//  AddYarnViewController.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/14/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AddYarnViewController.h"

@implementation AddYarnViewController

@synthesize selectedBrand, 
			selectedWeight, 
			selectedBrandLabel, 
			selectedWeightLabel, 
			saveYarnButton, 
			yarnNameTextField, 
			quantityTextField, 
			yarnNameLabel, 
			quantityLabel, 
			brandNameLabel, 
			weightNameLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Add Yarn";
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
	self.navigationItem.rightBarButtonItem = cancelButton;
	[cancelButton release];
	
	selectedBrandLabel.text = selectedBrand.friendlyName;
	selectedWeightLabel.text = selectedWeight.friendlyName;
	
	yarnNameTextField.returnKeyType = UIReturnKeyDone; 
	yarnNameTextField.delegate = self;
	
	quantityTextField.returnKeyType = UIReturnKeyDone; 
	quantityTextField.delegate = self;
	
	float uiFontSize = 18.0f;
	
	saveYarnButton.font = [UIFont boldSystemFontOfSize:uiFontSize];
	
	yarnNameTextField.font = [UIFont fontWithName:[yarnNameTextField.font familyName] size:uiFontSize];	
	quantityTextField.font = [UIFont fontWithName:[quantityTextField.font familyName] size:uiFontSize];
	
	yarnNameLabel.font = [UIFont boldSystemFontOfSize:uiFontSize];
	quantityLabel.font = [UIFont boldSystemFontOfSize:uiFontSize];
	brandNameLabel.font = [UIFont boldSystemFontOfSize:uiFontSize];
	weightNameLabel.font = [UIFont boldSystemFontOfSize:uiFontSize];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {	
	[textField resignFirstResponder];
	if(textField.keyboardType == UIKeyboardTypeNumbersAndPunctuation) {
		NSInteger *quantity = (NSInteger *)[[textField text] integerValue];
		textField.text = [NSString stringWithFormat:@"%d", quantity];
	}
	return YES;
}

- (IBAction)saveYarn:(id)sender {
	if(yarnNameTextField.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OOPS!" message:@"Please enter a brand name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	
	CFUUIDRef uuidObj = CFUUIDCreate(nil);
	NSString *brandUUID = (NSString*)CFUUIDCreateString(nil, uuidObj);
	NSString *weightUUID = (NSString*)CFUUIDCreateString(nil, uuidObj);
	CFRelease(uuidObj);
	
	Yarn *yarn = [[Yarn alloc] init];
	yarn.name = yarnNameTextField.text;
	if([selectedBrand.name length] == 0) {
		selectedBrand = [[Brand alloc] initWithName:brandUUID friendlyName:selectedBrand.friendlyName selected:YES];
		[selectedBrand create];
	}
	
	yarn.brand = selectedBrand;
	[brandUUID release];
	if([selectedWeight.name length] == 0) {
		selectedWeight = [[Weight alloc] initWithName:weightUUID friendlyName:selectedWeight.friendlyName selected:YES];
		[selectedWeight create];
	}

	[selectedBrand setIsselected:YES];
	[selectedBrand update];
	
	[selectedWeight setIsselected:YES];
	[selectedWeight update];	
	
	yarn.weight = selectedWeight;
	[weightUUID release];
	yarn.quantity = atoi([quantityTextField.text UTF8String]);
	[yarn create];
	[yarn release];
	[self.tabBarController setSelectedIndex:0];
}

- (void)cancel:(id)sender {
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
	[weightNameLabel release];
	[quantityLabel release];
	[brandNameLabel release];
	[yarnNameLabel release];
	[selectedWeight release];
	[selectedBrand release];
	[quantityTextField release];
	[yarnNameTextField release];
	[saveYarnButton release];
	[selectedBrandLabel release];
	[selectedWeightLabel release];
    [super dealloc];
}

@end