//
//  EditYarnViewController.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/14/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "EditYarnViewController.h"

@implementation EditYarnViewController

@synthesize selectedBrand, 
			selectedWeight, 
			selectedBrandLabel, 
			selectedWeightLabel, 
			saveYarnButton, 
			yarnNameTextField, 
			quantityTextField, 
			yarnNameLabel, 
			quantityLabel,
			quantityTypeLabel,
			brandNameLabel, 
			weightNameLabel,
			selectedQuantityType;

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

- (void)updateQuantityTypeLabelFrom:(float)quantity {
	BOOL usePlural = quantity == 0 || quantity > 1;
	if(selectedQuantityType == @"yard")
	{
		quantityTypeLabel.text = usePlural ? @"Yards" : @"Yard";
	}
	else if(selectedQuantityType == @"skein")
	{
		quantityTypeLabel.text = usePlural ? @"Skeins" : @"Skein";
	}
	else if(selectedQuantityType == @"ball")
	{
		quantityTypeLabel.text = usePlural ? @"Balls" : @"Ball";
	}	
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case 0:
		{
			selectedQuantityType = @"yard";
			break;
		}
		case 1:
		{
			selectedQuantityType = @"skein";
			break;
		}
		case 2:
		{
			selectedQuantityType = @"ball";
			break;
		}
		default:
			quantityTypeLabel.text = @"";
			break;
	}
	float quantity = (float)[[quantityTextField text] floatValue];
	[self updateQuantityTypeLabelFrom:quantity];
}

- (IBAction)chooseQuantityType:(id)sender {
	UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Yards",@"Skeins",@"Balls",nil];
	[sheet showInView:self.view];
	[sheet release];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {	
	[textField resignFirstResponder];
	if(textField.keyboardType == UIKeyboardTypeNumbersAndPunctuation) {
		float quantity = (float)[[textField text] floatValue];
		BOOL isFloat = abs(quantity) < quantity;
		NSString* number = isFloat ? [NSString stringWithFormat:@"%.1f", (float)[[textField text] floatValue]] : [NSString stringWithFormat:@"%d", (int)[[textField text] integerValue]];
		textField.text = number;
		[self updateQuantityTypeLabelFrom:quantity];
	}
	return YES;
}

- (IBAction)saveYarn:(id)sender {
	if(yarnNameTextField.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OOPS!" message:@"Please enter a yarn name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
	yarn.quantity = atof([quantityTextField.text UTF8String]);
	yarn.quantityType = selectedQuantityType;
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
	selectedWeight = nil;
	[selectedWeight release];
	selectedBrand = nil;
	[selectedBrand release];
	[quantityTextField release];
	[quantityTypeLabel release];
	[yarnNameTextField release];
	[saveYarnButton release];
	[selectedBrandLabel release];
	[selectedWeightLabel release];
	[selectedQuantityType release];
    [super dealloc];
}

@end