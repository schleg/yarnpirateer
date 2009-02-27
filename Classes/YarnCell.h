//
//  YarnCell.h
//  YarnPirateer
//
//  Created by Tyler Schlegel on 2/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Yarn.h";

@interface YarnCell : NSObject {
	IBOutlet UITableViewCell *cell;
	IBOutlet UILabel *nameLabel;
	IBOutlet UILabel *fiberLabel;
	IBOutlet UILabel *weightLabel;
}

+ (YarnCell *)yarnCellWithYarn:(Yarn *)yarn;

- (id)initYarnCellWithYarn:(Yarn *)yarn;

@property (nonatomic, retain) UITableViewCell *cell;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *fiberLabel;
@property (nonatomic, retain) UILabel *weightLabel;

@end
