//
//  ListItem.h
//  ListViewDemo
//
//  Created by JeffreyPH on 16/3/30.
//  Copyright © 2016年 JeffreyPH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListItem : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *icon;

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;

@end
