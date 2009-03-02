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

- (BOOL)insertUsingSQLTemplate:(const char *)sql andValues:(NSArray *)values {
	BOOL retval = NO;
	sqlite3 *database;
	NSString *databasePath = [[self databasePath] retain];
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		//NSLog(@"Opened database: %@", databasePath);
		sqlite3_stmt *insertStatement;
		//const char *sql = "INSERT INTO weight (name, friendlyName) VALUES (?,?)";
		int prepared = sqlite3_prepare(database, sql, -1, &insertStatement, NULL);
		if(SQLITE_OK == prepared) {
			//sqlite3_bind_text(insertStatement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
			//sqlite3_bind_text(insertStatement, 2, [friendlyName UTF8String], -1, SQLITE_TRANSIENT);
			for(int i=0;i<[values count];i++) {
				sqlite3_bind_text(insertStatement, i+1, [[values objectAtIndex:i] UTF8String], -1, SQLITE_TRANSIENT);	
			}
			if(SQLITE_DONE != sqlite3_step(insertStatement))
			{
				NSAssert1(0, @"Failed to insert: %s", sqlite3_errmsg(database));
			}
			
			retval = sqlite3_finalize(insertStatement) == 0;
			
		} else {
			NSAssert1(0, @"Failed to prepare: %s", sqlite3_errmsg(database));
		}
	}
	sqlite3_close(database);
	//NSLog(@"Closed database: %@", databasePath);
	[databasePath release];
	return retval;
}

- (BOOL)updateUsingSQLTemplate:(const char *)sql andValues:(NSArray *)values {
	BOOL retval = NO;
	sqlite3 *database;
	NSString *databasePath = [[self databasePath] retain];
	if (SQLITE_OK == sqlite3_open([databasePath UTF8String], &database)) {
		//NSLog(@"Opened database: %@", databasePath);
		sqlite3_stmt *updateStatement;
		int prepared = sqlite3_prepare(database, sql, -1, &updateStatement, NULL);
		if(SQLITE_OK == prepared) {
			//sqlite3_bind_text(updateStatement, 1, [friendlyName UTF8String], -1, SQLITE_TRANSIENT);
			//sqlite3_bind_text(updateStatement, 2, [name UTF8String], -1, SQLITE_TRANSIENT);
			for(int i=0;i<[values count];i++) {
				sqlite3_bind_text(updateStatement, i+1, [[values objectAtIndex:i] UTF8String], -1, SQLITE_TRANSIENT);	
			}
			if(SQLITE_DONE != sqlite3_step(updateStatement))
			{
				NSAssert1(0, @"Failed to update: %s", sqlite3_errmsg(database));
			}
			
			retval = sqlite3_finalize(updateStatement) == 0;
			
		} else {
			NSAssert1(0, @"Failed to prepare: %s", sqlite3_errmsg(database));
		}
	}
	sqlite3_close(database);
	//NSLog(@"Closed database: %@", databasePath);
	[databasePath release];
	return retval;
}

- (BOOL)deleteUsingSQLTemplate:(const char *)sql andValues:(NSArray *)values {
	BOOL retval = NO;
	sqlite3 *database;
	NSString *databasePath = [[self databasePath] retain];
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		//NSLog(@"Opened database: %@", databasePath);
		sqlite3_stmt *deleteStatement;
		//const char *sql = "DELETE FROM brand WHERE name=?";
		if(sqlite3_prepare(database, sql, -1, &deleteStatement, NULL) == SQLITE_OK) {
			//sqlite3_bind_text(deleteStatement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
			for(int i=0;i<[values count];i++) {
				sqlite3_bind_text(deleteStatement, i+1, [[values objectAtIndex:i] UTF8String], -1, SQLITE_TRANSIENT);	
			}
			if(SQLITE_DONE != sqlite3_step(deleteStatement))
			{
				NSAssert1(0, @"Failed to delete: %s", sqlite3_errmsg(database));
			}
			
			retval = sqlite3_finalize(deleteStatement) == 0;
			
		}	
	}
	sqlite3_close(database);
	//NSLog(@"Closed database: %@", databasePath);
	[databasePath release];
	return retval;
}

- (void)dealloc {
	[databaseName release];
	[super dealloc];
}

@end