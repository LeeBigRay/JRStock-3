//
//  ListCell.h
//  ListViewDemo
//
//  Created by JeffreyPH on 16/3/30.
//  Copyright © 2016年 JeffreyPH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListItem;
@interface ListCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) ListItem *item;

@property (nonatomic, assign, getter=isShowSeperatorLine) BOOL showSeperatorLine;
@end
