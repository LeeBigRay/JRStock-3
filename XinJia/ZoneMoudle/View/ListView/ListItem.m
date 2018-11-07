//
//  ListItem.m
//  ListViewDemo
//
//  Created by JeffreyPH on 16/3/30.
//  Copyright © 2016年 JeffreyPH. All rights reserved.
//

#import "ListItem.h"

@implementation ListItem

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title{
    self = [super init];
    if(self){
        self.icon = icon;
        self.title = title;
    }
    return self;
}

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title{
    return [[self alloc] initWithIcon:icon title:title];
}

@end
