//
//  Brand.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/1/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Brand.h"

@implementation Brand

@synthesize name, friendlyName;

- (id)initWithName:(NSString *)_name {
	if(nil != [super init]) {
		_slh = [[SQLiteHelper alloc] initWithName:[Config databaseName]];
		name = [_name retain];
		[self read];
	}
	return self;	
}

- (BOOL)isselected {
	return selected;
}

- (id)initWithName:(NSString *)_name friendlyName:(NSString *)_friendlyName selected:(BOOL)_selected {
	if(nil != [super init]) {
		_slh = [[SQLiteHelper alloc] initWithName:[Config databaseName]];
		name = [_name retain];
		[name retain];
		friendlyName = [_friendlyName retain];
		selected = _selected;
	}
	return self;
}

- (BOOL)create {
	BOOL retval = [_slh insertUsingSQLTemplate:"INSERT INTO brand (name, friendlyName) VALUES (?,?)" andValues:[NSArray arrayWithObjects:name, friendlyName, nil]];
	return retval;
}

- (void)setIsselected:(BOOL)_selected {
	sqlite3 *database;
	NSString *databasePath = [[_slh databasePath] retain];
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		//NSLog(@"Opened database: %@", databasePath);
		sqlite3_stmt *updateStatement;
		const char *sql = "UPDATE brand SET selected =? WHERE name=?";
		int prepared = sqlite3_prepare(database, sql, -1, &updateStatement, NULL);
		if(SQLITE_OK == prepared) {
			sqlite3_bind_int(updateStatement, 1, _selected);
			sqlite3_bind_text(updateStatement, 2, [name UTF8String], -1, SQLITE_TRANSIENT);
			if(SQLITE_DONE != sqlite3_step(updateStatement))
			{
				NSAssert1(0, @"Failed to update: %s", sqlite3_errmsg(database));
			}

			sqlite3_finalize(updateStatement);

		} else {
			NSAssert1(0, @"Failed to prepare: %s", sqlite3_errmsg(database));
		}
	}
	sqlite3_close(database);
	//NSLog(@"Closed database: %@", databasePath);
	[databasePath release];
}

+ (NSMutableArray *)all {
	NSMutableArray *retval = [[[NSMutableArray alloc] init] autorelease];
	SQLiteHelper *_slh = [[SQLiteHelper alloc] initWithName:[Config databaseName]];
	sqlite3 *database;
	NSString *databasePath = [[_slh databasePath] retain];
	if (SQLITE_OK == sqlite3_open([databasePath UTF8String], &database)) {
		//NSLog(@"Opened database: %@", databasePath);
		sqlite3_stmt *selectStatement;
		const char *sql = "SELECT name, friendlyName, selected FROM brand";
		int prepared = sqlite3_prepare(database, sql, -1, &selectStatement, NULL);
		if (SQLITE_OK == prepared) {
			while(SQLITE_ROW == sqlite3_step(selectStatement))
			{
				char *nameResult = (char *)sqlite3_column_text(selectStatement, 0);
				NSString *name = (nameResult) ? [[NSString stringWithUTF8String:nameResult] retain] : @"";
				
				char *friendlyNameResult = (char *)sqlite3_column_text(selectStatement, 1);
				NSString *friendlyName = (friendlyNameResult) ? [[NSString stringWithUTF8String:friendlyNameResult] retain] : @"";
				
				char *selectedResult = (char *)sqlite3_column_text(selectStatement, 2);
				BOOL selected = NO;
				if(nil != selectedResult) {
					selected = atoi(selectedResult) == 1 ? YES : NO;
				}

				Brand *brand = [[Brand alloc] initWithName:name friendlyName:friendlyName selected:selected];
				[retval addObject:brand];
				[brand release];
			}

			sqlite3_finalize(selectStatement);

		}
		else {
			NSAssert1(0, @"Failed to prepare: %s", sqlite3_errmsg(database));
		}
	}
	sqlite3_close(database);
	//NSLog(@"Closed database: %@", databasePath);
	[databasePath release];
	[_slh release];
	return retval;
}

- (void)read {
	sqlite3 *database;
	NSString *databasePath = [[_slh databasePath] retain];
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		//NSLog(@"Opened database: %@", databasePath);
		sqlite3_stmt *selectStatement;
		const char *sql = "SELECT friendlyName, selected FROM brand WHERE name =?";
		int prepared = sqlite3_prepare(database, sql, -1, &selectStatement, NULL);
		if(SQLITE_OK == prepared) {
			sqlite3_bind_text(selectStatement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
			if(SQLITE_ROW != sqlite3_step(selectStatement))
			{
				NSAssert1(0, @"Failed to select: %s", sqlite3_errmsg(database));
			}

			const char *friendlyNameResult = (char *)sqlite3_column_text(selectStatement, 0);
			friendlyName = (friendlyNameResult) ? [[NSString stringWithUTF8String:friendlyNameResult] retain] : @"";
			
			const char *selectedResult = (char *)sqlite3_column_text(selectStatement, 1);
			if(nil != selectedResult) {
				selected = atoi(selectedResult) == 1 ? YES : NO;
			}
			
			sqlite3_finalize(selectStatement);

		}
		else {
			NSAssert1(0, @"Failed to prepare: %s", sqlite3_errmsg(database));
		}
	}
	sqlite3_close(database);
	//NSLog(@"Closed database: %@", databasePath);
	[databasePath release];
}

- (BOOL)update {
	BOOL retval = [_slh updateUsingSQLTemplate:"UPDATE brand SET friendlyName =? WHERE name=?" andValues:[NSArray arrayWithObjects:friendlyName, name, nil]];
	return retval;
}

- (BOOL)destroy {
	BOOL retval = [_slh deleteUsingSQLTemplate:"DELETE FROM brand WHERE name=?" andValues:[NSArray arrayWithObjects:name,nil]];
	return retval;
}

- (void)dealloc {
	[name release];
	[friendlyName release];
	[_slh release];
	[super dealloc];
}

@end
