//
// Created by Robert van Loghem on 8/13/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface XKECollectionViewAnimatedHelper : NSObject

+(void)generateUpdatesForCollectionView:(UICollectionView *)collectionView inSection:(NSInteger)section oldData:(NSArray *)oldData newData:(NSArray *)newData;

@end