//
//  ZYHomePageViewController.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/26.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYHomePageViewController.h"
#import "ZYHomePageScrollAdCell.h"
#import "ZYHomePageViewModel.h"
#import "ZYHomePageCheckInCell.h"
#import "ZYHomePageFunctionButtonCell.h"
#import "ZYHomePageWarningEventTitleCell.h"
#import "ZYHomePageEventView.h"

@interface ZYHomePageViewController ()

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation ZYHomePageViewController
{
    /**
     *  顶部广告cell
     */
    ZYHomePageScrollAdCell *scrollAdCell;
    ZYHomePageCheckInCell *checkInCell;
    ZYHomePageFunctionButtonCell *founctionButtonCell;
    ZYHomePageWarningEventTitleCell *eventTitleCell;
    
    ZYHomePageEventView *eventListView;
}
ZY_VIEW_MODEL_GET(ZYHomePageViewModel)


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tabBarHidden = NO;
    /**
     *  初始化UI
     */
    [self buildUI];
    /**
     *  绑定数据
     */
    [self blendViewModel];
}

- (UITableView*)tableView
{
    return _myTableView;
}
- (void)buildUI
{
#pragma mark- 广告cell
    
    scrollAdCell = [ZYHomePageScrollAdCell cellWithActionBlock:^{
        
    }];
    
    checkInCell = [ZYHomePageCheckInCell cellWithActionBlock:^{
        
    }];
    
    founctionButtonCell = [ZYHomePageFunctionButtonCell cellWithActionBlock:nil];
   
    [founctionButtonCell setLineHidden:YES];
    
    eventTitleCell = [ZYHomePageWarningEventTitleCell cellWithActionBlock:^{
        
    }];
    
    CGSize size = [ZYHomePageEventView defaultSize];
    eventListView = [[ZYHomePageEventView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        
    ZYSection *section = [ZYSection sectionWithCells:@[scrollAdCell,checkInCell,founctionButtonCell,eventTitleCell,eventListView]];
    self.sections = @[section];
    
}


- (void)blendViewModel
{
//    @weakify(self);
    ZYHomePageViewModel *viewModel = self.viewModel;
    RAC(scrollAdCell,bannerArr) = [RACObserve(viewModel, bannerArr) skip:0];
    
    [[scrollAdCell.bannerTapSignal map:^id(NSNumber *index) {
        return viewModel.bannerArr[[index longLongValue]];
    }] subscribeNext:^(ZYBannerItem *item) {
        NSLog(@"%@",item.imageUrl);
    }];
    [viewModel requestBannerArr];
    
#pragma mark - 签到
    
    RAC(checkInCell,checkInDays) = [RACObserve(viewModel, checkInDays) skip:0];
    [viewModel requestCheckInDays];
    
    [[RACObserve(viewModel, hasCheckIn) skip:0] subscribeNext:^(NSNumber *hasCheckIn) {
        if(hasCheckIn.boolValue)///已签到
        {
            checkInCell.hasCheckIn = YES;
        }
        else
        {
            checkInCell.hasCheckIn = NO;
        }
    }];
    [viewModel requestHasCheckIn];
    
    [checkInCell.checkInButtonPressedSignal subscribeNext:^(id x) {
        viewModel.hasCheckIn = YES;
    }];
    
#pragma mark - 功能列表
    [founctionButtonCell.functionButtonPressSignal subscribeNext:^(NSNumber *tag) {
        switch (tag.longLongValue) {
            case 0:
                [self performSegueWithIdentifier:@"applyList" sender:nil];
                break;
            case 1:
                [self performSegueWithIdentifier:@"processing" sender:nil];
                break;
            default:
                break;
        }
    }];
    
    RAC(eventTitleCell,eventCount) = [[RACObserve(viewModel, eventArr) skip:0] map:^id(NSArray *eventArr) {
        return @(eventArr.count);
    }];
    
    RAC(eventListView,eventArr) = [RACObserve(viewModel, eventArr) skip:0];
    
    [viewModel requestWarningEvent];
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
