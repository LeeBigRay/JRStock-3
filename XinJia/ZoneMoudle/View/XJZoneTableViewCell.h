//
//  XJZoneTableViewCell.h
//  XinJia
//
//  Created by 李瑞 on 2017/5/30.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYKit.h"
#import "WBStatusLayout.h"
@class XJZoneTableViewCell;
@protocol WBStatusCellDelegate;

@interface WBStatusProfileView : UIView
@property (nonatomic, strong) UIImageView *avatarView; ///< 头像
//@property (nonatomic, strong) UIImageView *avatarBadgeView; ///< 徽章
@property (nonatomic, strong) YYLabel *nameLabel;//昵称
//@property (nonatomic, strong) YYLabel *sourceLabel;//来源 时间   （用来显示个性签名）
@property (nonatomic, strong) YYLabel *timeLabel;//发布时间
@property (nonatomic, strong) UIButton *reportButton;//举报按钮
@property (nonatomic, weak)   XJZoneTableViewCell *cell; //弱引用
//@property (nonatomic, strong) UIImageView *backgroundImageView;
//@property (nonatomic, strong) UIButton *arrowButton;
//@property (nonatomic, strong) UIButton *followButton;
//@property (nonatomic, assign) WBUserVerifyType verifyType;
//@property (nonatomic, weak) WBStatusCell *cell;
@end



//下方工具栏
@interface WBStatusToolbarView : UIView

@property (nonatomic, strong) UIButton *likeButton;//点赞
@property (nonatomic, strong) UIButton *commentButton;//评论
@property (nonatomic, strong) UIButton *shareButton;//分享


@property (nonatomic, strong) UIImageView *likeImageView;
@property (nonatomic, strong) UIImageView *commentImageView;
@property (nonatomic, strong) UIImageView *shareImageView;

@property (nonatomic, strong) YYLabel *likeLabel;
@property (nonatomic, strong) YYLabel *commentLabel;
@property (nonatomic, strong) YYLabel *shareLabel;

@property (nonatomic, strong) CAGradientLayer *line1;
@property (nonatomic, strong) CAGradientLayer *line2;
@property (nonatomic, strong) CALayer *topLine;
@property (nonatomic, strong) CALayer *bottomLine;
@property (nonatomic, weak)   XJZoneTableViewCell *cell;

- (void)setWithLayout:(WBStatusLayout *)layout;
// set both "liked" and "likeCount"
- (void)setLiked:(BOOL)liked withAnimation:(BOOL)animation;
@end

@interface WBStatusView : UIView
@property (nonatomic, strong) UIView *contentView;              // 容器
@property (nonatomic, strong) WBStatusProfileView *profileView; // 用户资料
@property (nonatomic, strong) YYLabel *textLabel;               // 文本
@property (nonatomic, strong) UIImageView *picView;      // 图片(单张)
@property (nonatomic, strong) WBStatusToolbarView *toolBarView; // 底部菜单栏
@property (nonatomic, weak)   XJZoneTableViewCell *cell;

@property (nonatomic, strong) WBStatusLayout *layout;

@end


@protocol WBStatusCellDelegate;
@interface XJZoneTableViewCell : UITableViewCell
@property (nonatomic, weak) id<WBStatusCellDelegate> delegate;
@property (nonatomic, strong) WBStatusView *statusView;
- (void)setLayout:(WBStatusLayout *)layout;


@end

//定义一个代理  实现toolBar的点击事件
@protocol WBStatusCellDelegate <NSObject>

@optional
//点击了整条cell
-(void)cellDidClick:(XJZoneTableViewCell *)cell;

//点击了举报按钮
-(void)cellDidClickReport:(XJZoneTableViewCell *)cell;

//点击了点赞按钮
-(void)cellDidClickLike:(XJZoneTableViewCell *)cell;

//点击了评论按钮
-(void)cellDidClickComment:(XJZoneTableViewCell *)cell;

/// 点击了Cell菜单
- (void)cellDidClickMenu:(XJZoneTableViewCell *)cell;

//点击了分享按钮
-(void)cellDidClickShare:(XJZoneTableViewCell *)cell;

//点击了用户头像
-(void)cellDidClickUser:(XJZoneTableViewCell *)cell;

- (void)cell:(XJZoneTableViewCell *)cell didClickUser:(WBUser *)user;

//点击了图片
- (void)cell:(XJZoneTableViewCell *)cell didClickImageAtIndex:(NSUInteger)index;

@end

