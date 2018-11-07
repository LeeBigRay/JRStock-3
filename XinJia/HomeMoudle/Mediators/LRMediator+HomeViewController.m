//
//  LRMediator+HomeViewController.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "LRMediator+HomeViewController.h"
static NSString *appHome_target = @"Home";

@implementation LRMediator (HomeViewController)
-(UIViewController *)mainHomeViewController{
    return [self performTarget:appHome_target action:@"nativeHomeWithParams" params:nil];
}
@end
