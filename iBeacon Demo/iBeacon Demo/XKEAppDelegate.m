//
//  XKEAppDelegate.m
//  iBeacon Demo
//
//  Created by Robert van Loghem on 8/13/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import "XKEAppDelegate.h"
#import "XKEViewController.h"

@implementation XKEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[XKEViewController alloc] init]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}
							


@end
