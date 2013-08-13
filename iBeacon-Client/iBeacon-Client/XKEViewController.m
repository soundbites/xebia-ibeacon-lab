//
//  XKEViewController.m
//  iBeacon-Client
//
//  Created by Rajdeep Mann on 13/08/13.
//  Copyright (c) 2013 Rajdeep Mann. All rights reserved.
//

#import "XKEViewController.h"

@interface XKEViewController ()
@property (nonatomic, strong) NSDictionary * peripheralData;
@property (nonatomic, strong) CBPeripheralManager *beaconManager;
@property (nonatomic, strong) NSNumber *major;
@property (nonatomic, strong) NSNumber *minor;
@property (nonatomic, strong) NSNumber *power;
@property (nonatomic, strong) NSUUID *uuid;
@end

@implementation XKEViewController

- (void)viewDidLoad{
    _uuid = [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"];
    _major = @(5);
    _minor = @(2);
    _power = @-59;
    _beaconManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    _beaconManager.delegate = self;
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

-(NSDictionary *)peripheralData{
    if (_peripheralData == nil) {
        CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:self.uuid major:[self.major shortValue] minor:[self.minor shortValue] identifier:@"nl.xebia.xke"];
        _peripheralData = [region peripheralDataWithMeasuredPower:self.power];
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

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    if (error ==  nil) {
        NSLog(@"peripheralManagerDidStartAdvertising");
    }else{
        NSLog(@"peripheralManagerFailedToStartAdvertising: %@",error);
    }
}


@end
