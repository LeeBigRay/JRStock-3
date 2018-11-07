//
//  XJMeViewController.m
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "XJMeViewController.h"
#import "JSHeaderView.h"
#import "UserInfoCell.h"

static NSString *const kUserInfoCellId = @"kUserInfoCellId";
@interface XJMeViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) JSHeaderView *headerView;
@property (nonatomic, strong) UITableView *meTableView;
@end

@implementation XJMeViewController
{
    NSArray *iconArr;
    NSArray *titleArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    iconArr = @[@"cart",@"favor",@"folder",@"mail",@"cart",@"favor",@"folder",@"mail"];
    titleArr = @[@"我的订单",@"我的收藏",@"我的发布",@"我的消息",@"我的订单",@"我的收藏",@"我的发布",@"我的消息"];
    self.view.backgroundColor = [UIColor colorWithWhite:255.f alpha:0.3];
    [self.view addSubview:self.meTableView];
    self.headerView = [[JSHeaderView alloc] initWithImage:[UIImage imageNamed:@"header.jpg"]];
    [self.headerView reloadSizeWithScrollView:self.meTableView];
    self.navigationItem.titleView = self.headerView;

    [self.headerView handleClickActionWithBlock:^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您点击了头像" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }];

    UISegmentedControl *control = [[UISegmentedControl alloc]initWithItems:@[@"全部",@"已完成",@"待付款",@"待收货",@"待评价"]];
    control.frame = CGRectMake(100, 300, 300, 100);
//    control.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:control];

}

-(UITableView *)meTableView{
    if (!_meTableView) {
        _meTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height - 64) style:UITableViewStyleGrouped];
        _meTableView.delegate = self;
        _meTableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _meTableView.separatorInsetReference = 1;
        } else {
            // Fallback on earlier versions
        }
        _meTableView.emptyDataSetSource = self;
        _meTableView.emptyDataSetDelegate = self;

    }
    return _meTableView;
}

#pragma mark -
#pragma mark - tableView protocal methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 3;
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 183.f;
    }
    return 44.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 11.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserInfoCellId];
        if (!cell) {
            cell = [[UserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kUserInfoCellId];
        }
        return cell;
    }
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mecell"];
    cell.imageView.image = [UIImage imageNamed:iconArr[indexPath.row]];
    cell.textLabel.text = titleArr[indexPath.row];
    cell.detailTextLabel.text = @"3";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.textLabel.text = [NSString stringWithFormat:@"row %zd", indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}



- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"没有内容"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"没有内容";

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor grayColor]};

    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};

    return [[NSAttributedString alloc] initWithString:@"Continue" attributes:attributes];
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
