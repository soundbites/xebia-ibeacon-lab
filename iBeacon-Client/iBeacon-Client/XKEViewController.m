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
    NSNumber *_power;
}
@property (nonatomic, strong) NSDictionary * peripheralData;
@property (nonatomic, strong) CBPeripheralManager *beaconManager;
@end

@implementation XKEViewController

- (void)viewDidLoad{
    _uuid = [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"];
    _major = @(5);
    _minor = @(2);
    _power = @-59;
}

- (IBAction)didTapStartButton:(id)sender{
    if([self.startButton.titleLabel.text isEqualToString:@"Start"]){
        [self.startButton setTitle:@"Stop" forState:UIControlStateNormal];
        self.locationImageView.image = [UIImage imageNamed:@"location-on"];
        [self startBroadCast];
    }else if([self.startButton.titleLabel.text isEqualToString:@"Stop"]){
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        self.locationImageView.image = [UIImage imageNamed:@"location-off"];
        [self stopBroadCast];
    }else{
        //who cares
    }
}

- (CBPeripheralManager *)beaconManager{
    if (_beaconManager == nil) {
        _beaconManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
        _beaconManager.delegate = self;
    }
    return _beaconManager;
}

-(NSDictionary *)peripheralData{
    if (_peripheralData == nil) {
        CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:_uuid major:[_major shortValue] minor:[_minor shortValue] identifier:@"nl.xebia.xke"];
        _peripheralData = [region peripheralDataWithMeasuredPower:_power];
    }
    return _peripheralData;
}

- (void)startBroadCast{
    [self.beaconManager startAdvertising:self.peripheralData];
}

- (void)stopBroadCast{
    [self.beaconManager stopAdvertising];
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOff:{
            //restart everything
            NSLog(@"restart everything");
            break;
        }
        case CBPeripheralManagerStatePoweredOn:{
            NSLog(@"Brodcast on");
            break;
        }
        default:{
            NSLog(@"I didn't want you to show you: %d",peripheral.state);
            break;
        }
    }
}


@end
