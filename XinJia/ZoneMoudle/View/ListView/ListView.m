//
//  ListView.m
//  ListViewDemo
//
//  Created by JeffreyPH on 16/3/30.
//  Copyright © 2016年 JeffreyPH. All rights reserved.
//

#import "ListView.h"
#import "ListCell.h"

#define kTriangleWidth 15
#define kMaxTableViewCellCount 6

typedef NS_ENUM(NSInteger,DirectionType) {
    DirectionTypeLeftTop,
    DirectionTypeRightTop,
    DirectionTypeLeftBottom,
    DirectionTypeRightBottom
};

@interface ListView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *bgdView;

@property (nonatomic, assign, getter=isAsc) BOOL asc;

@property (nonatomic, weak) CAShapeLayer *triangleLayer;

@property (nonatomic, copy) NSArray *items;

@property (nonatomic, assign) CGRect rect;

@property (nonatomic, copy) SelectBlock select;

@end

@implementation ListView


- (instancetype)initWithReferFrame:(CGRect)rect items:(NSArray <ListItem *>*)items select:(SelectBlock)select{
    self = [super init];
    if(self){
        self.items = items;
        self.rect = rect;
        self.select = select;
        [self setupView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setupTriangle];
        });
    }
    return self;
}

+ (instancetype)listViewWithReferFrame:(CGRect)rect items:(NSArray<ListItem *> *)items select:(SelectBlock)select{
    return [[self alloc] initWithReferFrame:rect items:items select:select];
}

- (UIView *)bgdView{
    if(!_bgdView){
        _bgdView = [[UIView alloc] init];
        _bgdView.backgroundColor = [UIColor blackColor];
        _bgdView.alpha = .1;
    }
    return _bgdView;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 40;
        _tableView.layer.cornerRadius = 5;
        _tableView.clipsToBounds = YES;
        _tableView.scrollEnabled = (self.items.count > kMaxTableViewCellCount);
        _tableView.bounces = (self.items.count > kMaxTableViewCellCount);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}



- (DirectionType)getTableViewDirectionType{
    
//    CGFloat cX = self.rect.origin.x + self.rect.size.width/2.0 - self.center.x;
//    CGFloat cY = self.rect.origin.y + self.rect.size.height/2.0 - self.center.y;
//    
//    _asc = (cY <= 0);
//    if(!_asc)
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.items.count - 1 inSection: 0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
//    });
//    
//    DirectionType type;
//    if(cX <= 0 && cY <= 0){
//        
//        type = DirectionTypeLeftTop;
//    }
////    else if(cX > 0 && cY < 0){
////        
////        type = DirectionTypeRightTop;
////    }else if(cX < 0 && cY > 0){
////        
////        type = DirectionTypeLeftBottom;
////        
////    }
//    else{
//        
//        type = DirectionTypeRightTop;
//    }
    return DirectionTypeRightTop;
}

- (void)setupView{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    self.bgdView.frame = window.bounds;
    [self addSubview:self.bgdView];
    
    [self setuptableView];
    self.tableView.transform = CGAffineTransformMakeScale(0, 0);
    self.tableView.alpha = 0;
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.tableView.transform = CGAffineTransformMakeScale(1, 1);
        self.tableView.alpha = 1;
    } completion:nil];
    
    [self addSubview:self.tableView];
}

- (void)setuptableView{
    CGFloat tW = 135;
    
    NSInteger minCount = MIN(self.items.count, kMaxTableViewCellCount);
    CGFloat tH = self.tableView.rowHeight * minCount - 1;
    
    CGFloat triangleH = kTriangleWidth/2.0 * sqrt(3.0);
    CGFloat tX,tY;
    CGPoint positionP, anchorP;
    switch ([self getTableViewDirectionType]) {
        case DirectionTypeLeftTop:
        {
            tX = CGRectGetMinX(self.rect);
            tY = CGRectGetMaxY(self.rect) + triangleH - 1;
            positionP = CGPointMake(tX, tY);
            anchorP = CGPointMake(0, 0);
        }
            break;
        case DirectionTypeRightTop:
        {
            tX = CGRectGetMinX(self.rect) - tW;
            tY = CGRectGetMaxY(self.rect) + triangleH - 1;
            positionP = CGPointMake(CGRectGetMaxX(self.rect), tY);
            anchorP = CGPointMake(1, 0);
        }
            break;
        case DirectionTypeLeftBottom:
        {
            tX = CGRectGetMinX(self.rect);
            tY = CGRectGetMinY(self.rect) - tH - triangleH + 1;
            positionP = CGPointMake(tX, CGRectGetMinY(self.rect)- triangleH);
            anchorP = CGPointMake(0, 1);
        }
            break;
        default:
        {
            tX = CGRectGetMinX(self.rect) - tW;
            tY = CGRectGetMinY(self.rect) - tH - triangleH + 1;
            positionP = CGPointMake(CGRectGetMaxX(self.rect), CGRectGetMinY(self.rect)- triangleH);
            anchorP = CGPointMake(1, 1);
        }
            break;
    }
    self.tableView.frame = CGRectMake(tX, tY, tW, tH);
    self.tableView.layer.position = positionP;
    self.tableView.layer.anchorPoint = anchorP;
}

- (void)setupTriangle{
    
    CGFloat tX = self.rect.origin.x + self.rect.size.width/2.0;
    
    CGFloat paddingX = kTriangleWidth/2.0;
    CGFloat paddingY = kTriangleWidth/2.0 * sqrt(3.0);
    CGPoint triangleTopP,triangleLeftP,triangleRightP;
    switch ([self getTableViewDirectionType]) {
        case DirectionTypeLeftTop:
        case DirectionTypeRightTop:
        {
            triangleTopP = CGPointMake(tX, CGRectGetMaxY(self.rect));
            triangleLeftP = CGPointMake(tX - paddingX, CGRectGetMaxY(self.rect) + paddingY);
            triangleRightP = CGPointMake(tX + paddingX, CGRectGetMaxY(self.rect) + paddingY);
        }
            break;
            
        default:
        {
            triangleTopP = CGPointMake(tX, CGRectGetMinY(self.rect));
            triangleLeftP = CGPointMake(tX - paddingX, CGRectGetMinY(self.rect) - paddingY);
            triangleRightP = CGPointMake(tX + paddingX, CGRectGetMinY(self.rect) - paddingY);
        }
            
            break;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:triangleTopP];
    [path addLineToPoint:triangleLeftP];
    [path addLineToPoint:triangleRightP];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.speed = 0.25;
    layer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:layer];
    _triangleLayer = layer;

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListCell *cell = [ListCell cellWithTableView:tableView];
    NSInteger index = _asc ? indexPath.row : self.items.count - indexPath.row - 1;
    cell.item = self.items[index];
    cell.showSeperatorLine = (indexPath.row != self.items.count - 1);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.select){
        self.select(indexPath.row);
    }
    [self removeSelf];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    if(touch.view == self.bgdView){
       
        [self removeSelf];
    }
}

- (void)removeSelf{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.triangleLayer removeFromSuperlayer];
    });
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.tableView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.tableView.alpha = 0;
    } completion:^(BOOL finished) {
        if(finished)
            [self removeFromSuperview];
    }];
}

@end
