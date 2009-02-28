//
//  YarnCell.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 2/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "YarnCell.h"

@implementation YarnCell

@synthesize cell, yarnLabel, brandLabel, fiberLabel, weightLabel;

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
	}
	return self;
}

- (void)dealloc {
	[yarnLabel release];
	[brandLabel release];
	[fiberLabel release];
	[weightLabel release];
    [super dealloc];
}

@end
