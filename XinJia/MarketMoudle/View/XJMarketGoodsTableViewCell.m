//
//  XJMarketGoodsTableViewCell.m
//  XinJia
//
//  Created by 李瑞 on 2017/6/5.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "XJMarketGoodsTableViewCell.h"
#import "XJMarketGoodsTabCollectionCell.h"
#define radioWH 1.4    //设定cell的宽高比例 h/w

@interface XJMarketGoodsTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong)UICollectionView *Goodscollection;
@property (nonatomic ,strong)UILabel *headLabel;//
@property (nonatomic ,strong)UIButton *moreBtn;//
@end
@implementation XJMarketGoodsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    //为了能够更方便的赋值和管理  将表头直接写在cell内部
    self.headLabel = [UILabel new];
    self.headLabel.text = @"鲜花绿植";
    self.headLabel.font = [UIFont systemFontOfSize:14];
    self.headLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_headLabel];
    [_headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(-60);
        make.height.equalTo(@30);
    }];

    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.moreBtn setImage:[UIImage imageNamed:@"more_arrow"] forState:UIControlStateNormal];
//    [self.moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [self.contentView addSubview:_moreBtn];
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.equalTo(@30);
        make.top.equalTo(self.contentView).offset(0);
        make.height.equalTo(@30);
    }];




    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _Goodscollection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _Goodscollection.backgroundColor = ViewGrayColor;
    _Goodscollection.delegate = self;
    _Goodscollection.dataSource = self;
    _Goodscollection.backgroundColor = [UIColor whiteColor];
    _Goodscollection.showsHorizontalScrollIndicator = NO;
    _Goodscollection.scrollEnabled = NO;
    [self.contentView addSubview:_Goodscollection];
    [_Goodscollection registerClass:[XJMarketGoodsTabCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([XJMarketGoodsTabCollectionCell class])];
    [_Goodscollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(35, 0, 5, 0));
    }];

    UILabel *lineLabel = [UILabel new];
    lineLabel.backgroundColor = ViewGrayColor;
    [self.contentView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@5);
    }];

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XJMarketGoodsTabCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XJMarketGoodsTabCollectionCell class]) forIndexPath:indexPath];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreen_width - 25)/2., (kScreen_width - 25)/2. + 40);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 5;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 10, 10);
}

-(CGFloat)getCellHeight{
    return (5/2 +1) * ((kScreen_width - 25)/2. + 40 + 5) +20 + 30 + 5;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
