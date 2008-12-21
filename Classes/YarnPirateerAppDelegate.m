//
//  YarnPirateerAppDelegate.m
//  YarnPirateer
//
//  Created by Tyler Schlegel on 12/7/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "YarnPirateerAppDelegate.h"


@implementation YarnPirateerAppDelegate

@synthesize window;
@synthesize tabBarController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    [window addSubview:tabBarController.view];
}

- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end