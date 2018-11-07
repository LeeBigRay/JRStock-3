//
//  XJZoneTableViewCell.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/30.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "XJZoneTableViewCell.h"
#import "WBStatusHelper.h"
#import "YYControl.h"
#import "WBStatusLayout.h"



@implementation WBStatusProfileView
{
    BOOL _trackingTouch;

}
- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = kWBCellProfileHeight;
    }
    self = [super initWithFrame:frame];
    self.exclusiveTouch = YES;
//    @weakify(self);

    //头像
    _avatarView = [UIImageView new];
    _avatarView.size = CGSizeMake(40, 40);
//    _avatarView.clipsToBounds = YES;
    _avatarView.layer.cornerRadius = 20;
    _avatarView.layer.masksToBounds = YES;
    _avatarView.origin = CGPointMake(kWBCellPadding, kWBCellPadding+3);
//    _avatarView.image = [UIImage imageNamed:@"cycle5"];
    _avatarView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_avatarView];
#warning tap 不生效
    @weakify(self);
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
//        XJZoneTableViewCell *cell = weak_self.cell;
//        if ([cell.delegate respondsToSelector:@selector(cellDidClickUser:)]) {
//            [cell.delegate cellDidClickUser:cell];
//        }
//    }];
//    [_avatarView addGestureRecognizer:tap];

//    //圆角layer
//    CALayer *avatarBorder = [CALayer layer];
//    avatarBorder.frame = _avatarView.bounds;
//    avatarBorder.borderWidth = CGFloatFromPixel(1);
//    avatarBorder.borderColor = [UIColor colorWithWhite:0.000 alpha:0.090].CGColor;
//    avatarBorder.cornerRadius = _avatarView.height / 2;
//    avatarBorder.shouldRasterize = YES;
//    avatarBorder.rasterizationScale = kScreenScale;
//    [_avatarView.layer addSublayer:avatarBorder];

    //用户昵称
    _nameLabel = [YYLabel new];
//    _nameLabel.text = @"我真的是你瑞哥";
    _nameLabel.size = CGSizeMake(kWBCellNameWidth, 24);
    _nameLabel.left = _avatarView.right + kWBCellNamePaddingLeft;
    _nameLabel.centerY = 27;
    _nameLabel.displaysAsynchronously = YES;
    _nameLabel.ignoreCommonProperties = YES;
    _nameLabel.fadeOnAsynchronouslyDisplay = NO;
    _nameLabel.fadeOnHighlight = NO;
    _nameLabel.lineBreakMode = NSLineBreakByClipping;
    _nameLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    [self addSubview:_nameLabel];

    _timeLabel = [YYLabel new];
    _timeLabel.size = CGSizeMake(100, 24);
    _timeLabel.centerY = 27;
    _timeLabel.left = kScreenWidth - 60;
    _timeLabel.displaysAsynchronously = YES;
    _timeLabel.ignoreCommonProperties = YES;
    _timeLabel.fadeOnAsynchronouslyDisplay = NO;
    _timeLabel.fadeOnHighlight = NO;

    _timeLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_timeLabel];

    _reportButton = [UIButton new];
    _reportButton.size = CGSizeMake(32, 32);
    _reportButton.centerY = 42;
    _reportButton.right = kScreenWidth - 10;
    _reportButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_reportButton setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
    [self addSubview:_reportButton];

    [_reportButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        XJZoneTableViewCell *cell = weak_self.cell;
        if ([cell.delegate respondsToSelector:@selector(cellDidClickMenu:)]) {
            [cell.delegate cellDidClickMenu:cell];
        }

    }];

   
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _trackingTouch = NO;
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:_avatarView];
    if (CGRectContainsPoint(_avatarView.bounds, p)) {
        _trackingTouch = YES;
    }
    p = [t locationInView:_nameLabel];
    if (CGRectContainsPoint(_nameLabel.bounds, p) && _nameLabel.textLayout.textBoundingRect.size.width > p.x) {
        _trackingTouch = YES;
    }
    if (!_trackingTouch) {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_trackingTouch) {
        [super touchesEnded:touches withEvent:event];
    } else {
        if ([_cell.delegate respondsToSelector:@selector(cell:didClickUser:)]) {
            [_cell.delegate cell:_cell didClickUser:_cell.statusView.layout.status.user];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_trackingTouch) {
        [super touchesCancelled:touches withEvent:event];
    }
}


@end

@implementation WBStatusToolbarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = kWBCellToolbarHeight;
    }
    self = [super initWithFrame:frame];
    self.exclusiveTouch = YES;

    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _likeButton.exclusiveTouch = YES;
    _likeButton.size = CGSizeMake(CGFloatPixelRound(self.width / 3.0), self.height);
    [_likeButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];

    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentButton.exclusiveTouch = YES;
    _commentButton.size = CGSizeMake(CGFloatPixelRound(self.width / 3.0), self.height);
    _commentButton.left = CGFloatPixelRound(self.width / 3.0);
    [_commentButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];

    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareButton.exclusiveTouch = YES;
    _shareButton.size = CGSizeMake(CGFloatPixelRound(self.width / 3.0), self.height);
    _shareButton.left = CGFloatPixelRound(self.width / 3.0 * 2.0);
    [_shareButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];

    _likeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"like"]];
    _likeImageView.centerY = self.height / 2;
    [_likeButton addSubview:_likeImageView];

    
    _commentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comment"]];
    _commentImageView.centerY = self.height / 2;
    [_commentButton addSubview:_commentImageView];


    _shareImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share"]];
    _shareImageView.centerY = self.height / 2;
    [_shareButton addSubview:_shareImageView];

    _likeLabel = [YYLabel new];
    _likeLabel.userInteractionEnabled = NO;
    _likeLabel.height = self.height;
    _likeLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _likeLabel.displaysAsynchronously = YES;
    _likeLabel.ignoreCommonProperties = YES;
    _likeLabel.fadeOnHighlight = NO;
    _likeLabel.fadeOnAsynchronouslyDisplay = NO;
    [_likeButton addSubview:_likeLabel];

    _commentLabel = [YYLabel new];
    _commentLabel.userInteractionEnabled = NO;
    _commentLabel.height = self.height;
    _commentLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _commentLabel.displaysAsynchronously = YES;
    _commentLabel.ignoreCommonProperties = YES;
    _commentLabel.fadeOnHighlight = NO;
    _commentLabel.fadeOnAsynchronouslyDisplay = NO;
    [_commentButton addSubview:_commentLabel];

    _shareLabel = [YYLabel new];
    _shareLabel.userInteractionEnabled = NO;
    _shareLabel.height = self.height;
    _shareLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _shareLabel.displaysAsynchronously = YES;
    _shareLabel.ignoreCommonProperties = YES;
    _shareLabel.fadeOnHighlight = NO;
    _shareLabel.fadeOnAsynchronouslyDisplay = NO;
    [_shareButton addSubview:_shareLabel];

    UIColor *dark = [UIColor colorWithWhite:0 alpha:0.2];
    UIColor *clear = [UIColor colorWithWhite:0 alpha:0];
    NSArray *colors = @[(id)clear.CGColor,(id)dark.CGColor, (id)clear.CGColor];
    NSArray *locations = @[@0.2, @0.5, @0.8];

    _line1 = [CAGradientLayer layer];
    _line1.colors = colors;
    _line1.locations = locations;
    _line1.startPoint = CGPointMake(0, 0);
    _line1.endPoint = CGPointMake(0, 1);
    _line1.size = CGSizeMake(CGFloatFromPixel(1), self.height);
    _line1.left = _likeButton.right;

    _line2 = [CAGradientLayer layer];
    _line2.colors = colors;
    _line2.locations = locations;
    _line2.startPoint = CGPointMake(0, 0);
    _line2.endPoint = CGPointMake(0, 1);
    _line2.size = CGSizeMake(CGFloatFromPixel(1), self.height);
    _line2.left = _commentButton.right;

    _topLine = [CALayer layer];
    _topLine.size = CGSizeMake(self.width, CGFloatFromPixel(1));
    _topLine.backgroundColor = kWBCellLineColor.CGColor;

    _bottomLine = [CALayer layer];
    _bottomLine.size = _topLine.size;
    _bottomLine.bottom = self.height;
    _bottomLine.backgroundColor = UIColorHex(e8e8e8).CGColor;

    [self addSubview:_likeButton];
    [self addSubview:_commentButton];
    [self addSubview:_shareButton];
    [self.layer addSublayer:_line1];
    [self.layer addSublayer:_line2];
    [self.layer addSublayer:_topLine];
    [self.layer addSublayer:_bottomLine];

    @weakify(self);
    [_likeButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        XJZoneTableViewCell *cell = weak_self.cell;
        if ([cell.delegate respondsToSelector:@selector(cellDidClickLike:)]) {
            [cell.delegate cellDidClickLike:cell];
        }
    }];


    [_commentButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        XJZoneTableViewCell *cell = weak_self.cell;
        if ([cell.delegate respondsToSelector:@selector(cellDidClickComment:)]) {
            [cell.delegate cellDidClickComment:cell];
        }
    }];

    [_shareButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        XJZoneTableViewCell *cell = weak_self.cell;
        if ([cell.delegate respondsToSelector:@selector(cellDidClickShare:)]) {
            [cell.delegate cellDidClickShare:cell];
        }
    }];
    return self;
}


- (void)setWithLayout:(WBStatusLayout *)layout {
    _likeLabel.width = layout.toolbarLikeTextWidth;
    _commentLabel.width = layout.toolbarCommentTextWidth;
    _shareLabel.width = layout.toolbarShareTextWidth;

    _likeLabel.textLayout = layout.toolbarLikeTextLayout;
    _commentLabel.textLayout = layout.toolbarCommentTextLayout;
    _shareLabel.textLayout = layout.toolbarShareTextLayout;

    [self adjustImage:_likeImageView label:_likeLabel inButton:_likeButton];
    [self adjustImage:_commentImageView label:_commentLabel inButton:_commentButton];
    [self adjustImage:_shareImageView label:_shareLabel inButton:_shareButton];

    _likeImageView.image = layout.status.attitudesStatus ? [self likeImage] : [self unlikeImage];
}

- (UIImage *)likeImage {
    static UIImage *img;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        img = [UIImage imageNamed:@"like_click"];
    });
    return img;
}

- (UIImage *)unlikeImage {
    static UIImage *img;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        img = [UIImage imageNamed:@"like"];
    });
    return img;
}

- (void)adjustImage:(UIImageView *)image label:(YYLabel *)label inButton:(UIButton *)button {
    CGFloat imageWidth = image.bounds.size.width;
    CGFloat labelWidth = label.width;
    CGFloat paddingMid = 5;
    CGFloat paddingSide = (button.width - imageWidth - labelWidth - paddingMid) / 2.0;
    image.centerX = CGFloatPixelRound(paddingSide + imageWidth / 2);
    label.right = CGFloatPixelRound(button.width - paddingSide);
}

- (void)setLiked:(BOOL)liked withAnimation:(BOOL)animation {
    WBStatusLayout *layout = _cell.statusView.layout;
    if (layout.status.attitudesStatus == liked) return;

    UIImage *image = liked ? [self likeImage] : [self unlikeImage];
    int newCount = layout.status.attitudesCount;
    newCount = liked ? newCount + 1 : newCount - 1;
    if (newCount < 0) newCount = 0;
    if (liked && newCount < 1) newCount = 1;
    NSString *newCountDesc = newCount > 0 ? [WBStatusHelper shortedNumberDesc:newCount] : @"赞";

    UIFont *font = [UIFont systemFontOfSize:kWBCellToolbarFontSize];
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth, kWBCellToolbarHeight)];
    container.maximumNumberOfRows = 1;
    NSMutableAttributedString *likeText = [[NSMutableAttributedString alloc] initWithString:newCountDesc];
    likeText.font = font;
    likeText.color = liked ? kWBCellToolbarTitleHighlightColor : kWBCellToolbarTitleColor;
    YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:container text:likeText];

    layout.status.attitudesStatus = liked;
    layout.status.attitudesCount = newCount;
    layout.toolbarLikeTextLayout = textLayout;

    if (!animation) {
        _likeImageView.image = image;
        _likeLabel.width = CGFloatPixelRound(textLayout.textBoundingRect.size.width);
        _likeLabel.textLayout = layout.toolbarLikeTextLayout;
        [self adjustImage:_likeImageView label:_likeLabel inButton:_likeButton];
        return;
    }

    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        _likeImageView.layer.transformScale = 1.7;
    } completion:^(BOOL finished) {

        _likeImageView.image = image;
        _likeLabel.width = CGFloatPixelRound(textLayout.textBoundingRect.size.width);
        _likeLabel.textLayout = layout.toolbarLikeTextLayout;
        [self adjustImage:_likeImageView label:_likeLabel inButton:_likeButton];

        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            _likeImageView.layer.transformScale = 0.9;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                _likeImageView.layer.transformScale = 1;
            } completion:^(BOOL finished) {
            }];
        }];
    }];
}



@end

@implementation WBStatusView

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = 1;
    }
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    self.exclusiveTouch = YES;
    @weakify(self);

    _contentView = [UIView new];
    _contentView.width = kScreenWidth;
    _contentView.height = 1;
    _contentView.backgroundColor = [UIColor whiteColor];
    static UIImage *topLineBG, *bottomLineBG;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        topLineBG = [UIImage imageWithSize:CGSizeMake(1, 3) drawBlock:^(CGContextRef context) {
            CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
            CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 0.8, [UIColor colorWithWhite:0 alpha:0.08].CGColor);
            CGContextAddRect(context, CGRectMake(-2, 3, 4, 4));
            CGContextFillPath(context);
        }];
        bottomLineBG = [UIImage imageWithSize:CGSizeMake(1, 3) drawBlock:^(CGContextRef context) {
            CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
            CGContextSetShadowWithColor(context, CGSizeMake(0, 0.4), 2, [UIColor colorWithWhite:0 alpha:0.08].CGColor);
            CGContextAddRect(context, CGRectMake(-2, -2, 4, 2));
            CGContextFillPath(context);
        }];
    });
    UIImageView *topLine = [[UIImageView alloc] initWithImage:topLineBG];
    topLine.width = _contentView.width;
    topLine.bottom = 0;
    topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [_contentView addSubview:topLine];


    UIImageView *bottomLine = [[UIImageView alloc] initWithImage:bottomLineBG];
    bottomLine.width = _contentView.width;
    bottomLine.top = _contentView.height;
    bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_contentView addSubview:bottomLine];
    [self addSubview:_contentView];

//用户栏
    _profileView = [WBStatusProfileView new];
    [_contentView addSubview:_profileView];

//内容文本
    _textLabel = [YYLabel new];
//    _textLabel.text = @"真心想，其实并没有什么可遗憾的，也许本来就是命运的安排，并不是我们能够左右的";
    _textLabel.left = kWBCellPadding;
    _textLabel.width = kWBCellContentWidth;
    _textLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _textLabel.displaysAsynchronously = YES;
    _textLabel.ignoreCommonProperties = YES;
    _textLabel.fadeOnAsynchronouslyDisplay = NO;
    _textLabel.fadeOnHighlight = NO;
    [_contentView addSubview:_textLabel];

    _toolBarView = [WBStatusToolbarView new];
    [_contentView addSubview:_toolBarView];

    return self;
}

- (void)setLayout:(WBStatusLayout *)layout {
    _layout = layout;

    self.height = layout.height;
    _contentView.top = layout.marginTop;
    _contentView.height = layout.height - layout.marginTop - layout.marginBottom;

    CGFloat top = 0;


    /// 圆角头像
    [_profileView.avatarView setImageWithURL:_layout.status.user.avatarLarge //profileImageURL
                                 placeholder:nil
                                     options:kNilOptions
                                     manager:[WBStatusHelper avatarImageManager] ///< 圆角头像manager，内置圆角处理
                                    progress:nil
                                   transform:nil
                                  completion:nil];

    _profileView.nameLabel.textLayout = layout.nameTextLayout;
    _profileView.timeLabel.textLayout = layout.timeTextLayout;
//    _profileView.verifyType = layout.status.user.userVerifyType;
    _profileView.height = layout.profileHeight;
    _profileView.top = top;
    top += layout.profileHeight;

    NSURL *picBg = [WBStatusHelper defaultURLForImageURL:layout.status.picBg];

    _textLabel.top = top;
    _textLabel.height = layout.textHeight;
    _textLabel.textLayout = layout.textLayout;
    top += layout.textHeight;
    _toolBarView.bottom = _contentView.height;
    [_toolBarView setWithLayout:layout];
}






@end

@implementation XJZoneTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _statusView = [WBStatusView new];
        _statusView.cell = self;
        _statusView.profileView.cell = self;
        _statusView.toolBarView.cell = self;
        [self.contentView addSubview:_statusView];

    }
    return self;
}

- (void)setLayout:(WBStatusLayout *)layout {
    self.height = layout.height;
    self.contentView.height = layout.height;
    _statusView.layout = layout;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
