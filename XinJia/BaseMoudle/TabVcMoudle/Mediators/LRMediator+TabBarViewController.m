//
//  LRMediator+TabBarViewController.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "LRMediator+TabBarViewController.h"
static NSString *appTabBarTarget = @"TabBar";
@implementation LRMediator (TabBarViewController)
-(UIViewController *)mainTabBarViewController{
    return [self performTarget:appTabBarTarget action:@"nativeTabBarWithParams" params:nil];
}
@end
