//
//  ZYBusinessProcessingViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/21.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBusinessProcessingViewModel.h"

@implementation ZYBusinessProcessingViewModel

- (void)requestProduceListWith:(ZYUser*)user
{
    ZYProductRequest *request = [ZYProductRequest request];
    request.user_id = user.pid;
    [[[ZYRoute route] productList:request] subscribeNext:^(NSArray *productArr) {
        NSMutableArray *arr = [NSMutableArray arrayWithObject:@"全部产品"];
        [arr addObjectsFromArray:productArr];
        self.businessProcessingProductArr = arr;
    }];
}
- (NSArray*)businessProcessingStateArr
{
    /**
     *  固定文字 不会随意修改
     */
    return @[@"全部状态",@"待发放贷款",@"待赎楼",@"待取旧证",@"待注销抵押",@"待过户",@"待取新证",@"待抵押",@"待回款"];
}
- (RACSignal*)businessProcessingSearchHistorySignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[ZYSearchHistoryModel getUsingLKDBHelper] search:[ZYSearchHistoryModel class] where:nil orderBy:@"searchDate" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
            });
        }];
        return nil;
    }];
    return signal;
}
- (void)setSearchKeywordModel:(ZYSearchHistoryModel *)searchKeywordModel
{
    _searchKeywordModel = searchKeywordModel;
    LKDBHelper *helper = [ZYSearchHistoryModel getUsingLKDBHelper];
    if(![helper getTableCreatedWithClass:[ZYSearchHistoryModel class]])
    {
        NSLog(@"创建表失败");
    }
    [searchKeywordModel saveToDB];
}
- (void)cleanSearchHistory
{
    LKDBHelper *helper = [ZYSearchHistoryModel getUsingLKDBHelper];
    [helper deleteWithClass:[ZYSearchHistoryModel class] where:nil];
}
@end
