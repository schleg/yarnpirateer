//
//  YarnCell.h
//  YarnPirateer
//
//  Created by Tyler Schlegel on 1/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YarnCell : NSObject {
	IBOutlet UITableViewCell *cell;	
}

+ (YarnCell *)cellWithName:(NSString *)name;

- (id)initCellWithName:(NSString *)name;

@property (nonatomic, retain) UITableViewCell *cell;

@end
