//
//  ZYForeclosureHouseValueModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYForeclosureHouseValueModel.h"

@implementation ZYForeclosureHouseValueModel

+ (NSArray*)foreclosureHouseBussinessInfoComeFromArr
{
    return @[@"银行",@"中介",@"朋友",@"合作机构"];
}
+ (NSArray*)foreclosureHouseBussinessInfoOrderArr
{
    return  @[@"内单",@"外单"];
}
+ (NSArray*)foreclosureHouseBussinessInfoTransactionArr
{
    return @[@"交易",@"非交易"];
}
+ (NSArray*)costInfoChargeTypeArr
{
    return @[@"贷前收费",@"贷后收费"];
}
+ (RACSignal*)bankSearchSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYBankModel getUsingLKDBHelper] search:[ZYBankModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
            });
        }];
        
        return nil;
    }];
    return signal;
}
+ (RACSignal*)cooperativeOrganizationArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYCooperativeOrganizationModel getUsingLKDBHelper] search:[ZYCooperativeOrganizationModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
            });
        }];
        
        return nil;
    }];
    return signal;
}
+ (RACSignal*)intermediaryArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYIntermediaryModel getUsingLKDBHelper] search:[ZYIntermediaryModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
            });
        }];
        
        return nil;
    }];
    return signal;
}
+ (RACSignal*)borrowersSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:2];
        ZYBorrowerModel *borrower = [[ZYBorrowerModel alloc] init];
        borrower.name = @"张三";
        borrower.telephone = @"13145678945";
        borrower.cardNumber = @"412554455245462571";
        [arr addObject:borrower];
        
        borrower = [[ZYBorrowerModel alloc] init];
        borrower.name = @"李四";
        borrower.telephone = @"15845216587";
        borrower.cardNumber = @"854654424215687584";
        [arr addObject:borrower];
        
        [subscriber sendNext:arr];
        return nil;
    }];
    return signal;
}
@end
