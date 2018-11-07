//
//  Target_TabBar.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "Target_TabBar.h"
#import "XJTabBarViewController.h"
@implementation Target_TabBar
+(UIViewController *)Action_nativeTabBarWithParams:(NSDictionary *)params{
    return [XJTabBarViewController shareTabBar];
}
@end
