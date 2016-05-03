//
//  ZYTableViewController.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/1.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewController.h"
#import "ZYSearchViewController.h"

@interface ZYTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ZYTableViewController

#pragma mark - Setting sections
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _autoReload = YES;///默认自动刷新
    [[RACObserve(self, sections) filter:^BOOL(NSArray *value) {
        return _autoReload;
    }] subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
}
- (void)setFrame:(CGRect)frame
{
    self.view.frame = frame;
    self.tableView.width = frame.size.width;
    self.tableView.height = frame.size.height;
}
- (void)reloadData
{
    [self.tableView reloadData];
}
#pragma mark - 折叠

- (void)showSection:(BOOL)show sectionIndex:(NSInteger)sectionIndex
{
    if(sectionIndex>=self.sections.count)
        return;
    ZYSection *section = self.sections[sectionIndex];
    
    if(section.hasFold&&show)///展开
    {
        NSMutableArray *cellIndexPathArr = [NSMutableArray arrayWithCapacity:section.cells.count];
        for(int i=0;i<section.cells.count;i++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:sectionIndex];
            [cellIndexPathArr addObject:indexPath];
        }
        [(ZYSection*)self.sections[sectionIndex] setHasFold:NO];
        [self.tableView insertRowsAtIndexPaths:cellIndexPathArr withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else if(!section.hasFold&&!show)///折叠
    {
        
        NSMutableArray *cellIndexPathArr = [NSMutableArray arrayWithCapacity:section.cells.count];
        for(int i=0;i<section.cells.count;i++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:sectionIndex];
            [cellIndexPathArr addObject:indexPath];
        }
        [(ZYSection*)self.sections[sectionIndex] setHasFold:YES];
        [self.tableView deleteRowsAtIndexPaths:cellIndexPathArr withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZYSection *organicSection = self.sections[section];
    return organicSection.headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    ZYSection *organicSection = self.sections[section];
    return organicSection.headerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    ZYSection *organicSection = self.sections[section];
    return organicSection.headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    ZYSection *organicSection = self.sections[section];
    return organicSection.footerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    ZYSection *organicSection = self.sections[section];
    return organicSection.footerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    ZYSection *organicSection = self.sections[section];
    return organicSection.footerHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZYSection *organicSection = self.sections[section];
    
    if (organicSection.reuseEnabled) {
        return organicSection.reusedCellCount(tableView,section);
    }
    if (organicSection.hasFold)
    {
        return 0;
    }
    return organicSection.cells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYSection *organicSection = self.sections[indexPath.section];
    
    if (organicSection.reuseEnabled) {
        return organicSection.reusedCellHeight;
    }
    
    else {
        ZYTableViewCell *cell = organicSection.cells[indexPath.row];
        return cell.height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYSection *organicSection = self.sections[indexPath.section];
    
    if (organicSection.reuseEnabled) {
        return organicSection.cellForRowBlock(tableView, indexPath.row);
    }
    
    else {
        return organicSection.cells[indexPath.row];
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZYSection *organicSection = self.sections[indexPath.section];
    
    if (organicSection.reuseEnabled) {
        if (organicSection.reusedCellActionBlock) {
            organicSection.reusedCellActionBlock(tableView,indexPath.row);
        }
    }
    
    else {
        ZYTableViewCell *cell = organicSection.cells[indexPath.row];
        
        if (cell.actionBlock) {
            cell.actionBlock();
        }
    }
}

//- (UITableView*)tableView
//{
//    NSLog(@"警告，需要重写该方法，传入tableView");
//    return nil;
//}

@end
