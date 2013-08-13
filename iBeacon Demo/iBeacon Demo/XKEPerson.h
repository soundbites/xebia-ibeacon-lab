//
// Created by Robert van Loghem on 8/13/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef enum {
    XKEPersonVicinityClose,
    XKEPersonVicinityAway
} XKEPersonVicinity;


@interface XKEPerson : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, assign) XKEPersonVicinity vicinity;


- (id)initWithName:(NSString *)name image:(UIImage *)image vicinity:(XKEPersonVicinity)vicinity;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToPerson:(XKEPerson *)person;

- (NSUInteger)hash;
@end