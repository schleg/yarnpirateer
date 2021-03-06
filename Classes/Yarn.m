//
//  Yarn.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/2/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Yarn.h"

@implementation Yarn

@synthesize brand, weight, fiber, name, description, quantity, quantityType;

- (id)initWithPK:(int)_pk {
	if(nil != [super init]) {
		_slh = [[SQLiteHelper alloc] initWithName:[Config databaseName]];
		pk = _pk;
		[self read];
	}
	return self;
}

- (id)init {
	if(nil != [super init]) {
		_slh = [[SQLiteHelper alloc] initWithName:[Config databaseName]];
	}
	return self;	
}

- (BOOL)create {
	BOOL retval = NO;
	sqlite3 *database;
	NSString *databasePath = [[_slh databasePath] retain];
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		//NSLog(@"Opened database: %@", databasePath);
		sqlite3_stmt *insertStatement;
		const char *sql = "INSERT INTO yarn (brandName, weightName, fiberName, name, description, quantity, quantity_type) VALUES (?,?,?,?,?,?,?)";
		int prepared = sqlite3_prepare(database, sql, -1, &insertStatement, NULL);
		if(SQLITE_OK == prepared) {
			sqlite3_bind_text(insertStatement, 1, [[brand name] UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(insertStatement, 2, [[weight name] UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(insertStatement, 3, [[fiber name] UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(insertStatement, 4, [name UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(insertStatement, 5, [description UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_double(insertStatement, 6, quantity);
			sqlite3_bind_text(insertStatement, 7, [quantityType UTF8String], -1, SQLITE_TRANSIENT);
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

+ (NSMutableArray *)byBrand:(NSString *)_name {
	NSMutableArray *retval = [[[NSMutableArray alloc] init] autorelease];
	SQLiteHelper *_slh = [[SQLiteHelper alloc] initWithName:[Config databaseName]];
	sqlite3 *database;
	NSString *databasePath = [[_slh databasePath] retain];
	if (SQLITE_OK == sqlite3_open([databasePath UTF8String], &database)) {
		//NSLog(@"Opened database: %@", databasePath);
		sqlite3_stmt *selectStatement;
		const char *sql = "SELECT pk FROM yarn WHERE brandName =?";
		int prepared = sqlite3_prepare(database, sql, -1, &selectStatement, NULL);
		if (SQLITE_OK == prepared) {
			sqlite3_bind_text(selectStatement, 1, [_name UTF8String], -1, SQLITE_TRANSIENT);
			while(SQLITE_ROW == sqlite3_step(selectStatement))
			{
				char *pkResult = (char *)sqlite3_column_text(selectStatement, 0);
				Yarn *yarn = [[Yarn alloc] initWithPK:atoi(pkResult)];
				[retval addObject:yarn];
				[yarn release];
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

+ (NSMutableArray *)byFiber:(NSString *)_name {
	NSMutableArray *retval = [[[NSMutableArray alloc] init] autorelease];
	SQLiteHelper *_slh = [[SQLiteHelper alloc] initWithName:[Config databaseName]];
	sqlite3 *database;
	NSString *databasePath = [[_slh databasePath] retain];
	if (SQLITE_OK == sqlite3_open([databasePath UTF8String], &database)) {
		//NSLog(@"Opened database: %@", databasePath);
		sqlite3_stmt *selectStatement;
		const char *sql = "SELECT pk FROM yarn WHERE fiberName =?";
		int prepared = sqlite3_prepare(database, sql, -1, &selectStatement, NULL);
		if (SQLITE_OK == prepared) {
			sqlite3_bind_text(selectStatement, 1, [_name UTF8String], -1, SQLITE_TRANSIENT);
			while(SQLITE_ROW == sqlite3_step(selectStatement))
			{
				char *pkResult = (char *)sqlite3_column_text(selectStatement, 0);
				Yarn *yarn = [[Yarn alloc] initWithPK:atoi(pkResult)];
				[retval addObject:yarn];
				[yarn release];
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

+ (NSMutableArray *)byWeight:(NSString *)_name {
	NSMutableArray *retval = [[[NSMutableArray alloc] init] autorelease];
	SQLiteHelper *_slh = [[SQLiteHelper alloc] initWithName:[Config databaseName]];
	sqlite3 *database;
	NSString *databasePath = [[_slh databasePath] retain];
	if (SQLITE_OK == sqlite3_open([databasePath UTF8String], &database)) {
		//NSLog(@"Opened database: %@", databasePath);
		sqlite3_stmt *selectStatement;
		const char *sql = "SELECT pk FROM yarn WHERE weightName =?";
		int prepared = sqlite3_prepare(database, sql, -1, &selectStatement, NULL);
		if (SQLITE_OK == prepared) {
			sqlite3_bind_text(selectStatement, 1, [_name UTF8String], -1, SQLITE_TRANSIENT);
			while(SQLITE_ROW == sqlite3_step(selectStatement))
			{
				char *pkResult = (char *)sqlite3_column_text(selectStatement, 0);
				Yarn *yarn = [[Yarn alloc] initWithPK:atoi(pkResult)];
				[retval addObject:yarn];
				[yarn release];
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

+ (NSMutableArray *)all {
	NSMutableArray *retval = [[[NSMutableArray alloc] init] autorelease];
	SQLiteHelper *_slh = [[SQLiteHelper alloc] initWithName:[Config databaseName]];
	sqlite3 *database;
	NSString *databasePath = [[_slh databasePath] retain];
	if (SQLITE_OK == sqlite3_open([databasePath UTF8String], &database)) {
		//NSLog(@"Opened database: %@", databasePath);
		sqlite3_stmt *selectStatement;
		const char *sql = "SELECT pk FROM yarn";
		int prepared = sqlite3_prepare(database, sql, -1, &selectStatement, NULL);
		if (SQLITE_OK == prepared) {
			while(SQLITE_ROW == sqlite3_step(selectStatement))
			{
				char *pkResult = (char *)sqlite3_column_text(selectStatement, 0);
				Yarn *yarn = [[Yarn alloc] initWithPK:atoi(pkResult)];
				[retval addObject:yarn];
				[yarn release];
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
		const char *sql = "SELECT brandName, weightName, fiberName, name, description, quantity, quantity_type FROM yarn WHERE pk =?";
		int prepared = sqlite3_prepare(database, sql, -1, &selectStatement, NULL);
		if(SQLITE_OK == prepared) {
			sqlite3_bind_int(selectStatement, 1, pk);
			if(SQLITE_ROW != sqlite3_step(selectStatement))
			{
				NSAssert1(0, @"Failed to select: %s", sqlite3_errmsg(database));
			}

			const char *brandNameResult = (char *)sqlite3_column_text(selectStatement, 0);
			NSString *brandName = (brandNameResult) ? [NSString stringWithUTF8String:brandNameResult] : @"";
			brand = [[[Brand alloc] initWithName:brandName] retain];
			
			const char *weightNameResult = (char *)sqlite3_column_text(selectStatement, 1);
			NSString *weightName = (weightNameResult) ? [NSString stringWithUTF8String:weightNameResult] : @"";
			weight = [[[Weight alloc] initWithName:weightName] retain];

			const char *fiberNameResult = (char *)sqlite3_column_text(selectStatement, 2);
			NSString *fiberName = (fiberNameResult) ? [NSString stringWithUTF8String:fiberNameResult] : @"";
			fiber = [[[Fiber alloc] initWithName:fiberName] retain];
			
			const char *nameResult = (char *)sqlite3_column_text(selectStatement, 3);
			name = (nameResult) ? [[NSString stringWithUTF8String:nameResult] retain] : @"";

			const char *descriptionResult = (char *)sqlite3_column_text(selectStatement, 4);
			description = (descriptionResult) ? [[NSString stringWithUTF8String:descriptionResult] retain] : @"";

			const char *quantityResult = (char *)sqlite3_column_text(selectStatement, 5);
			quantity = (quantityResult) ? atof(quantityResult) : 0;
			
			const char *quantityTypeResult = (char *)sqlite3_column_text(selectStatement, 6);
			quantityType = (quantityTypeResult) ? [[NSString stringWithUTF8String:quantityTypeResult] retain] : @"";
			
			sqlite3_finalize(selectStatement);
			
			//[brandName release];
			//[weightName release];
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
	BOOL retval = NO;
	sqlite3 *database;
	NSString *databasePath = [[_slh databasePath] retain];
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		//NSLog(@"Opened database: %@", databasePath);
		sqlite3_stmt *updateStatement;
		const char *sql = "UPDATE yarn SET brandName =?, weightName =?, fiberName =?, name =?, description =?, quantity =?, quantity_type =? WHERE pk=?";
		int prepared = sqlite3_prepare(database, sql, -1, &updateStatement, NULL);
		if(SQLITE_OK == prepared) {
			sqlite3_bind_text(updateStatement, 1, [[brand name] UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(updateStatement, 2, [[weight name] UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(updateStatement, 3, [[fiber name] UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(updateStatement, 4, [name UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(updateStatement, 5, [description UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_int(updateStatement, 6, quantity);
			sqlite3_bind_text(updateStatement, 7, [quantityType UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_int(updateStatement, 8, pk);
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

- (BOOL)delete {
	BOOL retval = NO;
	sqlite3 *database;
	NSString *databasePath = [[_slh databasePath] retain];
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		//NSLog(@"Opened database: %@", databasePath);
		sqlite3_stmt *deleteStatement;
		const char *sql = "DELETE FROM yarn WHERE pk=?";
		if(sqlite3_prepare(database, sql, -1, &deleteStatement, NULL) == SQLITE_OK) {
			sqlite3_bind_int(deleteStatement, 1, pk);
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
	[name release];
	[description release];
	[brand release];
	[weight release];
	[fiber release];
	[quantityType release];
	[_slh release];
	[super dealloc];
}

@end