//
//  XKEAppDelegate.m
//  iBeacon Demo
//
//  Created by Robert van Loghem on 8/13/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import "XKEAppDelegate.h"
#import "XKEViewController.h"

@implementation XKEAppDelegate {
    XKEViewController *_rootViewController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _rootViewController = [[XKEViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_rootViewController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [_rootViewController start];

}

- (void)applicationWillResignActive:(UIApplication *)application {

    [_rootViewController stop];


}


@end
