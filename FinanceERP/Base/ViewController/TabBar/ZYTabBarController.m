//
//  ZYTabBarController.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTabBarController.h"
#import "ZYTabBar.h"

@interface ZYTabBarController ()

/**
 *  自定义tabBar
 */
@property(nonatomic,strong)ZYTabBar *tabBarView;

@end

@implementation ZYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tabBarView = [[ZYTabBar alloc] initWithFrame:self.tabBar.bounds];
    [self.tabBar addSubview:_tabBarView];
    
    __weak typeof(self) weakSelf = self;
    [_tabBarView.tabBarSignal subscribeNext:^(NSNumber *index) {
        [weakSelf setSelectedIndex:[index longLongValue]];
    }];
}
- (RACSignal*)tabBarSignal
{
    return _tabBarView.tabBarSignal;
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
