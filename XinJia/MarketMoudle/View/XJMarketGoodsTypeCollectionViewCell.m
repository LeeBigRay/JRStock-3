//
//  XJMarketGoodsTypeCollectionViewCell.m
//  XinJia
//
//  Created by 李瑞 on 2017/6/4.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "XJMarketGoodsTypeCollectionViewCell.h"

@interface XJMarketGoodsTypeCollectionViewCell ()

@end
@implementation XJMarketGoodsTypeCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
//    self.contentView.backgroundColor = [UIColor redColor];
    self.PictureImageView = [UIImageView new];
    self.titleLabel = [UILabel new];
    [self.contentView addSubview:_PictureImageView];
    [self.contentView addSubview:_titleLabel];

    [_PictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(-HeightScale(10));
        make.height.equalTo(@(HeightScale(50)));
        make.width.equalTo(@(HeightScale(50)));
    }];

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.equalTo(@(HeightScale(70)));
        make.height.equalTo(@(HeightScale(20)));
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];

//    _PictureImageView.image = [UIImage imageNamed:@"cycle3"];
    _titleLabel.text = @"书籍";
    _titleLabel.font = [UIFont fontWithName:navFontName size:14];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
}
@end
