//
//  Yarn.h
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/2/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Brand.h"
#import "Weight.h"

@interface Yarn : NSObject {
	Brand *brand;
	Weight *weight;
	NSString *name;
	NSString *description;
	float quantity;
	NSString *quantityType;
	SQLiteHelper *_slh;
	int pk;
}

@property (nonatomic, retain) Brand *brand;
@property (nonatomic, retain) Weight *weight;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, readwrite) float quantity;
@property (nonatomic, retain) NSString *quantityType;

- (id)initWithPK:(int)_pk;

- (BOOL)create;
- (BOOL)update;
- (BOOL)delete;
- (void)read;

+ (NSMutableArray *)all;
+ (NSMutableArray *)byBrand:(NSString *)_name;
+ (NSMutableArray *)byWeight:(NSString *)_name;

@end
