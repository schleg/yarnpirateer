//
//  YarnCell.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 2/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "YarnCell.h"

@implementation YarnCell

@synthesize cell, nameLabel, fiberLabel, weightLabel;

+ (YarnCell *)yarnCellWithYarn:(Yarn *)yarn {
	return [[[self alloc] initYarnCellWithYarn:yarn] autorelease];
}

- (id)initYarnCellWithYarn:(Yarn *)yarn {
	self = [super init];
	if(nil != self) {
		[[NSBundle mainBundle] loadNibNamed:@"SortedByBrandCell" owner:self options:nil];
		self.nameLabel.text = yarn.name;
		self.fiberLabel.text = @"Blue-Faced Leicester and Stuff";
		self.weightLabel.text = yarn.weight.friendlyName;
	}
	return self;
}

- (void)dealloc {
	[nameLabel release];
	[fiberLabel release];
	[weightLabel release];
    [super dealloc];
}

@end
