//
//  XJHelper.h
//  XinJia
//
//  Created by 李瑞 on 2017/6/9.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XJHelper : NSObject
+ (nullable UIView   *)getMainView;
+ (UIImage *_Nullable)getLauchImage;
+ (UIViewController *_Nullable)getCurrentViewController:(UIView *_Nullable) currentView;

@end
