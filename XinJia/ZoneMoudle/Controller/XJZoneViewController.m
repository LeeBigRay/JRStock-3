//
//  XJZoneViewController.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "XJZoneViewController.h"
#import "XJZoneTableViewCell.h"
#import "XJZoneModel.h"
#import "WBStatusHelper.h"
#import "WBStatusLayout.h"
#import "YYPhotoGroupView.h"
#import "YYSimpleWebViewController.h"
#import "XJZoneDetailViewController.h"

//菜单弹出框
#import "ListView.h"
#import "ListItem.h"





@interface XJZoneViewController ()<UITableViewDelegate,UITableViewDataSource,WBStatusCellDelegate>
@property (nonatomic ,strong)UITableView *zoneTableView;
@property (nonatomic, strong) NSMutableArray *layouts;

@property (nonatomic, strong) NSMutableArray *statuss;
@end

@implementation XJZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.zoneTableView];
    self.navigationItem.title = @"拾一道光";
    _layouts = [NSMutableArray array];
    _statuss = [NSMutableArray array];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i <= 7; i++) {
            NSData *data = [NSData dataNamed:[NSString stringWithFormat:@"weibo_0.json"]];
            WBTimelineItem *item = [WBTimelineItem modelWithJSON:data];
            for (WBStatus *status in item.statuses) {
                [_statuss addObject:status];
                WBStatusLayout *layout = [[WBStatusLayout alloc] initWithStatus:status style:WBLayoutStyleTimeline];
                //                [layout layout];
                [_layouts addObject:layout];
            }
        }

        // 复制一下，让列表长一些，不至于滑两下就到底了
        [_layouts addObjectsFromArray:_layouts];


       dispatch_async(dispatch_get_main_queue(), ^{
            [_zoneTableView reloadData];
       });
    });
}
-(UITableView *)zoneTableView{
    if (!_zoneTableView) {
        _zoneTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _zoneTableView.delegate  = self;
        _zoneTableView.dataSource = self;
        _zoneTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_zoneTableView registerClass:[XJZoneTableViewCell class] forCellReuseIdentifier:NSStringFromClass([XJZoneTableViewCell class])];

    }
    return _zoneTableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _layouts.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XJZoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XJZoneTableViewCell class])];
    if (!cell) {
        cell = [[XJZoneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([XJZoneTableViewCell class])];

    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell  setLayout:_layouts[indexPath.row]];
//    WBStatus *status = _statuss[indexPath.row];
//    cell.textLabel.text = status.text;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ((WBStatusLayout *)_layouts[indexPath.row]).height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了整个cell//准备跳转到详情页");
    XJZoneTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    XJZoneDetailViewController *detailVc = [[XJZoneDetailViewController alloc]init];
    detailVc.hidesBottomBarWhenPushed = YES;
    detailVc.layout = cell.statusView.layout;
    [self.navigationController pushViewController:detailVc animated:YES];

}

#pragma mark - WBStatusCellDelegate
// 此处应该用 Router 之类的东西。。。这里只是个Demo，直接全跳网页吧～

/// 点击了 Cell
- (void)cellDidClick:(XJZoneTableViewCell *)cell {
    NSLog(@"点击了整个cell");
}

-(void)cellDidClickReport:(XJZoneTableViewCell *)cell{
    NSLog(@"点击了举报按钮");
}

/// 点击了 Cell 菜单
- (void)cellDidClickMenu:(XJZoneTableViewCell *)cell {
    NSLog(@"我点击了菜单用来举报关注的操作");
    NSArray *titles = @[@"收藏",@"添加关注",@"举报"];
    NSMutableArray *items = [NSMutableArray array];
    for(int i = 0; i < titles.count; i ++){
        NSString *iconName = [NSString stringWithFormat:@"listView.bundle/right_menu%d",i];
        ListItem *item = [ListItem itemWithIcon:iconName title:titles[i]];
        [items addObject:item];
    }
    ListView *list = [ListView listViewWithReferFrame:CGRectMake(kScreen_width - 40, 30, 30, 30) items:items select:^(NSInteger selectIndex) {
        NSLog(@"%@",titles[selectIndex]);
    }];
    [cell addSubview:list];

}


/// 点击了赞
- (void)cellDidClickLike:(XJZoneTableViewCell *)cell {
    WBStatus *status = cell.statusView.layout.status;
    [cell.statusView.toolBarView setLiked:!status.attitudesStatus withAnimation:YES];
}

/// 点击了评论
- (void)cellDidClickComment:(XJZoneTableViewCell *)cell {
    NSLog(@"点击了评论按钮");
//    WBStatusComposeViewController *vc = [WBStatusComposeViewController new];
//    vc.type = WBStatusComposeViewTypeComment;
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    @weakify(nav);
//    vc.dismiss = ^{
//        @strongify(nav);
//        [nav dismissViewControllerAnimated:YES completion:NULL];
//    };
//    [self presentViewController:nav animated:YES completion:NULL];
}

//点击了分享按钮
-(void)cellDidClickShare:(XJZoneTableViewCell *)cell{
    NSLog(@"点击了分享按钮");
}

//点击了用户头像
-(void)cellDidClickUser:(XJZoneTableViewCell *)cell{
    NSLog(@"点击了用户头像");
    /// 点击了用户
//    - (void)cell:(WBStatusCell *)cell didClickUser:(WBUser *)user {
//        if (user.userID == 0) return;
//        NSString *url = [NSString stringWithFormat:@"http://m.weibo.cn/u/%lld",user.userID];
//        YYSimpleWebViewController *vc = [[YYSimpleWebViewController alloc] initWithURL:[NSURL URLWithString:url]];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

-(void)cell:(XJZoneTableViewCell *)cell didClickUser:(WBUser *)user{
    NSLog(@"点击了用户头像");
}


//点击了图片
- (void)cell:(XJZoneTableViewCell *)cell didClickImageAtIndex:(NSUInteger)index{
    UIView *fromView = nil;
    NSMutableArray *items = [NSMutableArray new];
    WBStatus *status = cell.statusView.layout.status;
    NSArray<WBPicture *> *pics = status.pics;
//
//    for (NSUInteger i = 0, max = pics.count; i < max; i++) {
//        UIView *imgView = cell.statusView.picViews[i];
//        WBPicture *pic = pics[i];
//        WBPictureMetadata *meta = pic.largest.badgeType == WBPictureBadgeTypeGIF ? pic.largest : pic.large;
//        YYPhotoGroupItem *item = [YYPhotoGroupItem new];
//        item.thumbView = imgView;
//        item.largeImageURL = meta.url;
//        item.largeImageSize = CGSizeMake(meta.width, meta.height);
//        [items addObject:item];
//        if (i == index) {
//            fromView = imgView;
//        }
//    }

    //这里直接在window上显示 避免出现tabbar还存在的情况

    YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:items];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [v presentFromImageView:fromView toContainer:window animated:YES completion:nil];
}













@end
