//
//  ZYBusinessProcessingViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/21.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"
#import "ZYSearchHistoryModel.h"
#import "ZYBusinessProcessModel.h"
#import "ZYProductModel.h"

@interface ZYBusinessProcessingViewModel : ZYViewModel
#pragma mark - 条件文字
@property(nonatomic,strong)NSArray *businessProcessingProductArr;
- (void)requestProduceListWith:(ZYUser*)user;

@property(nonatomic,strong)NSArray *businessProcessingStateArr;


@property(nonatomic,strong)NSArray *businessProcessingArr;

- (RACSignal*)businessProcessingSearchHistorySignal;
- (void)cleanSearchHistory;

/**
 *  搜索条件
 */
@property(nonatomic,strong)ZYSearchHistoryModel *searchKeywordModel;
@property(nonatomic,strong)ZYProductModel *businessProcessProductType;
@property(nonatomic,strong)NSString *businessProcessState;


@end

