//
//  SQLiteHelper.h
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/1/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Config.h"

@interface SQLiteHelper : NSObject {
	NSString *databaseName;
}

- (NSString *)databasePath;
- (BOOL)insertUsingSQLTemplate:(const char *)sql andValues:(NSArray *)values;
- (BOOL)updateUsingSQLTemplate:(const char *)sql andValues:(NSArray *)values;
- (BOOL)deleteUsingSQLTemplate:(const char *)sql andValues:(NSArray *)values;

@property (nonatomic, retain) NSString *databaseName;

@end