//
//  AppDelegate+Config.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "AppDelegate+Config.h"

@implementation AppDelegate (Config)
//设置统一UI
- (void)settingAppearance {
    [self _setNavigationAppearace];
    [self _setTableViewAppearace];
}

- (void)_setNavigationAppearace {
    [[UINavigationBar appearance]setTranslucent:NO];
    [self _setNavigationBackItem];
    [self _setNavigationTitle];
    [self _setNavigationColor];
    [self printAllFonts];
    [self _setToolBarAppearace];
}
- (void)printAllFonts
{
    NSArray *fontFamilies = [UIFont familyNames];
    for (NSString *fontFamily in fontFamilies)
    {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:fontFamily];
        NSLog (@"%@: %@", fontFamily, fontNames);
    }
}

- (void)_setNavigationTitle {
    NSDictionary *navigationParams = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"FZLBJW--GB1-0" size:18]};
    [[UINavigationBar appearance]setTitleTextAttributes:navigationParams];
}

- (void)_setNavigationColor {
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"FZLBJW--GB1-0" size:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
}

- (void)_setNavigationBackItem {
    UINavigationBar * navigationBar = [UINavigationBar appearance];
    UIImage *image = [UIImage imageNamed:@"back"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationBar.backIndicatorImage = image;
    navigationBar.backIndicatorTransitionMaskImage = image;
    UIBarButtonItem *buttonItem = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
    UIOffset offset;
    offset.horizontal = - 500;
    offset.vertical =  0;
    [buttonItem setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
}

- (void)_setTableViewAppearace {
    [[UITableView appearance]setTableFooterView:[UIView new]];
    [[UITableView appearance]setSeparatorInset:UIEdgeInsetsZero];
}

- (void)_setToolBarAppearace {
//    UIToolbar *appearance = [UIToolbar appearance];
//    //样式和背景二选一即可，看需求了
//    //样式（黑色半透明，不透明等）设置
//    [appearance setBarStyle:0];
//    //背景设置
//    [appearance setBackgroundImage:[UIImage imageNamed:@"cycle3@2x.png"]
//                forToolbarPosition:UIToolbarPositionAny
//                        barMetrics:UIBarMetricsDefault];

    UISegmentedControl *appearance = [UISegmentedControl appearance];

    //Segmenteg正常背景
    [appearance setBackgroundImage:[UIImage imageNamed:@"cycle3"]
                          forState:UIControlStateNormal
                        barMetrics:UIBarMetricsDefault];

    //Segmente选中背景
    [appearance setBackgroundImage:[UIImage imageNamed:@"cycle1"]
                          forState:UIControlStateSelected
                        barMetrics:UIBarMetricsDefault];
}


@end
