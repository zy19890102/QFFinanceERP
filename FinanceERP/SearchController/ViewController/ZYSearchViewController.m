//
//  ZYSearchViewController.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/11.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSearchViewController.h"
#import "ZYTableViewCell.h"
#import "ZYBankModel.h"

@interface ZYSearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic,weak)IBOutlet UITableView *tableView;
@property(nonatomic,weak)IBOutlet UISearchBar *searchBar;


@end

@implementation ZYSearchViewController
{
    CGFloat offY;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
    [self blendViewModel];
}
- (void)buildUI
{
//    [_searchBar becomeFirstResponder];
    [self searchBar:_searchBar textDidChange:_searchBar.text];
}
- (void)blendViewModel
{
    ZYSearchViewModel *viewModel = self.viewModel;
    RACChannelTo(viewModel,searchText) = RACChannelTo(_searchBar,text);
    [RACObserve(viewModel, loading) subscribeNext:^(NSNumber *loading) {
        if(loading.boolValue)
        {
            [self loading];
        }
        else
        {
            [self stop];
        }
        [self.tableView reloadData];
    }];
}
- (IBAction)cancelButtonPressed:(id)sender {
    [_searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(ABS(scrollView.contentOffset.y-self.tableView.contentOffset.y)>60)
    {
        [self.searchBar resignFirstResponder];
    }
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    offY = self.tableView.contentOffset.y;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [[self.viewModel searchWithText:searchText] subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZYTableViewCell defaultIdentifier]];
    if(cell==nil)
    {
        cell = [[ZYTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ZYTableViewCell defaultIdentifier]];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    NSString *initial = self.viewModel.initialArr[indexPath.section];
    NSArray *subArr = self.viewModel.filterDict[initial];
    cell.textLabel.text = [(ZYBankModel*)subArr[indexPath.row] name];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *initial = self.viewModel.initialArr[section];
    NSArray *subArr = self.viewModel.filterDict[initial];
    return subArr.count;
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.viewModel.initialArr[section];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.viewModel.initialArr.count;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.viewModel.initialArr;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
        NSString *initial = self.viewModel.initialArr[indexPath.section];
        NSArray *subArr = self.viewModel.filterDict[initial];
        self.viewModel.searchSelecedObj = subArr[indexPath.row];
    }];
}
@end
