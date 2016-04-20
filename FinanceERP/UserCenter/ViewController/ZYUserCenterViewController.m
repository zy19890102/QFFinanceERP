//
//  ZYUserCenterViewController.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/29.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYUserCenterViewController.h"
#import "ZYUserCenterUserInfoCell.h"
#import "ZYUserCenterCell.h"
#import "ZYUserCenterLogoutCell.h"

@interface ZYUserCenterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation ZYUserCenterViewController
{
    ZYUserCenterUserInfoCell *userInfoCell;
}
ZY_VIEW_MODEL_GET(ZYUserCenterViewModel)
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBarHidden = NO;
    
    [self buildUI];
    [self blendViewModel];
}
- (void)buildUI
{
    ZYUserCenterViewModel *viewModel = self.viewModel;
    userInfoCell = [ZYUserCenterUserInfoCell cellWithXibHeight:[ZYUserCenterUserInfoCell defaultHeight] actionBlock:^{
        
    }];
    ZYSection *userInfoSection = [ZYSection sectionWithCells:@[userInfoCell]];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYUserCenterCell class]) bundle:nil] forCellReuseIdentifier:[ZYUserCenterCell defaultIdentifier]];
    
    ZYSection *section = [ZYSection sectionSupportingReuseWithTitle:nil cellHeight:[ZYUserCenterCell defaultHeight] cellCount:^NSInteger(UITableView *tableView, NSInteger section) {
        return 6;
    } cellForRowBlock:^UITableViewCell *(UITableView *tableView, NSInteger row) {
        ZYUserCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZYUserCenterCell defaultIdentifier]];
        cell.imageName = [viewModel imageForIndex:row];
        cell.cellTitle = [viewModel contentForIndex:row];
        return cell;
    } actionBlock:^(UITableView *tableView, NSInteger row) {
        
    }];
    
    ZYUserCenterLogoutCell *logoutCell = [ZYUserCenterLogoutCell cellWithXibHeight:[ZYUserCenterLogoutCell defaultHeight] actionBlock:^{
    }];
    [logoutCell setLineHidden:YES];
    ZYSection *logoutSection = [ZYSection sectionWithCells:@[logoutCell]];
    
    self.sections = @[userInfoSection,section,logoutSection];
}
- (void)blendViewModel
{
    ZYUserCenterViewModel *viewModel = self.viewModel;
    RAC(userInfoCell,user) = RACObserve(viewModel, user);
    [RACObserve(viewModel, dataSource) subscribeNext:^(id x) {
        [self.myTableView reloadData];
    }];
    [viewModel reloadDataSource];
}

- (UITableView*)tableView
{
    return _myTableView;
}
@end
