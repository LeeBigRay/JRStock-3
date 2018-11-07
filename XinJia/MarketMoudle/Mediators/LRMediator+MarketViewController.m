//
//  LRMediator+MarketViewController.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "LRMediator+MarketViewController.h"

static NSString *appMarketTarget = @"Market";
@implementation LRMediator (MarketViewController)
-(UIViewController *)mainMarketViewController{
    return [self performTarget:appMarketTarget action:@"nativeMarketWithParams" params:nil];
}
@end
