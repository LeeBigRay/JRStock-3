//
//  XJHomeViewController.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "XJHomeViewController.h"
#import "SDCycleScrollView.h"
#import "XJClasslyCollectionViewCell.h"
#import "XJClasslyCollectionReusableView.h"

#import "AFNetworking.h"
#import "CellModel.h"
#import "WSCollectionCell.h"
#import "WSLayout.h"
#import "YTKRequest.h"

#import "BasePuBuViewController.h"

@interface XJHomeViewController ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HomeTypeClickDelegate>
@property (nonatomic, strong) SDCycleScrollView   *cycleScrollView;
@property (nonatomic, strong) UICollectionView    *classifyCollection;
@property (nonatomic, strong) UICollectionView    *pubuliuCollection;
@property (nonatomic, strong) WSLayout            *wslayout;


@end

@implementation XJHomeViewController
{
    NSArray *photoArray;
    NSArray *titlesArray;
    NSMutableArray *modelArray;
}
-(void)changeTab{
    [self.tabBarController setSelectedIndex:0];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTab) name:@"changeTab" object:nil];
    self.navigationItem.title = @"忆言";
    self.view.backgroundColor = RGBACOLOR(240, 240, 240, 1);




    //瀑布流模块
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSString *urlStr = [@"http://image.baidu.com/channel/listjson?pn=0&rn=50&tag1=摄影&tag2=全部&ie=utf8" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *array = [dict[@"data"] mutableCopy];
        [array removeLastObject];

        modelArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {

            CellModel *model = [[CellModel alloc]init];
            model.imgURL = dic[@"image_url"];
            model.imgWidth = [dic[@"image_width"] floatValue];
            model.imgHeight = [dic[@"image_height"] floatValue];
//            model.title = dic[@"abs"];
            model.title = @"自以为是永远都是大敌，因为本可看到的东西也会视而不见";

            [modelArray addObject:model];
        }

        [self _creatSubView];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];


}
//创建瀑布流
- (void)_creatSubView {

    self.wslayout = [[WSLayout alloc] init];
    self.wslayout.headerReferenceSize = CGSizeMake(kScreen_width, HeightScale(300));
    self.wslayout.lineNumber = 2; //列数
    self.wslayout.rowSpacing = 5; //行间距
    self.wslayout.lineSpacing = 5; //列间距
    self.wslayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);

    // 透明时用这个属性(保证collectionView 不会被遮挡, 也不会向下移)
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    // 不透明时用这个属性
    //self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.pubuliuCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height - UXY_TAB_HEIGHT - UXY_NAV_HEIGHT ) collectionViewLayout:self.wslayout];
    [self.pubuliuCollection registerClass:[WSCollectionCell class] forCellWithReuseIdentifier:@"collectionCell"];
    self.pubuliuCollection.dataSource = self;
    self.pubuliuCollection.delegate = self;
//    self.pubuliuCollection.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);

//estimatedRowHeight、estimatedSectionFooterHeight、estimatedSectionHeaderHeight


    self.pubuliuCollection.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    [self.view addSubview:self.pubuliuCollection];
//    [self.pubuliuCollection mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.equalTo(self.classifyCollection.mas_bottom).offset(30);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
//    }];


    //返回每个cell的高   对应indexPath
    [self.wslayout computeIndexCellHeightWithWidthBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {

        CellModel *model = modelArray[indexPath.row];
        CGFloat oldWidth = model.imgWidth;
        CGFloat oldHeight = model.imgHeight;

        CGFloat newWidth = width;
        CGFloat newHeigth = oldHeight*newWidth / oldWidth;
        return newHeigth;
    }];
}
#pragma mark  collectionView   代理数据源

#pragma mark collectionView 代理方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    if (collectionView == self.classifyCollection) {
//        return 10;
//    }else{
        return modelArray.count;
//    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (collectionView == self.classifyCollection) {
//        XJClasslyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XJClasslyCollectionViewCell class]) forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor yellowColor];
//        cell.iconImageView.image = [UIImage imageNamed:@"classly"];
//        cell.titleLabel.text = @"花艺学堂";
//        return cell;
//    }

    WSCollectionCell *cell = (WSCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];

    cell.model = modelArray[indexPath.row];

    return cell;
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 5;
//}
//
//#pragma mark --UIEdageInsetsmake
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(HeightScale(5), WidthScale(5), HeightScale(5), WidthScale(5));
//}
//#pragma mark 返回图标的大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(HeightScale(80),HeightScale(80));
//}

#warning 自定义的layout 不走代理方法
////要先设置表头高度
//-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    CGSize size = CGSizeMake(kScreen_width, 250);
//    return size;
//}

//在表头内添加内容,需要创建一个继承collectionReusableView的类,用法类比tableViewcell
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    // 注册表头
    [collectionView registerClass:[XJClasslyCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([XJClasslyCollectionReusableView class])];
    // 初始化表头
    XJClasslyCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([XJClasslyCollectionReusableView class]) forIndexPath:indexPath];
    headerView.delegate = self;
    return headerView;
}
//pubuli的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了第%ld行第%ld列",indexPath.section,indexPath.row);
    BaseWebViewController *webVc = [[BaseWebViewController alloc]init];
    webVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVc animated:YES];
}


/**
 根据快捷入口 进入分类页面

 */
-(void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    BasePuBuViewController *pubuVc = [[BasePuBuViewController alloc]init];
    [self.navigationController pushViewController:pubuVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
