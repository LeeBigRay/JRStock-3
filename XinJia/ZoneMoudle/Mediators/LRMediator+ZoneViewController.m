//
//  LRMediator+ZoneViewController.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "LRMediator+ZoneViewController.h"
static NSString *appZoneTarget = @"Zone";
@implementation LRMediator (ZoneViewController)
-(UIViewController *)mainZoneViewController{
    return [self performTarget:appZoneTarget action:@"nativeZoneWithParams" params:nil];
}
@end
