//
//  XJClasslyCollectionReusableView.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "XJClasslyCollectionReusableView.h"
#import "XJClasslyCollectionViewCell.h"
#import "BaseWebViewController.h"

@interface XJClasslyCollectionReusableView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>

@end
@implementation XJClasslyCollectionReusableView
{
    NSArray *photoArray;
    NSArray *titlesArray;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBACOLOR(240, 240, 240, 1);
        // 网络加载 --- 创建图片轮播器
        photoArray = @[[UIImage imageNamed:@"cycle1"],[UIImage imageNamed:@"cycle2"],[UIImage imageNamed:@"cycle3"],[UIImage imageNamed:@"cycle5"],[UIImage imageNamed:@"cycle6"]];
        titlesArray = @[@"看的见的音乐",@"每个人都有一“杯”子",@"看的见的花香",@"你的书桌可以更美",@"嗅到了太阳的香味"];
        self.cycleScrollView =
        [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreen_width, HeightScale(130)) delegate:self placeholderImage:[UIImage imageNamed:@"zwp"]];
        if (photoArray.count != 0) {
            _cycleScrollView.localizationImageNamesGroup = photoArray;
            _cycleScrollView.titlesGroup = titlesArray;
            _cycleScrollView.titleLabelTextAlignment = NSTextAlignmentCenter;
            _cycleScrollView.titleLabelTextFont = [UIFont systemFontOfSize:16];
            _cycleScrollView.titleLabelBackgroundColor = [UIColor clearColor];
            _cycleScrollView.autoScrollTimeInterval = 6.66;
        }
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.delegate = self;
        _cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        [self addSubview:_cycleScrollView];
        [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(@(HeightScale(130)));
        }];

        //创建快捷入口的标注
        UILabel *classlyLabel = [UILabel new];
        classlyLabel.textAlignment = NSTextAlignmentLeft;
        classlyLabel.textColor = [UIColor blackColor];
        classlyLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:classlyLabel];
        classlyLabel.text = @"专题推荐";
        [classlyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.cycleScrollView.mas_bottom).offset(HeightScale(10));
            make.right.equalTo(self.mas_right);
            make.height.equalTo(@(HeightScale(20)));
        }];

        //创建快捷入口
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 40;
        self.classifyCollection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        self.classifyCollection.delegate = self;
        self.classifyCollection.dataSource = self;
        self.classifyCollection.showsVerticalScrollIndicator = NO;
        self.classifyCollection.showsHorizontalScrollIndicator = NO;
        self.classifyCollection.backgroundColor = [UIColor whiteColor];
        [self.classifyCollection registerClass:[XJClasslyCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([XJClasslyCollectionViewCell class])];
        [self addSubview:_classifyCollection];
        [_classifyCollection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(classlyLabel.mas_bottom).with.offset(HeightScale(10));
            make.left.right.equalTo(self);
            make.height.equalTo(@(HeightScale(90)));
        }];

        //创建瀑布流标注
        //创建快捷入口的标注
        UILabel *pubuliuLabel = [UILabel new];
        pubuliuLabel.textAlignment = NSTextAlignmentLeft;
        pubuliuLabel.textColor = [UIColor blackColor];
        pubuliuLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:pubuliuLabel];
        pubuliuLabel.text = @"今日最热";
        [pubuliuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.classifyCollection.mas_bottom).offset(HeightScale(10));
            make.right.equalTo(self.mas_right);
            make.height.equalTo(@(HeightScale(20)));
        }];

    }
    return self;
}
#pragma mark collectionView 代理方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

        return 10;

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

        XJClasslyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XJClasslyCollectionViewCell class]) forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor yellowColor];
        cell.iconImageView.image = [UIImage imageNamed:@"cycle3"];
        cell.titleLabel.text = @"花艺学堂";
        return cell;

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

#pragma mark --UIEdageInsetsmake
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(HeightScale(5), WidthScale(5), HeightScale(5), WidthScale(5));
}
#pragma mark 返回图标的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(HeightScale(80),HeightScale(80));
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate didSelectItemAtIndexPath:indexPath];
}


/**
 轮播图点击事件
 */

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
  UIViewController *vc =  [XJHelper getCurrentViewController:self];
    NSLog(@"%@",[vc class]);//获取到  XJHomeViewController
    BaseWebViewController *webVc = [[BaseWebViewController alloc]init];
    webVc.hidesBottomBarWhenPushed = YES;
    [vc.navigationController pushViewController:webVc animated:YES];
}



@end
