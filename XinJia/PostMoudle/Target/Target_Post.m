//
//  Target_Post.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "Target_Post.h"
#import "XJPostViewController.h"
@implementation Target_Post
+(UIViewController *)Action_nativePostWithParams:(NSDictionary *)params{
    return [XJPostViewController new];
}
@end
