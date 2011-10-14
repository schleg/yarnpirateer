//
//  Brand.h
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/1/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLiteHelper.h"
#import <sqlite3.h>
#import "Config.h"

@interface Brand : NSObject {
	NSString *name;
	NSString *friendlyName;
	BOOL selected;
	SQLiteHelper *_slh;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *friendlyName;

- (id)initWithName:(NSString *)_name;
- (id)initWithName:(NSString *)_name friendlyName:(NSString *)_friendlyName selected:(BOOL)selected;

- (BOOL)create;
- (BOOL)update;
- (BOOL)destroy;
- (void)read;
- (BOOL)isselected;
- (void)setIsselected:(BOOL)_selected;

+ (NSMutableArray *)all;

@end
