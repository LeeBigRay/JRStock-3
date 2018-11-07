//
//  XJMarketGoodsTabCollectionCell.m
//  XinJia
//
//  Created by 李瑞 on 2017/6/5.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "XJMarketGoodsTabCollectionCell.h"

@interface XJMarketGoodsTabCollectionCell ()
@property (nonatomic ,strong)UIImageView *FengMianImageView;//封面图片
@property (nonatomic ,strong)UILabel *desLabel;//描述
@property (nonatomic ,strong)UILabel *priceLabel;//价格
@end
@implementation XJMarketGoodsTabCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    self.FengMianImageView = [UIImageView new];
    self.desLabel = [UILabel new];
    self.priceLabel = [UILabel new];
    [self.contentView addSubview:_FengMianImageView];
    [self.contentView addSubview:_desLabel];
    [self.contentView addSubview:_priceLabel];

    _FengMianImageView.image = [UIImage imageNamed:@"cycle3"];
    _FengMianImageView.clipsToBounds = YES;
    _FengMianImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_FengMianImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(self.contentView.mas_width);
    }];

    _desLabel.text = @"霸天机甲";
    _desLabel.font = [UIFont fontWithName:navFontName size:14];
    _desLabel.textAlignment = NSTextAlignmentLeft;
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.top.equalTo(_FengMianImageView.mas_bottom).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.height.equalTo(@20);

    }];

    _priceLabel.text = @"$3.23";
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = [UIFont systemFontOfSize:12];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_desLabel.mas_left);
        make.right.equalTo(_desLabel.mas_right);
        make.height.equalTo(@15);
        make.top.equalTo(_desLabel.mas_bottom).offset(0);
    }];
}
@end
