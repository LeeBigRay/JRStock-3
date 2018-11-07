//
//  XJZoneDetailViewController.m
//  XinJia
//
//  Created by 李瑞 on 2017/6/14.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "XJZoneDetailViewController.h"
#import "XJCommitView.h"

@interface XJZoneDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (nonatomic ,strong)UITableView *commitTableView;//评论列表
@property (nonatomic ,strong)XJCommitView *commitView;//


@end

@implementation XJZoneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"圈子详情页";
    self.view.backgroundColor = ViewGrayColor;
    [self.view addSubview:self.commitTableView];
    [self.view addSubview:self.commitView];
    [self.view bringSubviewToFront:self.commitView];
}
-(XJCommitView *)commitView{
    if (!_commitView) {
        _commitView = [[XJCommitView alloc]initWithFrame:CGRectMake(0, kScreen_height - 64 - 40, kScreen_width, 40)];
        @weakify(self);
        _commitView.block = ^(NSString *text){
            NSLog(@"%@",text);
            //传递输入的内容 然后发送到服务器 取消第一响应者
            [weak_self.commitView.textView resignFirstResponder];
            //清空textview的内容
            weak_self.commitView.textView.text = nil;
            //将frame恢复
            weak_self.commitView.frame = CGRectMake(0, kScreen_height - 64 - 40, kScreen_width, 40);
        };
        _commitView.textView.delegate = self;
    }
    return _commitView;
}
-(UITableView *)commitTableView{
    if (!_commitTableView) {
        _commitTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height - 64) style:UITableViewStylePlain];
        _commitTableView.delegate = self;
        _commitTableView.dataSource = self;
        _commitTableView.tableHeaderView = self.headCell;
    }
    return _commitTableView;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    CGRect frame = textView.frame;
    float height = [self heightForTextView:textView WithText:[NSString stringWithFormat:@"%@%@",textView.text,text]];
    frame.size.height = height;
    [UIView animateWithDuration:0.5 animations:^{
        _commitView.frame = CGRectMake(0, kScreen_height - 64 - frame.size.height - 10, kScreen_width, frame.size.height + 10);;
    } completion:nil];

    return YES;
}

- (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText{
    CGSize constraint = CGSizeMake(textView.contentSize.width , CGFLOAT_MAX);
    CGRect size = [strText boundingRectWithSize:constraint
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}
                                        context:nil];
    float textHeight = size.size.height + 10;
    NSLog(@"%f",textHeight);
    return textHeight;
}

-(XJZoneTableViewCell *)headCell{
    if (!_headCell) {
        _headCell = [[XJZoneTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([XJZoneTableViewCell class])];
        [_headCell setLayout:_layout];
//        [_headCell.statusView.toolBarView removeFromSuperview];//去掉工具栏的显示
//        CGRect frame = _headCell.frame;
//        frame.size.height =  frame.size.height - 35;
//        _headCell.frame = frame;
    }
    return _headCell;
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 14;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cella"];
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
