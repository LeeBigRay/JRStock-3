//
//  WBStatusLayout.h
//  XinJia
//
//  Created by 李瑞 on 2017/5/31.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XJZoneModel.h"
#import "YYTextLayout.h"
#import "UIColor+YYAdd.h"


// 宽高
#define kWBCellTopMargin 8      // cell 顶部灰色留白
#define kWBCellTitleHeight 36   // cell 标题高度 (例如"仅自己可见")
#define kWBCellPadding 12       // cell 内边距
#define kWBCellPaddingText 10   // cell 文本与其他元素间留白
#define kWBCellPaddingPic 4     // cell 多张图片中间留白
#define kWBCellProfileHeight 56 // cell 名片高度
#define kWBCellCardHeight 70    // cell card 视图高度
#define kWBCellNamePaddingLeft 14 // cell 名字和 avatar 之间留白
#define kWBCellContentWidth (kScreen_width - 2 * kWBCellPadding) // cell 内容宽度
#define kWBCellNameWidth (kScreen_width - 110) // cell 名字最宽限制

#define kWBCellTagPadding 8         // tag 上下留白
#define kWBCellTagNormalHeight 16   // 一般 tag 高度
#define kWBCellTagPlaceHeight 24    // 地理位置 tag 高度

#define kWBCellToolbarHeight 35     // cell 下方工具栏高度
#define kWBCellToolbarBottomMargin 2 // cell 下方灰色留白

// 字体 应该做成动态的，这里只是 Demo，临时写死了。
#define kWBCellNameFontSize 16      // 名字字体大小
#define kWBCellSourceFontSize 12    // 来源字体大小
#define kWBCellTextFontSize 14      // 文本字体大小
#define kWBCellTextFontRetweetSize 16 // 转发字体大小
#define kWBCellCardTitleFontSize 16 // 卡片标题文本字体大小
#define kWBCellCardDescFontSize 12 // 卡片描述文本字体大小
#define kWBCellTitlebarFontSize 14 // 标题栏字体大小
#define kWBCellToolbarFontSize 14 // 工具栏字体大小

// 颜色
#define kWBCellNameNormalColor UIColorHex(333333) // 名字颜色
#define kWBCellNameOrangeColor UIColorHex(f26220) // 橙名颜色 (VIP)
#define kWBCellTimeNormalColor UIColorHex(828282) // 时间颜色
#define kWBCellTimeOrangeColor UIColorHex(f28824) // 橙色时间 (最新刷出)

#define kWBCellTextNormalColor UIColorHex(333333) // 一般文本色
#define kWBCellTextSubTitleColor UIColorHex(5d5d5d) // 次要文本色
#define kWBCellTextHighlightColor UIColorHex(527ead) // Link 文本色
#define kWBCellTextHighlightBackgroundColor UIColorHex(bfdffe) // Link 点击背景色
#define kWBCellToolbarTitleColor UIColorHex(515151) // 工具栏文本色
#define kWBCellToolbarTitleHighlightColor UIColorHex(df422d) // 工具栏文本高亮色

#define kWBCellBackgroundColor UIColorHex(f2f2f2)    // Cell背景灰色
#define kWBCellHighlightColor UIColorHex(f0f0f0)     // Cell高亮时灰色
#define kWBCellInnerViewColor UIColorHex(f7f7f7)   // Cell内部卡片灰色
#define kWBCellInnerViewHighlightColor  UIColorHex(f0f0f0) // Cell内部卡片高亮时灰色
#define kWBCellLineColor [UIColor colorWithWhite:0.000 alpha:0.09] //线条颜色

#define kWBLinkHrefName @"href" //NSString
#define kWBLinkURLName @"url" //WBURL
#define kWBLinkTagName @"tag" //WBTag
#define kWBLinkTopicName @"topic" //WBTopic
#define kWBLinkAtName @"at" //NSString

/// 风格
typedef NS_ENUM(NSUInteger, WBLayoutStyle) {
    WBLayoutStyleTimeline = 0, ///< 时间线 (目前只支持这一种)
    WBLayoutStyleDetail,       ///< 详情页
};
@interface WBStatusLayout : NSObject

/**
 初始化布局

 @param status 全部的内容
 @param style cell的样式  默认为时间轴
 @return 初始化结果
 */
- (instancetype)initWithStatus:(WBStatus *)status style:(WBLayoutStyle)style;
- (void)layout; ///< 计算布局
- (void)updateDate; ///< 更新时间字符串

// 以下是数据
@property (nonatomic, strong) WBStatus *status;
@property (nonatomic, assign) WBLayoutStyle style;

//以下是布局结果

// 顶部留白
@property (nonatomic, assign) CGFloat marginTop; //顶部灰色留白

// 标题栏
@property (nonatomic, assign) CGFloat titleHeight; //标题栏高度，0为没标题栏
@property (nonatomic, strong) YYTextLayout *titleTextLayout; // 标题栏

// 个人资料
@property (nonatomic, assign) CGFloat profileHeight; //个人资料高度(包括留白)
@property (nonatomic, strong) YYTextLayout *nameTextLayout; // 名字
@property (nonatomic, strong) YYTextLayout *sourceTextLayout; //时间/来源（个性签名）
@property (nonatomic, strong) YYTextLayout *timeTextLayout;//发布时间

// 文本
@property (nonatomic, assign) CGFloat textHeight; //文本高度(包括下方留白)
@property (nonatomic, strong) YYTextLayout *textLayout; //文本

// 图片
@property (nonatomic, assign) CGFloat picHeight; //图片高度，0为没图片
@property (nonatomic, assign) CGSize picSize;



// 工具栏
@property (nonatomic, assign) CGFloat toolbarHeight; // 工具栏
@property (nonatomic, strong) YYTextLayout *toolbarLikeTextLayout;
@property (nonatomic, strong) YYTextLayout *toolbarCommentTextLayout;
@property (nonatomic, strong) YYTextLayout *toolbarShareTextLayout;
@property (nonatomic, assign) CGFloat toolbarLikeTextWidth;
@property (nonatomic, assign) CGFloat toolbarCommentTextWidth;
@property (nonatomic, assign) CGFloat toolbarShareTextWidth;

// 下边留白
@property (nonatomic, assign) CGFloat marginBottom; //下边留白

// 总高度
@property (nonatomic, assign) CGFloat height;

@end

/**
 文本 Line 位置修改
 将每行文本的高度和位置固定下来，不受中英文/Emoji字体的 ascent/descent 影响
 */
@interface WBTextLinePositionModifier : NSObject <YYTextLinePositionModifier>
@property (nonatomic, strong) UIFont *font; // 基准字体 (例如 Heiti SC/PingFang SC)
@property (nonatomic, assign) CGFloat paddingTop; //文本顶部留白
@property (nonatomic, assign) CGFloat paddingBottom; //文本底部留白
@property (nonatomic, assign) CGFloat lineHeightMultiple; //行距倍数
- (CGFloat)heightForLineCount:(NSUInteger)lineCount;
@end

