//
//  YarnCell.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 1/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "YarnCell.h"

@implementation YarnCell

@synthesize cell, nameLabel, brandLabel, weightLabel;

+ (YarnCell *)cellWithYarn:(Yarn *)yarn {
	return [[[self alloc] initCellWithYarn:yarn] autorelease];
}

- (id)initCellWithYarn:(Yarn *)yarn {
	self = [super init];
	if(nil != self) {
		[[NSBundle mainBundle] loadNibNamed:@"YarnCell" owner:self options:nil];
		
		nameLabel.text = yarn.name;
		nameLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:21.0f];

		brandLabel.text = yarn.brand.friendlyName;
		brandLabel.font = [UIFont fontWithName:@"Helvetica" size:11.0f];
		
		weightLabel.text = yarn.weight.friendlyName;
		weightLabel.font = [UIFont fontWithName:@"Helvetica" size:11.0f];
	}
	return self;
}

- (void)dealloc {
	[nameLabel release];
	[brandLabel release];
	[weightLabel release];
	[super dealloc];
}

@end