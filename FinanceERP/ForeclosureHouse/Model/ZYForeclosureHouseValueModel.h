//
//  ZYForeclosureHouseValueModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYBankModel.h"
#import "ZYCooperativeOrganizationModel.h"
#import "ZYIntermediaryModel.h"
#import "ZYBorrowerModel.h"

typedef enum : NSUInteger {
    ZYForeclosureHouseBussinessInfoComeFromBank = 0,//银行
    ZYForeclosureHouseBussinessInfoComeFromIntermediary,///中介
    ZYForeclosureHouseBussinessInfoComeFromFriend,///朋友
    ZYForeclosureHouseBussinessInfoComeFromCooperativeOrganization,
} ZYForeclosureHouseBussinessInfoComeFromType;///业务来源信息

typedef enum : NSUInteger {
    ZYForeclosureHouseBussinessInfoOrderInside = 0,//内单
    ZYForeclosureHouseBussinessInfoOrderOutside,///外单
} ZYForeclosureHouseBussinessInfoOrderType;

typedef enum : NSUInteger {
    ZYForeclosureHouseBussinessInfoTransaction = 0,//交易
    ZYForeclosureHouseBussinessInfoIsNotTransaction,///非交易
} ZYForeclosureHouseBussinessInfoTransactionType;

@interface ZYForeclosureHouseValueModel : NSObject

+ (NSArray*)foreclosureHouseBussinessInfoComeFromArr;
+ (NSArray*)foreclosureHouseBussinessInfoOrderArr;
+ (NSArray*)foreclosureHouseBussinessInfoTransactionArr;
+ (NSArray*)costInfoChargeTypeArr;

+ (RACSignal*)bankSearchSignal;
+ (RACSignal*)cooperativeOrganizationArrSignal;
+ (RACSignal*)intermediaryArrSignal;
+ (RACSignal*)borrowersSignal;

@end
