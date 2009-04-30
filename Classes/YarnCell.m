//
//  YarnCell.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 2/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "YarnCell.h"

@implementation YarnCell

@synthesize cell, yarnLabel, brandLabel, fiberLabel, weightLabel, quantityLabel;

+ (YarnCell *)yarnCellWithYarn:(Yarn *)yarn nibName:(NSString *)name {
	return [[[self alloc] initYarnCellWithYarn:yarn nibName:name] autorelease];
}

- (id)initYarnCellWithYarn:(Yarn *)yarn nibName:(NSString *)name {
	self = [super init];
	if(nil != self) {
		[[NSBundle mainBundle] loadNibNamed:name owner:self options:nil];
		self.yarnLabel.text = yarn.name;
		self.fiberLabel.text = @"Blue-Faced Leicester and Stuff";
		self.weightLabel.text = yarn.weight.friendlyName;
		self.brandLabel.text = yarn.brand.friendlyName;
		
		BOOL isFloat = abs(yarn.quantity) < yarn.quantity;
		NSString* number = isFloat ? [NSString stringWithFormat:@"%.1f", yarn.quantity] : [NSString stringWithFormat:@"%d", (int)yarn.quantity];
		
		NSString* quantityType = [NSString stringWithFormat:@""];
		BOOL usePlural = yarn.quantity == 0 || yarn.quantity > 1;
		if([yarn.quantityType isEqualToString:@"yard"])
		{
			quantityType = usePlural ? @"Yards" : @"Yard";
		}
		else if([yarn.quantityType isEqualToString:@"skein"])
		{
			quantityType = usePlural ? @"Skeins" : @"Skein";
		}
		else if([yarn.quantityType isEqualToString:@"ball"])
		{
			quantityType = usePlural ? @"Balls" : @"Ball";
		}

		self.quantityLabel.text = [NSString stringWithFormat:@"%@ %@", number, quantityType];
	}
	return self;
}

- (void)dealloc {
	[quantityLabel release];
	[yarnLabel release];
	[brandLabel release];
	[fiberLabel release];
	[weightLabel release];
    [super dealloc];
}

@end
