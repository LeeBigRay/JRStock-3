//
//  XJMarketViewController.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "XJMarketViewController.h"
#import "XJMarketGoodsTypeCollectionViewCell.h"
#import "XJMarketGoodsTableViewCell.h"

@interface XJMarketViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UICollectionView *goodsTypeCollection;
@property (nonatomic ,strong)UITableView *goodsTypeTableView;
@end

@implementation XJMarketViewController
{
    CGFloat cellheight;
    NSArray *picArray;
    NSArray *titleArray;
}
-(UITableView *)goodsTypeTableView{
    if (!_goodsTypeTableView) {
        _goodsTypeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height - 64 - 49) style:UITableViewStylePlain];
        _goodsTypeTableView.delegate = self;
        _goodsTypeTableView.dataSource = self;
        [_goodsTypeTableView registerClass:[XJMarketGoodsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([XJMarketGoodsTableViewCell class])];

    }
    return _goodsTypeTableView;
}
-(UICollectionView *)goodsTypeCollection{
    if (!_goodsTypeCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _goodsTypeCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightScale(80) * 2 +10) collectionViewLayout:layout];
        _goodsTypeCollection.delegate = self;
        _goodsTypeCollection.dataSource = self;
        _goodsTypeCollection.backgroundColor = [UIColor whiteColor];
        _goodsTypeCollection.showsHorizontalScrollIndicator = NO;
        _goodsTypeCollection.scrollEnabled = NO;

        [_goodsTypeCollection registerClass:[XJMarketGoodsTypeCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([XJMarketGoodsTypeCollectionViewCell class])];

        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightScale(80)*2, kScreen_width, 10)];
        lineLabel.backgroundColor = ViewGrayColor;
        [_goodsTypeCollection addSubview:lineLabel];

    }
    return _goodsTypeCollection;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XJMarketGoodsTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XJMarketGoodsTypeCollectionViewCell class]) forIndexPath:indexPath];
    cell.PictureImageView.image = picArray[indexPath.row];
    cell.titleLabel.text = titleArray[indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(HeightScale(70), HeightScale(70));
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    //    return 2;
    return (kScreen_width - HeightScale(70)*4 - 10 )/3.;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return HeightScale(10);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(HeightScale(5), 5, HeightScale(5), 5);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellheight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XJMarketGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XJMarketGoodsTableViewCell class])];
    if (!cell) {
        cell = [[XJMarketGoodsTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([XJMarketGoodsTableViewCell class ])];
    }
    //传递model  cell接收到model 计算高度
    cellheight = [cell getCellHeight];
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    picArray = @[[UIImage imageNamed:@"花束"],[UIImage imageNamed:@"车厘子"],[UIImage imageNamed:@"台灯"],[UIImage imageNamed:@"大提琴"],[UIImage imageNamed:@"花束"],[UIImage imageNamed:@"车厘子"],[UIImage imageNamed:@"台灯"],[UIImage imageNamed:@"大提琴"]];
    titleArray = @[@"鲜花",@"绿植",@"摆件",@"乐器",@"鲜花",@"绿植",@"摆件",@"乐器"];
    [self.view addSubview:self.goodsTypeTableView];
    self.navigationItem.title = @"是你的宝贝";
    self.goodsTypeTableView.tableHeaderView = self.goodsTypeCollection;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
