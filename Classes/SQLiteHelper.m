//
//  SQLiteHelper.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/1/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "SQLiteHelper.h"

@implementation SQLiteHelper

@synthesize databaseName;

- (NSString *)databasePath {
	NSString *retval;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	retval = [documentsDirectory stringByAppendingPathComponent:databaseName];
	//NSLog(@"Database path: %", retval);
	return retval;
}

- (id)initWithName:(NSString *)_databaseName {
	if(nil != [super init]) {
		databaseName = [_databaseName retain];
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString *documentsPath = [documentsDirectory stringByAppendingPathComponent:databaseName];
		//NSLog(@"Documents path for database: %@", documentsPath);
		NSFileManager *fileManager = [NSFileManager defaultManager];
		NSError *error;
		NSString *packagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
		//NSLog(@"Package path for database: %@", packagePath);
		if(![fileManager fileExistsAtPath:documentsPath]) {
			if(![fileManager copyItemAtPath:packagePath toPath:documentsPath error:&error]) {				
				NSAssert1(0, @"Database from package to documents directory failed: %@", [error localizedDescription]);
			} else {
				//NSLog(@"Copied database to '%@'", documentsPath);
			}
		} else {
			//NSLog(@"Database exists in documents folder");
		}
	}
	return self;
}

- (void)dealloc {
	[databaseName release];
	[super dealloc];
}

@end