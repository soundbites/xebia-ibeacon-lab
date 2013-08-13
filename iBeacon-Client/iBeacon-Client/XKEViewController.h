//
//  XKEViewController.h
//  iBeacon-Client
//
//  Created by Rajdeep Mann on 13/08/13.
//  Copyright (c) 2013 Rajdeep Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface XKEViewController : UIViewController<CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UIButton * startButton;
@property (strong, nonatomic) IBOutlet UIImageView * locationImageView;

- (IBAction)didTapStartButton:(id)sender;

@end
