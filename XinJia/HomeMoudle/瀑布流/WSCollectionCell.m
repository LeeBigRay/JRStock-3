//
//  WSCollectionCell.m
//  瀑布流
//
//  Created by iMac on 16/12/26.
//  Copyright © 2016年 zws. All rights reserved.
//

#import "WSCollectionCell.h"
#import "UIImageView+WebCache.h"

@implementation WSCollectionCell




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatSubView];
        
    }
    return self;
}

- (void)creatSubView {
    
    UIImageView *imgV = [[UIImageView alloc]init];
    imgV.tag = 10;
    [self addSubview:imgV];
    
//    UIVisualEffectView *visulEffectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular]];
    UIView *visulEffectView = [UIView new];
    visulEffectView.tag = 20;
    visulEffectView.backgroundColor = [UIColor blackColor];
    visulEffectView.alpha = 0.53;
    [self addSubview:visulEffectView];

    UILabel *label = [[UILabel alloc]init];
    label.tag = 30;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
//    [visulEffectView addSubview:label];
//    在iOS11 上必须添加到contentView上
    [visulEffectView addSubview:label];
}


-(void)setModel:(CellModel *)model {
    _model = model;
    UIImageView *imgV = (UIImageView *)[self viewWithTag:10];
    UIView *visulEffectView = (UIView *)[self viewWithTag:20];
    UILabel *label = (UILabel *)[self viewWithTag:30];

    imgV.frame = self.bounds;
//    visulEffectView.frame = CGRectMake(0, self.frame.size.height-16, self.frame.size.width, 16);
     visulEffectView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    label.frame = CGRectMake(0, 3, CGRectGetWidth(visulEffectView.frame), self.frame.size.height - 6);
    
    [imgV sd_setImageWithURL:[NSURL URLWithString:_model.imgURL]];
    label.text = _model.title;
    
}

@end
