//
//  XJPost_PresentViewController.m
//  XinJia
//
//  Created by 李瑞 on 2018/11/5.
//  Copyright © 2018 RayKi. All rights reserved.
//

#import "XJPost_PresentViewController.h"
#import "Masonry.h"
#import "MMPhotoPickerController.h"
#import "XJNavigationViewController.h"
#import "JKPlaceholderTextView.h"
#import "XJPickButtonView.h"

@interface XJPost_PresentViewController ()<MMPhotoPickerDelegate>
@property (nonatomic ,strong)UIButton *choosePicBtn;
@property (nonatomic ,strong)UIView *bgView;
@property (nonatomic ,strong)UIImageView *bgImageView;
@property (nonatomic ,strong)UIView *maskView;
@property (nonatomic ,strong)UILabel *contentLabel;
@property (nonatomic ,strong)JKPlaceholderTextView *textTextView;//书写文本
@property (nonatomic ,strong)XJPickButtonView *pickBtnView;
@property (nonatomic ,copy) NSString *zoneType;//帖子分类
@property (nonatomic ,strong)UILabel *isSrc;//是否私密
@property (nonatomic ,strong)UISwitch *isSrcSwitch;//是否私密

@end

@implementation XJPost_PresentViewController
// 加载所有UI控件
-(void) _setupUI{
    // 懒加载所有控件
//    [self.view addSubview:self.choosePicBtn];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.bgImageView];
    [self.bgView addSubview:self.maskView];
    [self.bgView addSubview:self.contentLabel];
    [self.view addSubview:self.textTextView];
    [self.view addSubview:self.isSrc];
    [self.view addSubview:self.isSrcSwitch];
    [self.view addSubview:self.pickBtnView];
    _choosePicBtn.backgroundColor = [UIColor grayColor];
    _bgImageView.backgroundColor = [UIColor whiteColor];
    _contentLabel.backgroundColor = [UIColor clearColor];
}
// 设置布局
-(void) _setupConster{
//    [_choosePicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(10);
//        make.centerX.equalTo(self.view);
//        make.width.height.equalTo(@60);
//    }];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
//        make.left.equalTo(self.view).offset(15);
//        make.right.equalTo(self.view).offset(-15);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(HeightScale(200)));
        make.width.equalTo(@(kScreenWidth-30));
    }];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(_bgView);
    }];
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(_bgView);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(_bgView);
    }];
    [_textTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@(HeightScale(75)));
        make.top.equalTo(self.bgView.mas_bottom).offset(10);
    }];
    [_isSrc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.height.equalTo(@(HeightScale(30)));
        make.top.equalTo(_textTextView.mas_bottom).offset(HeightScale(5));
    }];
    [_isSrcSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.centerY.equalTo(_isSrc.mas_centerY);
    }];
    [_pickBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_isSrc.mas_bottom).offset(5);
//        make.height.equalTo(@(HeightScale(150)));
        make.bottom.equalTo(self.view);
    }];

    
}

-(void)updateConsterWithPic:(UIImage *)image{
    CGFloat Scole = image.size.width / image.size.height ;
    if (Scole >= 1) {
        // 已宽度为基准尺寸
        [_bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(10);
            make.centerX.equalTo(self.view);
            make.width.equalTo(@(kScreenWidth-30));
            make.height.equalTo(@((kScreenWidth-30)/Scole));
        }];
    }else{
        //已高度为基准尺寸
        [_bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(10);
            make.centerX.equalTo(self.view);
            make.height.equalTo(@(HeightScale(350)));
            make.width.equalTo(@(350 * Scole));
        }];
    }
    // 添加图片蒙版透明度
    self.maskView.alpha = 0.32;
}
-(UILabel *)isSrc{
    if (!_isSrc) {
        _isSrc = [UILabel new];
        _isSrc.text = @"是否私密";
        _isSrc.font = [UIFont systemFontOfSize:12];
        _isSrc.textAlignment = NSTextAlignmentLeft;
    }
    return _isSrc;
}
-(UISwitch *)isSrcSwitch{
    if (!_isSrcSwitch) {
        _isSrcSwitch = [[UISwitch alloc]init];
        _isSrcSwitch.tintColor = [UIColor blackColor];
        _isSrcSwitch.onTintColor = [UIColor blackColor];
        _isSrcSwitch.transform = CGAffineTransformMakeScale(HeightScale(0.75) , HeightScale(0.75));

    }
    return _isSrcSwitch;
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView  = [[UIView alloc]init];
    }
    return _bgView;
}
-(UIView *)maskView{
    if (!_maskView) {
        _maskView  = [[UIView alloc]init];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.userInteractionEnabled = NO;
        _maskView.alpha = 0;
    }
    return _maskView;
}

-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"addphoto"]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choosePic)];
        [_bgImageView addGestureRecognizer:tap];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.userInteractionEnabled = NO;
        _contentLabel.numberOfLines = 0;
    }
    return  _contentLabel;
}
-(XJPickButtonView *)pickBtnView{
    if (!_pickBtnView) {
        _pickBtnView  = [[XJPickButtonView alloc]initWithFrame:CGRectZero];
        _pickBtnView.titleArray = @[@"诗词",@"歌词",@"原创",@"摘录",@"其他"];
    }
    return _pickBtnView;
}
-(JKPlaceholderTextView *)textTextView{
    if (!_textTextView) {
        _textTextView = [[JKPlaceholderTextView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, HeightScale(80))];
        _textTextView.placehoderText = @"写下回忆的文字(最多输入99字)";
        _textTextView.font = [UIFont systemFontOfSize:14];
        _textTextView.backgroundColor = RGBACOLOR(230, 230, 230, 1);
        _textTextView.limitTextLength = 99;
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
        _textTextView.textChangeBlock = ^(NSString *text) {
            weak_self.contentLabel.text = text;
            weak_self.maskView.alpha = 0.32;
        };
    }
    return _textTextView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.navigationItem.title = @"发表一则忆言";
    self.view.backgroundColor = RGBACOLOR(210, 210, 210, 1);
    UIBarButtonItem *rightBatItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(postDone)];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont fontWithName:@"FZLBJW--GB1-0" size:16] forKey:NSFontAttributeName];
    [rightBatItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBatItem;
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(BackDone)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    [self _setupUI];
    [self _setupConster];
    // Do any additional setup after loading the view from its nib.
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
    [SVProgressHUD showInfoWithStatus:@"发布到服务器"];
}

/**
 点击选择图片
 */
-(void)choosePic{
    MMPhotoPickerController *mmVC = [[MMPhotoPickerController alloc] init];
    mmVC.delegate = self;
    mmVC.showEmptyAlbum = YES;
    mmVC.maximumNumberOfImage = 9;
    mmVC.cropImageOption = YES;
    mmVC.singleImageOption = YES;
    XJNavigationViewController *mmNav = [[XJNavigationViewController alloc] initWithRootViewController:mmVC];
    [self.navigationController presentViewController:mmNav animated:YES completion:nil];
}
#pragma mark - MMPhotoPickerDelegate
- (void)mmPhotoPickerController:(MMPhotoPickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    NSDictionary *picDic = (NSDictionary *)info[0];
    UIImage *pic = picDic[MMPhotoOriginalImage];
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        [picker dismissViewControllerAnimated:YES completion:nil];
        [weak_self updateConsterWithPic:pic];
        self.bgImageView.image = pic;
    });
}

- (void)mmPhotoPickerControllerDidCancel:(MMPhotoPickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
