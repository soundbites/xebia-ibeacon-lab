//
//  XKEViewController.h
//  iBeacon Demo
//
//  Created by Robert van Loghem on 8/13/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class XKEPerson;

@interface XKEViewController : UIViewController <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, CLLocationManagerDelegate>

- (void)start;

- (void)stop;
@end
