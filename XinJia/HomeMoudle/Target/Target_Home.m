//
//  Target_Home.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "Target_Home.h"
#import "XJHomeViewController.h"

@implementation Target_Home
+(UIViewController *)Action_nativeHomeWithParams:(NSDictionary *)params{
    return [XJHomeViewController new];
}
@end
