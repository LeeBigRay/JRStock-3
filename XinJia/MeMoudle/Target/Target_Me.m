//
//  Target_Me.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "Target_Me.h"
#import "XJMeViewController.h"
@implementation Target_Me
+(UIViewController *)Action_nativeMeWithParams:(NSDictionary *)paramas{
    return [XJMeViewController new];
}
@end
