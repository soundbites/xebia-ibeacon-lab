//
// Created by Robert van Loghem on 8/13/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//


#import "XKEPerson.h"


@implementation XKEPerson {

}
- (id)initWithName:(NSString *)name image:(UIImage *)image vicinity:(XKEPersonVicinity)vicinity {
    if (self = [super init]) {
        _name = name;
        _image = image;
        _vicinity = vicinity;
    }
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToPerson:other];
}

- (BOOL)isEqualToPerson:(XKEPerson *)person {
    if (self == person)
        return YES;
    if (person == nil)
        return NO;
    if (self.name != person.name && ![self.name isEqualToString:person.name])
        return NO;
    if (self.image != person.image && ![self.image isEqual:person.image])
        return NO;
    if (self.vicinity != person.vicinity)
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [self.name hash];
    hash = hash * 31u + [self.image hash];
    hash = hash * 31u + (NSUInteger) self.vicinity;
    return hash;
}


@end