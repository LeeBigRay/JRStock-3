//
//  XJCommitView.m
//  XinJia
//
//  Created by 李瑞 on 2017/6/14.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "XJCommitView.h"

@implementation XJCommitView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ViewGrayColor;
        self.textView = [UITextView new];
        self.senderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_textView];
        [self addSubview:_senderBtn];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo (self.mas_left).offset(5);
            make.top.equalTo(self.mas_top).offset(5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.right.equalTo(self.mas_right).offset(-60);
        }];

        [_senderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(_textView.mas_right).offset(5);
            make.right.equalTo(self.mas_right).offset(-5);
            make.height.equalTo(@25);
        }];
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.layer.borderWidth = 1;
        _textView.layer.borderColor = [UIColor grayColor].CGColor;
        _textView.clipsToBounds = YES;
        _textView.layer.cornerRadius = 4;
        [_senderBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_senderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _senderBtn.layer.borderWidth = 1;
        _senderBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _senderBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _senderBtn.clipsToBounds = YES;
        _senderBtn.layer.cornerRadius = 4;
        [_senderBtn addTarget:self action:@selector(sender) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)sender{
    self.block(_textView.text);
}

@end
