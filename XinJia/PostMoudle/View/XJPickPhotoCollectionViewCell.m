//
//  XJPickPhotoCollectionViewCell.m
//  XinJia
//
//  Created by 李瑞 on 2017/6/1.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "XJPickPhotoCollectionViewCell.h"

@implementation XJPickPhotoCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.photoImageView = [UIImageView new];
    self.photoImageView.clipsToBounds = YES;
    self.photoImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_photoImageView];
//    self.photoImageView.image = [UIImage imageNamed:@"cycle3"];
    [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];

    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [self.deleteBtn addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteBtn];
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.contentView);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
}
-(void)deletePhoto:(UIButton *)btn{
    if (_delegate && [_delegate respondsToSelector:@selector(deletePhotoWithCell:)]) {
        [_delegate deletePhotoWithCell:self];
    }
}


@end
