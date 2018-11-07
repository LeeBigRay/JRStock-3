//
//  ListCell.m
//  ListViewDemo
//
//  Created by JeffreyPH on 16/3/30.
//  Copyright © 2016年 JeffreyPH. All rights reserved.
//

#import "ListCell.h"
#import "ListItem.h"

#define COLOR(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface ListCell()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIView *seperatorLine;

@end

@implementation ListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"ListCell";
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIView *selectedView = [[UIView alloc] init];
        selectedView.backgroundColor = COLOR(240, 240, 240, 1.0);
        cell.selectedBackgroundView = selectedView;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIView *sepertorLine = [[UIView alloc] init];
    sepertorLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:sepertorLine];
    self.seperatorLine = sepertorLine;
}

- (void)setItem:(ListItem *)item{
    _item = item;
    
    UIImage *icon = [UIImage imageNamed:item.icon];
    if(icon){
        self.iconView.image = icon;
    }
    self.titleLabel.text = item.title;
}

- (void)setShowSeperatorLine:(BOOL)showSeperatorLine{
    _showSeperatorLine = showSeperatorLine;
    self.seperatorLine.hidden = !_showSeperatorLine;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = self.frame.size;
    
    CGFloat iX = 10;
    CGFloat iY = 10;
    CGFloat iW = size.height - iY * 2;
    CGFloat iH = iW;
    self.iconView.frame = CGRectMake(iX, iY, iW, iH);
    
    CGFloat tX = size.height;
    CGFloat tY = 10;
    CGFloat tW = size.width - tX - iX;
    CGFloat tH = iH;
    self.titleLabel.frame = CGRectMake(tX, tY, tW, tH);
    
    self.seperatorLine.frame = CGRectMake(0, size.height, size.width, .5);
}

@end
