//
//  Target_Market.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "Target_Market.h"
#import "XJMarketViewController.h"

@implementation Target_Market
+(UIViewController *)Action_nativeMarketWithParams:(NSDictionary *)params{
    return [XJMarketViewController new];
}
@end
