//
//  YarnCell.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 1/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "YarnCell.h"

@implementation YarnCell

@synthesize cell;

+ (YarnCell *)cellWithName:(NSString *)name {
	return [[[self alloc] initCellWithName:name] autorelease];
}

- (id)initCellWithName:(NSString *)name {
	self = [super init];
	if(nil != self) {
		[[NSBundle mainBundle] loadNibNamed:@"YarnCell" owner:self options:nil];
	}
	return self	;
}

@end