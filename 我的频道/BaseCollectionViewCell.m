//
//  BaseCollectionViewCell.m
//  我的频道
//
//  Created by cctv-person on 2018/12/3.
//  Copyright © 2018 cctv-person. All rights reserved.
//

#import "BaseCollectionViewCell.h"
@interface BaseCollectionViewCell()
@end
@implementation BaseCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self=  [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.lightGrayColor;
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        [self addSubview:self.label];
    }
    return self;
}


- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:self.contentView.frame];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = UIColor.redColor;
    }
    return _label;
}

- (void)setStr:(NSString *)str{
    _str = str;
    _label.text = str;
}
@end
