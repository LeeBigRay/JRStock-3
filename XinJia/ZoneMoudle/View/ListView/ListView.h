//
//  ListView.h
//  ListViewDemo
//
//  Created by JeffreyPH on 16/3/30.
//  Copyright © 2016年 JeffreyPH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListItem;
typedef void(^SelectBlock)(NSInteger selectIndex);

@interface ListView : UIView

- (instancetype)initWithReferFrame:(CGRect)rect items:(NSArray <ListItem *>*)items select:(SelectBlock)select;

+ (instancetype)listViewWithReferFrame:(CGRect)rect items:(NSArray <ListItem *>*)items select:(SelectBlock)select;

@end
