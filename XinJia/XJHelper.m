//
//  XJHelper.m
//  XinJia
//
//  Created by 李瑞 on 2017/6/9.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "XJHelper.h"

@implementation XJHelper
+ (UIView *)getMainView {
    if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        if (!window)
            window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        return [window subviews].lastObject;
    } else {
        UIWindow *window =[[UIApplication sharedApplication] keyWindow];
        if (window == nil)
            window = [[[UIApplication sharedApplication] delegate] window];//#14
        return window;
    }
}

+ (UIImage *)getLauchImage
{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = @"Portrait";
    NSString *launchImage = nil;
    NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDict) {
        CGSize imageSize = CGSizeFromString([dict objectForKey:@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:[dict objectForKey:@"UILaunchImageOrientation"]]) {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    return [UIImage imageNamed:launchImage];
}

/**
 获取view所在的controller   减轻代理的使用
 */

#pragma mark - 获取当前view的viewcontroller
+ (UIViewController *)getCurrentViewController:(UIView *) currentView
{
    for (UIView* next = [currentView superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
