//
//  XJZoneDetailViewController.h
//  XinJia
//
//  Created by 李瑞 on 2017/6/14.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJZoneTableViewCell.h"
#import "WBStatusLayout.h"
@interface XJZoneDetailViewController : UIViewController
@property (nonatomic ,strong)XJZoneTableViewCell *headCell;
@property (nonatomic ,strong)WBStatusLayout *layout;
@end
