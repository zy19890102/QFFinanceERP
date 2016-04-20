//
//  ZYSections.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYTableViewCell.h"
#import "ZYSection.h"
#import "ZYInputCell.h"
#import "ZYSelectCell.h"
#import "ZYSegmentedCell.h"
#import "ZYSingleButtonCell.h"
#import "ZYDoubleButtonCell.h"

@interface ZYSections : NSObject

@property(nonatomic,strong)NSArray *sections;
@property(nonatomic,strong)NSString *title;

- (void)cellSearch:(ZYTableViewCell*)cell withDataSource:(NSArray*)dataSource showKey:(NSString*)showKey;
- (void)cellSearch:(ZYTableViewCell*)cell withDataSourceSignal:(RACSignal*)dataSourceSignal showKey:(NSString*)showKey;


- (void)cellPicker:(ZYTableViewCell*)cell withDataSourceSignal:(RACSignal*)dataSourceSignal showKey:(NSString*)showKey;
- (void)cellPicker:(ZYTableViewCell*)cell withDataSource:(NSArray*)dataSource showKey:(NSString*)showKey;

- (void)cellDatePicker:(ZYTableViewCell*)cell;

- (void)cellNextStep;
- (void)cellLastStep;

- (void)showSection:(BOOL)show sectionIndex:(NSInteger)index;

- (instancetype)initWithTitle:(NSString*)title;
@end
