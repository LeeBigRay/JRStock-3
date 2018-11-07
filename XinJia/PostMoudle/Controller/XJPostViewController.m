//
//  XJPostViewController.m
//  XinJia
//
//  Created by 李瑞 on 2017/6/2.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import "XJPostViewController.h"
#import "XJPostViewController_present.h"
#import "XJNavigationViewController.h"
#import "XJPost_PresentViewController.h"

@interface XJPostViewController ()

@end

@implementation XJPostViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    XJPost_PresentViewController *presentVc = [[XJPost_PresentViewController alloc]init];
    XJNavigationViewController *nav = [[XJNavigationViewController alloc]initWithRootViewController:presentVc];
    [self presentViewController:nav animated:YES completion:^{
        nil;
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(240, 240, 240, 1);
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
