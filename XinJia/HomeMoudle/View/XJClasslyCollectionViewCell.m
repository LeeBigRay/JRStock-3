//
//  XJClasslyCollectionViewCell.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "XJClasslyCollectionViewCell.h"

@implementation XJClasslyCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    self.iconImageView = [UIImageView new];
    self.titleLabel = [UILabel new];
    [self.contentView addSubview:_iconImageView];
    [self.contentView addSubview:_titleLabel];

    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.height.equalTo(@(HeightScale(80)));
        make.width.equalTo(@(HeightScale(80)));
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);

    }];
    self.titleLabel.text = @"";
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font=[UIFont systemFontOfSize:12];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    //    self.titleLabel.adjustsFontSizeToFitWidth = YES;

}

//-(void)setModel:(QDFastInModel *)model{
//
//    
//}
@end
