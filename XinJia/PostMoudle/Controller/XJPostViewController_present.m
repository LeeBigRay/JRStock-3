//
//  XJPostViewController.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "XJPostViewController_present.h"
#import "LSYAlbumCatalog.h"
#import "LSYNavigationController.h"
#import "XJPickPhotoCollectionViewCell.h"
#import "JKPlaceholderTextView.h"
#import "XJPickButtonView.h"

@interface XJPostViewController_present ()<LSYAlbumCatalogDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DeletePhotoDelegate>
@property (nonatomic ,strong)UICollectionView *pickPhotoCollection;
@property (nonatomic ,strong)NSMutableArray *photoArray;
@property (nonatomic ,strong)JKPlaceholderTextView *textTextView;//书写文本
@property (nonatomic ,strong)XJPickButtonView *pickBtnView;
@property (nonatomic ,strong)LSYAlbumCatalog *albumCatalog;//相册选择管理
@property (nonatomic ,copy) NSString *zoneType;//帖子分类
@end

@implementation XJPostViewController_present
-(NSMutableArray *)photoArray{
    if (!_photoArray) {
        _photoArray = [NSMutableArray array];
    }
    return _photoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.navigationItem.title = @"分享你的精致生活";
    self.view.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    UIBarButtonItem *rightBatItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(postDone)];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont fontWithName:@"FZLBJW--GB1-0" size:16] forKey:NSFontAttributeName];
    [rightBatItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBatItem;

    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(BackDone)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    [self.view addSubview:self.textTextView];
//    self.photoArray = @[[UIImage imageNamed:@"cycle3"],[UIImage imageNamed:@"cycle4"],[UIImage imageNamed:@"cycle2"],[UIImage imageNamed:@"cycle3"],[UIImage imageNamed:@"cycle4"],[UIImage imageNamed:@"cycle3"],[UIImage imageNamed:@"cycle4"],[UIImage imageNamed:@"cycle2"]].mutableCopy;
    [self.view addSubview:self.pickPhotoCollection];
    [self.view addSubview:self.pickBtnView];
    [_pickPhotoCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.textTextView.mas_bottom).offset(3);
        make.height.equalTo(@(HeightScale(80)));
    }];
    [_pickBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.pickPhotoCollection.mas_bottom).offset(3);
        make.bottom.equalTo(self.view);
    }];
}
-(void)BackDone{
    //发送通知 改变tabbar的选中
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeTab" object:nil];

    [self dismissViewControllerAnimated:YES completion:^{
        self.tabBarController.selectedIndex = 0;
    }];
}

/**
 发布
 */
-(void)postDone{
    BOOL isSelectedType = false;
    //进行条件判断
    if (self.photoArray.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请上传图片"];
        return;
    }

    if (self.textTextView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入文字"];
        return;
    }

    for (UIButton *btn in self.pickBtnView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn.selected == YES) {
                isSelectedType = true;
                self.zoneType = _pickBtnView.titleArray[btn.tag - 100];
            }
        }

    }
    if (isSelectedType == false) {
        [SVProgressHUD showErrorWithStatus:@"请选择帖子分类"];
        return;
    }
    [SVProgressHUD showInfoWithStatus:@"发布到服务器"];
}

-(XJPickButtonView *)pickBtnView{
    if (!_pickBtnView) {
        _pickBtnView  = [[XJPickButtonView alloc]initWithFrame:CGRectMake(0, (self.photoArray.count/4 +1)*HeightScale(80) + HeightScale(106), kScreen_width, 300)];
        _pickBtnView.titleArray = @[@"花木",@"虫鱼",@"摆件",@"家私",@"其他",@"花木",@"虫鱼",@"摆件",@"家私",@"其他"];


    }
    return _pickBtnView;
}

-(JKPlaceholderTextView *)textTextView{
    if (!_textTextView) {
        _textTextView = [[JKPlaceholderTextView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, HeightScale(100))];
        _textTextView.placehoderText = @"让你的图片说句话(最多输入66字)";
        _textTextView.font = [UIFont systemFontOfSize:14];
        _textTextView.backgroundColor = [UIColor whiteColor];
        _textTextView.limitTextLength = 66;
        @weakify(self);
        _textTextView.limitTextLengthBlock = ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"字数超出限制" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                nil; 
            }];
            [alert addAction:action];
            [weak_self presentViewController:alert animated:YES completion:^{
                nil;
            }];

        };
    }
    return _textTextView;
}

-(UICollectionView *)pickPhotoCollection{
    if (!_pickPhotoCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _pickPhotoCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, HeightScale(103), kScreenWidth, HeightScale(80)) collectionViewLayout:layout];
        _pickPhotoCollection.delegate = self;
        _pickPhotoCollection.dataSource = self;
        _pickPhotoCollection.backgroundColor = [UIColor whiteColor];
        _pickPhotoCollection.showsHorizontalScrollIndicator = NO;

        [_pickPhotoCollection registerClass:[XJPickPhotoCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([XJPickPhotoCollectionViewCell class])];
    }
    return _pickPhotoCollection;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoArray.count + 1 > 9 ? 9 : self.photoArray.count +1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    XJPickPhotoCollectionViewCell *cell = (XJPickPhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XJPickPhotoCollectionViewCell class]) forIndexPath:indexPath];
    //判断图片的显示方式   如果不是9张图 则显示可以继续添加
    if (self.photoArray.count == 9) {
        cell.photoImageView.image = self.photoArray[indexPath.row];
        cell.delegate = self;
        return cell;
    }

    if (indexPath.row == self.photoArray.count) {
        cell.photoImageView.image = [UIImage imageNamed:@"addPhoto"];
        //取消掉图片上的删除按钮
        cell.deleteBtn.hidden = YES;

    }else{
        cell.deleteBtn.hidden = NO;
        cell.photoImageView.image = self.photoArray[indexPath.row];
        cell.delegate = self;
    }

    return cell;
}
-(void)deletePhotoWithCell:(XJPickPhotoCollectionViewCell *)cell{
 NSIndexPath *indexPath = [self.pickPhotoCollection indexPathForCell:cell];
    [self.photoArray removeObjectAtIndex:indexPath.row];
    //选择完毕之后  在该回调方法中 计算可继续添加照片的个数  避免出现照片个数大于9
    self.albumCatalog.maximumNumberOfSelectionPhoto = 9 -self.photoArray.count;
    [self.pickPhotoCollection mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@((self.photoArray.count/4 +1)*HeightScale(80)));
    }];
    [self.pickPhotoCollection reloadData];
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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //如果是点击的图片  则不操作 如果是添加  进行操作
    if (self.photoArray.count == 9) {
        return;
    }
    if (indexPath.row != self.photoArray.count) {
        return;
    }
    [self postPic];
}
//选择照片
-(void)postPic{

    LSYNavigationController *navigation = [[LSYNavigationController alloc] initWithRootViewController:self.albumCatalog];
    [self  presentViewController:navigation animated:YES completion:^{

    }];
}
-(LSYAlbumCatalog *)albumCatalog{
    if (!_albumCatalog) {
        _albumCatalog = [[LSYAlbumCatalog alloc] init];
        _albumCatalog.delegate = self;
        _albumCatalog.maximumNumberOfSelectionPhoto = 9;
    }
    return _albumCatalog;
}
-(void)AlbumDidFinishPick:(NSArray *)assets{
    for (ALAsset *asset in assets) {
            UIImage * img = [UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage];
            [self.photoArray addObject: img];

        }
//选择完毕之后  在该回调方法中 计算可继续添加照片的个数  避免出现照片个数大于9
    self.albumCatalog.maximumNumberOfSelectionPhoto = 9 -self.photoArray.count;
    [self.pickPhotoCollection mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@((self.photoArray.count/4 +1)*HeightScale(80)));
    }];
    [self.pickPhotoCollection reloadData];
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
