//
// Created by Robert van Loghem on 8/13/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//


#import "XKEPersonCollectionViewCell.h"
#import "XKEPerson.h"

#import "Masonry.h"


@implementation XKEPersonCollectionViewCell {

    UIImageView *_imageView;
    UILabel *_nameLabel;
}

-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];

        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:20.0];
        [self.contentView addSubview:_nameLabel];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIView *superView = self.contentView;

    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];

    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_imageView.mas_bottom);
        make.left.equalTo(_imageView.mas_left);
        make.right.equalTo(_imageView.mas_right);
        make.height.equalTo(@44);
    }];

}


- (void)setPerson:(XKEPerson *)person {
    _person = person;
    
    _imageView.image = person.image;
    _imageView.alpha = (person.vicinity == XKEPersonVicinityClose) ? 1.0 : 0.3;
    _nameLabel.text = [NSString stringWithFormat:@"  %@ (%@)", person.name, (person.vicinity == XKEPersonVicinityClose) ? @"Close by" : @"Away"];
}


@end