//
//  WBStatusLayout.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/31.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "WBStatusLayout.h"
#import "UIImageView+YYWebImage.h"
#import "UIView+YYAdd.h"
#import <pthread.h>
#import "WBStatusHelper.h"

/*
 将每行的 baseline 位置固定下来，不受不同字体的 ascent/descent 影响。

 注意，Heiti SC 中，    ascent + descent = font size，
 但是在 PingFang SC 中，ascent + descent > font size。
 所以这里统一用 Heiti SC (0.86 ascent, 0.14 descent) 作为顶部和底部标准，保证不同系统下的显示一致性。
 间距仍然用字体默认
 */
@implementation WBTextLinePositionModifier

- (instancetype)init {
    self = [super init];

//    if (kiOS9Later) {
        _lineHeightMultiple = 1.34;   // for PingFang SC
//    } else {
//        _lineHeightMultiple = 1.3125; // for Heiti SC
//    }

    return self;
}

- (void)modifyLines:(NSArray *)lines fromText:(NSAttributedString *)text inContainer:(YYTextContainer *)container {
    //CGFloat ascent = _font.ascender;
    CGFloat ascent = _font.pointSize * 0.86;

    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    for (YYTextLine *line in lines) {
        CGPoint position = line.position;
        position.y = _paddingTop + ascent + line.row  * lineHeight;
        line.position = position;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    WBTextLinePositionModifier *one = [self.class new];
    one->_font = _font;
    one->_paddingTop = _paddingTop;
    one->_paddingBottom = _paddingBottom;
    one->_lineHeightMultiple = _lineHeightMultiple;
    return one;
}

- (CGFloat)heightForLineCount:(NSUInteger)lineCount {
    if (lineCount == 0) return 0;
    //    CGFloat ascent = _font.ascender;
    //    CGFloat descent = -_font.descender;
    CGFloat ascent = _font.pointSize * 0.86;
    CGFloat descent = _font.pointSize * 0.14;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    return _paddingTop + _paddingBottom + ascent + descent + (lineCount - 1) * lineHeight;
}

@end


/**
 微博的文本中，某些嵌入的图片需要从网上下载，这里简单做个封装
 */
@interface WBTextImageViewAttachment : YYTextAttachment
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, assign) CGSize size;
@end

@implementation WBTextImageViewAttachment {
    UIImageView *_imageView;
}
- (void)setContent:(id)content {
    _imageView = content;
}
- (id)content {
    /// UIImageView 只能在主线程访问
    if (pthread_main_np() == 0) return nil;
    if (_imageView) return _imageView;

    /// 第一次获取时 (应该是在文本渲染完成，需要添加附件视图时)，初始化图片视图，并下载图片
    /// 这里改成 YYAnimatedImageView 就能支持 GIF/APNG/WebP 动画了
    _imageView = [UIImageView new];
    _imageView.size = _size;
    [_imageView setImageWithURL:_imageURL placeholder:nil];
    return _imageView;
}
@end


@implementation WBStatusLayout
- (instancetype)initWithStatus:(WBStatus *)status style:(WBLayoutStyle)style {
    if (!status || !status.user) return nil;
    self = [super init];
    _status = status;
    _style = style;
    [self layout];
    return self;
}

- (void)layout {
    [self _layout];
}

- (void)updateDate {
    [self _layoutSource];
}

- (void)_layout {

    _marginTop = kWBCellTopMargin;
    _titleHeight = 0;
    _profileHeight = 0;
    _textHeight = 0;
    _picHeight = 0;
    _toolbarHeight = kWBCellToolbarHeight;
    _marginBottom = kWBCellToolbarBottomMargin;


    // 文本排版，计算布局
    [self _layoutProfile];
    [self _layoutPics];

    [self _layoutText];
    [self _layoutToolbar];

    // 计算高度
    _height = 0;
    _height += _marginTop;
    _height += _titleHeight;
    _height += _profileHeight;
    _height += _textHeight;

    _height += _picHeight;
    _height += kWBCellPadding;
    _height += _toolbarHeight;
    _height += _marginBottom;
}


- (void)_layoutProfile {
    [self _layoutName];
    [self _layoutSource];
    [self _layoutTime];
    _profileHeight = kWBCellProfileHeight;
}

/// 名字
- (void)_layoutName {
    WBUser *user = _status.user;
    NSString *nameStr = nil;

        nameStr = user.name;

    if (nameStr.length == 0) {
        _nameTextLayout = nil;
        return;
    }

    NSMutableAttributedString *nameText = [[NSMutableAttributedString alloc] initWithString:nameStr];
//
//    // 蓝V
//    if (user.userVerifyType == WBUserVerifyTypeOrganization) {
//        UIImage *blueVImage = [WBStatusHelper imageNamed:@"avatar_enterprise_vip"];
//        NSAttributedString *blueVText = [self _attachmentWithFontSize:kWBCellNameFontSize image:blueVImage shrink:NO];
//        [nameText appendString:@" "];
//        [nameText appendAttributedString:blueVText];
//    }
//
//    // VIP
//    if (user.mbrank > 0) {
//        UIImage *yelllowVImage = [WBStatusHelper imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
//        if (!yelllowVImage) {
//            yelllowVImage = [WBStatusHelper imageNamed:@"common_icon_membership"];
//        }
//        NSAttributedString *vipText = [self _attachmentWithFontSize:kWBCellNameFontSize image:yelllowVImage shrink:NO];
//        [nameText appendString:@" "];
//        [nameText appendAttributedString:vipText];
//    }
//
    nameText.font = [UIFont systemFontOfSize:kWBCellNameFontSize];
    nameText.color = BlackColor;
    nameText.lineBreakMode = NSLineBreakByCharWrapping;

    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kWBCellNameWidth, 9999)];
    container.maximumNumberOfRows = 1;
    _nameTextLayout = [YYTextLayout layoutWithContainer:container text:nameText];
}

/// 时间和来源
- (void)_layoutSource {
    NSMutableAttributedString *sourceText = [NSMutableAttributedString new];
    sourceText = [[NSMutableAttributedString alloc]initWithString:_status.user.desc];
    sourceText.font =  [UIFont systemFontOfSize:kWBCellSourceFontSize];
    sourceText.color = kWBCellTimeNormalColor;
    NSString *createTime = [WBStatusHelper stringWithTimelineDate:_status.createdAt];
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kWBCellNameWidth, 9999)];
    container.maximumNumberOfRows = 1;
    _sourceTextLayout = [YYTextLayout layoutWithContainer:container text:sourceText];
    return;
}

//发布时间
-(void)_layoutTime{
    NSMutableAttributedString *timeText = [NSMutableAttributedString new];
    NSString *createTime = [WBStatusHelper stringWithTimelineDate:_status.createdAt];
     // 时间
    if (createTime.length) {
        NSMutableAttributedString *timeText_1 = [[NSMutableAttributedString alloc] initWithString:createTime];
        [timeText_1 appendString:@"  "];
        timeText_1.font = [UIFont systemFontOfSize:kWBCellSourceFontSize];
        timeText_1.color = kWBCellTimeNormalColor;
        [timeText appendAttributedString:timeText_1];
    }


    if (timeText.length == 0) {
        _timeTextLayout = nil;
    } else {
        YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(100, 9999)];
        container.maximumNumberOfRows = 1;
        _timeTextLayout = [YYTextLayout layoutWithContainer:container text:timeText];
    }

}


/// 文本
- (void)_layoutText {
    _textHeight = 0;
    _textLayout = nil;

    NSMutableAttributedString *text = [self _textWithStatus:_status
                                                  isRetweet:NO
                                                   fontSize:kWBCellTextFontSize
                                                  textColor:kWBCellTextNormalColor];
    if (text.length == 0) return;

    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:kWBCellTextFontSize];
    modifier.paddingTop = kWBCellPaddingText;
    modifier.paddingBottom = kWBCellPaddingText;

    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake(kWBCellContentWidth, HUGE);
    container.linePositionModifier = modifier;

    _textLayout = [YYTextLayout layoutWithContainer:container text:text];
    if (!_textLayout) return;

    _textHeight = [modifier heightForLineCount:_textLayout.rowCount];
}




- (void)_layoutPics {
    [self _layoutPicsWithStatus:_status];
}


- (void)_layoutPicsWithStatus:(WBStatus *)status{

    _picSize = CGSizeZero;
    _picHeight = 0;
    if (status.pics.count == 0) return;
    CGSize picSize = CGSizeZero;
    CGFloat picHeight = 0;
    CGFloat len1_3 = (kWBCellContentWidth + kWBCellPaddingPic) / 3 - kWBCellPaddingPic;
    len1_3 = CGFloatPixelRound(len1_3);
    WBPicture *pic = _status.pics.firstObject;
    WBPictureMetadata *bmiddle = pic.bmiddle;
    //这里一张图的展示方式是根据 后台图片是否固定为方型来进行限制的，我们在这里直接给定一个宽高比
    //            if (pic.keepSize || bmiddle.width < 1 || bmiddle.height < 1) {
    //                CGFloat maxLen = kWBCellContentWidth / 2.0;
    //                maxLen = CGFloatPixelRound(maxLen);
    //                picSize = CGSizeMake(maxLen, maxLen);
    //                picHeight = maxLen;
    //            } else
    {
        CGFloat maxLen = len1_3 * 2 + kWBCellPaddingPic;
        if (bmiddle.width < bmiddle.height) {
            picSize.width = (float)bmiddle.width / (float)bmiddle.height * maxLen;
            picSize.height = maxLen;
        } else {
            picSize.width = maxLen;
            picSize.height = (float)bmiddle.height / (float)bmiddle.width * maxLen;
        }
        picSize = CGSizePixelRound(picSize);
        picHeight = picSize.height;
    }

        _picSize = picSize;
        _picHeight = picHeight;

}


- (void)_layoutToolbar {
    // should be localized
    UIFont *font = [UIFont systemFontOfSize:kWBCellToolbarFontSize];
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth, kWBCellToolbarHeight)];
    container.maximumNumberOfRows = 1;

    NSMutableAttributedString *likeText = [[NSMutableAttributedString alloc] initWithString:_status.attitudesCount <= 0 ? @"点赞" : [WBStatusHelper shortedNumberDesc:_status.attitudesCount]];
    likeText.font = font;
    likeText.color = _status.attitudesStatus ? kWBCellToolbarTitleHighlightColor : kWBCellToolbarTitleColor;
    _toolbarLikeTextLayout = [YYTextLayout layoutWithContainer:container text:likeText];
    _toolbarLikeTextWidth = CGFloatPixelRound(_toolbarLikeTextLayout.textBoundingRect.size.width);

    NSMutableAttributedString *commentText = [[NSMutableAttributedString alloc] initWithString:_status.commentsCount <= 0 ? @"评论" : [WBStatusHelper shortedNumberDesc:_status.commentsCount]];
    commentText.font = font;
    commentText.color = kWBCellToolbarTitleColor;
    _toolbarCommentTextLayout = [YYTextLayout layoutWithContainer:container text:commentText];
    _toolbarCommentTextWidth = CGFloatPixelRound(_toolbarCommentTextLayout.textBoundingRect.size.width);

    NSMutableAttributedString *shareText = [[NSMutableAttributedString alloc] initWithString:@"分享"];
    shareText.font = font;
    shareText.color = kWBCellToolbarTitleColor;
    _toolbarShareTextLayout = [YYTextLayout layoutWithContainer:container text:shareText];
    _toolbarShareTextWidth = CGFloatPixelRound(_toolbarShareTextLayout.textBoundingRect.size.width);
}




- (NSMutableAttributedString *)_textWithStatus:(WBStatus *)status
                                     isRetweet:(BOOL)isRetweet
                                      fontSize:(CGFloat)fontSize
                                     textColor:(UIColor *)textColor {
    if (!status) return nil;

    NSMutableString *string = status.text.mutableCopy;
    if (string.length == 0) return nil;

    // 字体
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    // 高亮状态的背景
    YYTextBorder *highlightBorder = [YYTextBorder new];
    highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
    highlightBorder.cornerRadius = 3;
    highlightBorder.fillColor = kWBCellTextHighlightBackgroundColor;

    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
    text.font = font;
    text.color = textColor;




    return text;
}


- (NSAttributedString *)_attachmentWithFontSize:(CGFloat)fontSize image:(UIImage *)image shrink:(BOOL)shrink {

    //    CGFloat ascent = YYEmojiGetAscentWithFontSize(fontSize);
    //    CGFloat descent = YYEmojiGetDescentWithFontSize(fontSize);
    //    CGRect bounding = YYEmojiGetGlyphBoundingRectWithFontSize(fontSize);

    // Heiti SC 字体。。
    CGFloat ascent = fontSize * 0.86;
    CGFloat descent = fontSize * 0.14;
    CGRect bounding = CGRectMake(0, -0.14 * fontSize, fontSize, fontSize);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(ascent - (bounding.size.height + bounding.origin.y), 0, descent + bounding.origin.y, 0);

    YYTextRunDelegate *delegate = [YYTextRunDelegate new];
    delegate.ascent = ascent;
    delegate.descent = descent;
    delegate.width = bounding.size.width;

    YYTextAttachment *attachment = [YYTextAttachment new];
    attachment.contentMode = UIViewContentModeScaleAspectFit;
    attachment.contentInsets = contentInsets;
    attachment.content = image;

    if (shrink) {
        // 缩小~
        CGFloat scale = 1 / 10.0;
        contentInsets.top += fontSize * scale;
        contentInsets.bottom += fontSize * scale;
        contentInsets.left += fontSize * scale;
        contentInsets.right += fontSize * scale;
        contentInsets = UIEdgeInsetPixelFloor(contentInsets);
        attachment.contentInsets = contentInsets;
    }

    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:YYTextAttachmentToken];
    [atr setTextAttachment:attachment range:NSMakeRange(0, atr.length)];
    CTRunDelegateRef ctDelegate = delegate.CTRunDelegate;
    [atr setRunDelegate:ctDelegate range:NSMakeRange(0, atr.length)];
    if (ctDelegate) CFRelease(ctDelegate);

    return atr;
}

- (NSAttributedString *)_attachmentWithFontSize:(CGFloat)fontSize imageURL:(NSString *)imageURL shrink:(BOOL)shrink {
    /*
     微博 URL 嵌入的图片，比临近的字体要小一圈。。
     这里模拟一下 Heiti SC 字体，然后把图片缩小一下。
     */
    CGFloat ascent = fontSize * 0.86;
    CGFloat descent = fontSize * 0.14;
    CGRect bounding = CGRectMake(0, -0.14 * fontSize, fontSize, fontSize);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(ascent - (bounding.size.height + bounding.origin.y), 0, descent + bounding.origin.y, 0);
    CGSize size = CGSizeMake(fontSize, fontSize);

    if (shrink) {
        // 缩小~
        CGFloat scale = 1 / 10.0;
        contentInsets.top += fontSize * scale;
        contentInsets.bottom += fontSize * scale;
        contentInsets.left += fontSize * scale;
        contentInsets.right += fontSize * scale;
        contentInsets = UIEdgeInsetPixelFloor(contentInsets);
        size = CGSizeMake(fontSize - fontSize * scale * 2, fontSize - fontSize * scale * 2);
        size = CGSizePixelRound(size);
    }

    YYTextRunDelegate *delegate = [YYTextRunDelegate new];
    delegate.ascent = ascent;
    delegate.descent = descent;
    delegate.width = bounding.size.width;

    WBTextImageViewAttachment *attachment = [WBTextImageViewAttachment new];
    attachment.contentMode = UIViewContentModeScaleAspectFit;
    attachment.contentInsets = contentInsets;
    attachment.size = size;
    attachment.imageURL = [WBStatusHelper defaultURLForImageURL:imageURL];

    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:YYTextAttachmentToken];
    [atr setTextAttachment:attachment range:NSMakeRange(0, atr.length)];
    CTRunDelegateRef ctDelegate = delegate.CTRunDelegate;
    [atr setRunDelegate:ctDelegate range:NSMakeRange(0, atr.length)];
    if (ctDelegate) CFRelease(ctDelegate);

    return atr;
}

- (WBTextLinePositionModifier *)_textlineModifier {
    static WBTextLinePositionModifier *mod;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mod = [WBTextLinePositionModifier new];
        mod.font = [UIFont fontWithName:@"Heiti SC" size:kWBCellTextFontSize];
        mod.paddingTop = 10;
        mod.paddingBottom = 10;
    });
    return mod;
}

@end
