//
// Created by Robert van Loghem on 8/13/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//


#import "XKECollectionViewAnimatedHelper.h"


@implementation XKECollectionViewAnimatedHelper {

}

+(void)generateUpdatesForCollectionView:(UICollectionView *)collectionView inSection:(NSInteger)section oldData:(NSArray *)oldData newData:(NSArray *)newData
{
    if ([oldData isEqualToArray:newData]) return; //Do not update...

//    if ([oldData count] == 0 || [newData count] == 0) {
//        [collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
//    }

    NSArray *deletedItems = [oldData filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return ![newData containsObject:evaluatedObject];
    }]];

    [deletedItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        NSInteger oldIndex = [oldData indexOfObject:obj];
        [collectionView  deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:oldIndex inSection:section]]];
    }];

    NSArray *addedItems = [newData filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return ![oldData containsObject:evaluatedObject];
    }]];

    [newData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([addedItems containsObject:obj]) { //Insert
            [collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:idx inSection:section]]];
        } else { //Move
            NSInteger oldIndex = [oldData indexOfObject:obj];
            [collectionView moveItemAtIndexPath:[NSIndexPath indexPathForItem:oldIndex inSection:section] toIndexPath:[NSIndexPath indexPathForItem:idx inSection:section]];
        }
    }];
}
@end