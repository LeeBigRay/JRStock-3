//
//  BaseWebViewController.m
//  XinJia
//
//  Created by 李瑞 on 2017/6/13.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)UIButton *editBtn;
@property (nonatomic ,strong)UITableView *tableview;
@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"这是web页面详情";
    self.view.backgroundColor = ViewGrayColor;
//    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height - 64) style:UITableViewStylePlain];
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    [self.view addSubview:self.tableview];
//    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.editBtn.frame = CGRectMake(0, kScreen_height - 49 - 64, 40, 40);
//    [self.editBtn setBackgroundImage:[UIImage imageNamed:@"cycle3"] forState:UIControlStateNormal];
//    [self.editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_editBtn];

//    [self.view bringSubviewToFront:_editBtn];
    // Do any additional setup after loading the view.
}
-(void)edit{
    NSLog(@"傻逼孙玉震");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cacacaca"];
    return cell;
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
