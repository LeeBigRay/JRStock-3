//
//  XJTabBarViewController.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "XJTabBarViewController.h"
#import "LRMediator+MeViewController.h"
#import "LRMediator+HomeViewController.h"
#import "LRMediator+PostViewController.h"
#import "LRMediator+ZoneViewController.h"
#import "LRMediator+MarketViewController.h"
#import "XJNavigationViewController.h"
#import "HyLaunchView.h"


static NSString * const KSNHClassKey = @"SNHClass";
static NSString * const KSNHTitleKey = @"SNHTitleKey";
static NSString * const KSNHNorImageKey = @"SNHNorImageKey";
static NSString * const KSNHSelectImageKey = @"SNHSelectImageKey";
@interface XJTabBarViewController ()

@end

@implementation XJTabBarViewController
+ (instancetype)shareTabBar {
    static XJTabBarViewController *_controller = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _controller = [XJTabBarViewController new];
    });
    return _controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _configuration];
    [self _initWithSubviews];
    


}

- (void)_configuration {

}

- (void)_initWithSubviews {
    XJNavigationViewController *homeNavigationVc = [self _itemNavigationWith:[LRGlobalMediator mainHomeViewController]];
    XJNavigationViewController *zoneNavigationVc = [self _itemNavigationWith:[LRGlobalMediator mainZoneViewController]];
    XJNavigationViewController *postNavigationVc = [self _itemNavigationWith:[LRGlobalMediator mainPostViewController]];
    XJNavigationViewController *marketNavigationVc = [self _itemNavigationWith:[LRGlobalMediator mainMarketViewController]];
    XJNavigationViewController *meNavigationVc = [self _itemNavigationWith:[LRGlobalMediator mainMeViewController]];


    NSArray *childArrayI = @[@{KSNHClassKey:homeNavigationVc,
                               KSNHTitleKey:@"首页",
                               KSNHNorImageKey:@"tab_btn_home_pre",
                               KSNHSelectImageKey:@"tab_btn_home_pre_selected"},
                             @{KSNHClassKey:zoneNavigationVc,
                               KSNHTitleKey:@"圈子",
                               KSNHNorImageKey:@"tab_btn_zone_pre",
                               KSNHSelectImageKey:@"tab_btn_zone_pre_selected"},
                             @{KSNHClassKey:postNavigationVc,
                               KSNHTitleKey:@"发布",
                               KSNHNorImageKey:@"tab_btn_post_pre",
                               KSNHSelectImageKey:@"tab_btn_post_pre_selected"},
                             @{KSNHClassKey:marketNavigationVc,
                               KSNHTitleKey:@"商店",
                               KSNHNorImageKey:@"tab_btn_market_pre",
                               KSNHSelectImageKey:@"tab_btn_market_pre_selected"},
                             @{KSNHClassKey:meNavigationVc,
                               KSNHTitleKey:@"我的",
                               KSNHNorImageKey:@"tab_btn_me_pre",
                               KSNHSelectImageKey:@"tab_btn_me_pre_selected"},
                             ];
    NSMutableArray *tempArrayM = @[].mutableCopy;
    [childArrayI enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XJNavigationViewController *nav = obj[KSNHClassKey];
        UITabBarItem *item = nav.tabBarItem;
        item.title = obj[KSNHTitleKey];
        item.image = [[UIImage imageNamed:obj[KSNHNorImageKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:obj[KSNHSelectImageKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#3c5b2f"],NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateSelected];
        [tempArrayM addObject:nav];
    }];
//3c5b2f

    self.viewControllers = tempArrayM;
}

- (XJNavigationViewController *)_itemNavigationWith:(UIViewController *)subViewController {
    XJNavigationViewController *superNavigation = [[XJNavigationViewController alloc]initWithRootViewController:subViewController];
    return superNavigation;
}



@end
