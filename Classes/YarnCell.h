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
	IBOutlet UILabel *yarnLabel;
	IBOutlet UILabel *fiberLabel;
	IBOutlet UILabel *weightLabel;
	IBOutlet UILabel *brandLabel;
}

+ (YarnCell *)yarnCellWithYarn:(Yarn *)yarn nibName:(NSString *)name;

- (id)initYarnCellWithYarn:(Yarn *)yarn nibName:(NSString *)name;

@property (nonatomic, retain) UITableViewCell *cell;
@property (nonatomic, retain) UILabel *yarnLabel;
@property (nonatomic, retain) UILabel *fiberLabel;
@property (nonatomic, retain) UILabel *weightLabel;
@property (nonatomic, retain) UILabel *brandLabel;

@end
