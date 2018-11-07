//
//  Target_Zone.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "Target_Zone.h"
#import "XJZoneViewController.h"
@implementation Target_Zone
+(UIViewController *)Action_nativeZoneWithParams:(NSDictionary *)params{
    return [XJZoneViewController new];
}
@end
