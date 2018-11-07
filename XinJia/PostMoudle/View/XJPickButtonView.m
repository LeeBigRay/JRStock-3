//
//  XJPickButtonView.m
//  XinJia
//
//  Created by 李瑞 on 2017/6/2.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "XJPickButtonView.h"

#define buttonWidth  (kScreen_width - 20 - 60)/4.
@implementation XJPickButtonView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *choseTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, kScreen_width, 25)];
        choseTypeLabel.text = @"--选择帖子分类--";
        choseTypeLabel.textAlignment = NSTextAlignmentCenter;
        choseTypeLabel.font = [UIFont systemFontOfSize:14];
        choseTypeLabel.textColor = [UIColor blackColor];
        [self addSubview:choseTypeLabel];
    }
    return self;
}

-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    for (int i = 0; i <titleArray.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame  =CGRectMake(10 + (buttonWidth + 20)*((i+4)%4), 30 + (i/4) *30, buttonWidth, 25);
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.tag = 100 + i;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.layer.borderColor = [UIColor darkGrayColor].CGColor;
        btn.layer.borderWidth = 1;
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(TouchBegin:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}
-(void)TouchBegin:(UIButton *)btn{
    for (int i = 0; i <_titleArray.count; i ++) {
        //判断点进来的tag  让其选中  继续点击依然选中
        if (btn.tag == 100 +i) {
            btn.selected = YES;
            btn.layer.borderColor = [UIColor blueColor].CGColor;
            continue;
        }
        UIButton *btn = (UIButton *)([self viewWithTag:100 +i]);
        btn.selected = NO;
        btn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    }
}

@end
