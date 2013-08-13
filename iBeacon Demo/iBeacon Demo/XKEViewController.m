//
//  XKEViewController.m
//  iBeacon Demo
//
//  Created by Robert van Loghem on 8/13/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import "XKEViewController.h"
#import "Masonry.h"
#import "XKEPersonCollectionViewCell.h"
#import "XKEPerson.h"
#import "XKECollectionViewAnimatedHelper.h"
#import "NSArray+RACSequenceAdditions.h"
#import "RACStream.h"
#import "RACSequence.h"


#define CELL_IDENTIFIER @"personCellIndentifier"

@interface XKEViewController ()

@end

@implementation XKEViewController {
    UICollectionView *_collectionView;
    NSArray *_people;
    CLLocationManager *_locationManager;
    CLBeaconRegion *_region;
}

-(id)init {
    if (self = [super init]) {
        _people = @[];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"XKE iBeacon", nil);

    self.view.backgroundColor = [UIColor whiteColor];


    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewFlowLayout];
    [_collectionView registerClass:[XKEPersonCollectionViewCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    UIView *superView = self.view;

    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
}

#pragma mark collection view

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_people count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XKEPersonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    cell.person = _people[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(collectionView.bounds) / 2, CGRectGetWidth(collectionView.bounds) / 2);
}

#pragma mark cllocation manager

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {

    NSLog(@"%s, %@", __PRETTY_FUNCTION__, beacons);

    NSArray *oldPeople = _people;

    _people = [[beacons rac_sequence] map:^id(CLBeacon *beacon) {
        if ([beacon.major isEqualToNumber:@5]) {
            if ([beacon.minor isEqualToNumber:@2]) {
                return [[XKEPerson alloc] initWithName:@"Rajdeep Mann" image:[UIImage imageNamed:@"randeep_mann.jpg"] vicinity:XKEPersonVicinityClose];
            } else if ([beacon.minor isEqualToNumber:@3]) {
                return [[XKEPerson alloc] initWithName:@"Jeroen Leenarts" image:[UIImage imageNamed:@"JeroenLeenarts.jpg"] vicinity:XKEPersonVicinityClose];
            }  else if ([beacon.minor isEqualToNumber:@4]) {
                return [[XKEPerson alloc] initWithName:@"Robert van Loghem" image:[UIImage imageNamed:@"Robert-van-Loghem.jpg"] vicinity:XKEPersonVicinityClose];
            }
        }
        return [[XKEPerson alloc] initWithName:@"Unknown" image:[UIImage imageNamed:@"unknown-person.jpg"] vicinity:XKEPersonVicinityClose];
    }].array;

    [_collectionView performBatchUpdates:^{
        [XKECollectionViewAnimatedHelper generateUpdatesForCollectionView:_collectionView inSection:0 oldData:oldPeople newData:_people];
    } completion:nil];


}


- (void)start {

    NSLog(@"%s", __PRETTY_FUNCTION__);

    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;

    _region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"] identifier:@"nl.xebia.xke"];
    _region.notifyOnEntry = YES;
    _region.notifyOnExit = YES;
    _region.notifyEntryStateOnDisplay = YES;
    [_locationManager startMonitoringForRegion:_region];
}

- (void)stop {

    NSLog(@"%s", __PRETTY_FUNCTION__);

    [_locationManager stopMonitoringForRegion:_region];

}
@end
