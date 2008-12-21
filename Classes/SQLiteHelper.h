//
//  SQLiteHelper.h
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/1/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLiteHelper : NSObject {
	NSString *databaseName;
}

- (NSString *)databasePath;

@property (nonatomic, retain) NSString *databaseName;

@end