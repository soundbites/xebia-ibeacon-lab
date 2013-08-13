//
//  XKEViewController.m
//  iBeacon-Client
//
//  Created by Rajdeep Mann on 13/08/13.
//  Copyright (c) 2013 Rajdeep Mann. All rights reserved.
//

#import "XKEViewController.h"

@interface XKEViewController (){
    NSUUID *_uuid;
    NSNumber *_major;
    NSNumber *_minor;
}
@property (nonatomic, strong) CLBeaconRegion * beaconRegion;
@property (nonatomic, strong) CLLocationManager * locationManager;
@end

@implementation XKEViewController

- (IBAction)didTapStartButton:(id)sender{
    self.locationImageView.image = [UIImage imageNamed:@"location-on"];
}

- (CLLocationManager *)locationManager{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

-(CLBeaconRegion *)beaconRegion{
    if (_beaconRegion == nil) {
        _beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:_uuid major:[_major shortValue] minor:[_minor shortValue] identifier:@"com.apple.AirLocate"];
    }
    return _beaconRegion;
}

- (void)startMonitoringBeacon{
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
}


@end
