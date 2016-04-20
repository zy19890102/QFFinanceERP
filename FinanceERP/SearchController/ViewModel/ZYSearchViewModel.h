//
//  ZYSearchViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/12.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYBankModel.h"

@interface ZYSearchViewModel : NSObject
/**
 *  本地查询用此方法
 */
+ (ZYSearchViewModel*)viewModelWithSignal:(RACSignal*)searchSignal;
@property(nonatomic,strong)NSString *showPropertyKey;///要显示属性名称key值必填 显示属性为string


@property(nonatomic,strong)RACSignal *searchSignal;

@property(nonatomic,strong)id searchSelecedObj;///搜索页选择的数据

@property(nonatomic,strong)NSMutableDictionary *filterDict;///带分组
@property(nonatomic,strong)NSArray *initialArr;

@property(nonatomic,assign)BOOL loading;
/**
 *  本地搜索
 */
- (RACSignal*)searchWithText:(NSString*)searchText;
@property(nonatomic,strong)NSString *searchText;
@end
