//
//  BasePuBuViewController.m
//  XinJia
//
//  Created by 李瑞 on 2017/6/12.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "BasePuBuViewController.h"
#import "AFNetworking.h"
#import "CellModel.h"
#import "WSCollectionCell.h"
#import "WSLayout.h"
#import "YTKRequest.h"

@interface BasePuBuViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView    *pubuliuCollection;
@property (nonatomic, strong) WSLayout            *wslayout;
@end

@implementation BasePuBuViewController
{

    NSMutableArray *modelArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"心家";
    self.view.backgroundColor = RGBACOLOR(240, 240, 240, 1);

    //瀑布流模块
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSString *urlStr = [@"http://image.baidu.com/channel/listjson?pn=0&rn=50&tag1=体育&tag2=全部&ie=utf8" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

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
            model.title = dic[@"abs"];

            [modelArray addObject:model];
        }

        [self _creatSubView];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];


}
//创建瀑布流
- (void)_creatSubView {

    self.wslayout = [[WSLayout alloc] init];
    self.wslayout.lineNumber = 3; //列数
    self.wslayout.rowSpacing = 5; //行间距
    self.wslayout.lineSpacing = 5; //列间距
    self.wslayout.headerReferenceSize = CGSizeMake(kScreen_width, 3);

    self.wslayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);

    // 透明时用这个属性(保证collectionView 不会被遮挡, 也不会向下移)
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    // 不透明时用这个属性
    //self.extendedLayoutIncludesOpaqueBars = YES;

    self.pubuliuCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height - 64) collectionViewLayout:self.wslayout];
    [self.pubuliuCollection registerClass:[WSCollectionCell class] forCellWithReuseIdentifier:@"collectionCell"];
    self.pubuliuCollection.dataSource = self;
    self.pubuliuCollection.delegate = self;
    //    self.pubuliuCollection.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);

    self.pubuliuCollection.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    [self.view addSubview:self.pubuliuCollection];


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
    return modelArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    WSCollectionCell *cell = (WSCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    cell.model = modelArray[indexPath.row];

    return cell;
}

#pragma mark --UIEdageInsetsmake
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(HeightScale(5), WidthScale(5), HeightScale(5), WidthScale(5));
}

@end
