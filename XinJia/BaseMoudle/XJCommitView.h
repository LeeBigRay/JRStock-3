//
//  XJCommitView.h
//  XinJia
//
//  Created by 李瑞 on 2017/6/14.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^TextViewBlock)(NSString *text);
@interface XJCommitView : UIView
@property (nonatomic ,strong)UITextView *textView;//
@property (nonatomic ,strong)UIButton *senderBtn;//
@property (nonatomic ,copy)TextViewBlock block;////一般使用copy策略，因为在ARC环境下已经不再有存储在栈中的block了，而是在堆中。声明一个TestBlock类型的变量
@end
