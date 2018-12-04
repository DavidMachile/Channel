//
//  CollectionReusableView.m
//  我的频道
//
//  Created by cctv-person on 2018/12/3.
//  Copyright © 2018 cctv-person. All rights reserved.
//

#import "CollectionReusableView.h"
@interface CollectionReusableView()
@end
@implementation CollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headLabel];
    }
    return self;
}
- (UILabel *)headLabel{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, self.frame.size.width, 30)];
    }
    return _headLabel;
}
@end
