//
//  LRMediator+MeViewController.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "LRMediator+MeViewController.h"
static NSString *appMeTarget = @"Me";
@implementation LRMediator (MeViewController)
-(UIViewController *)mainMeViewController{
    return [self performTarget:appMeTarget action:@"nativeMeWithParams" params:nil];
}
@end
