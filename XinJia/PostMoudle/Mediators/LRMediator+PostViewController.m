//
//  LRMediator+PostViewController.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "LRMediator+PostViewController.h"
static NSString *appPostTarger = @"Post";
@implementation LRMediator (PostViewController)
-(UIViewController *)mainPostViewController{
    return [self performTarget:appPostTarger action:@"nativePostWithParams" params:nil];
}
@end
