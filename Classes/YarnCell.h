//
//  YarnCell.h
//  YarnPirateer
//
//  Created by Tyler Schlegel on 1/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Yarn.h"

@interface YarnCell : NSObject {
	IBOutlet UITableViewCell *cell;	
	IBOutlet UILabel *nameLabel;
	IBOutlet UILabel *brandLabel;
	IBOutlet UILabel *weightLabel;
}

+ (YarnCell *)cellWithYarn:(Yarn *)yarn;

- (id)initCellWithYarn:(Yarn *)yarn;

@property (nonatomic, retain) UITableViewCell *cell;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *brandLabel;
@property (nonatomic, retain) UILabel *weightLabel;

@end
