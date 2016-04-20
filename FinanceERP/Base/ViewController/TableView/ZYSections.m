//
//  ZYSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSections.h"



@implementation ZYSections

- (instancetype)initWithTitle:(NSString*)title
{
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}

- (void)cellSearch:(ZYTableViewCell*)cell withDataSource:(NSArray*)dataSource showKey:(NSString*)showKey{}
- (void)cellSearch:(ZYTableViewCell*)cell withDataSourceSignal:(RACSignal*)dataSourceSignal showKey:(NSString*)showKey{}


- (void)cellPicker:(ZYTableViewCell*)cell withDataSourceSignal:(RACSignal*)dataSourceSignal showKey:(NSString*)showKey{}
- (void)cellPicker:(ZYTableViewCell*)cell withDataSource:(NSArray*)dataSource showKey:(NSString*)showKey{}

- (void)cellDatePicker:(ZYTableViewCell*)cell{}

- (void)cellNextStep{}
- (void)cellLastStep{}

- (void)showSection:(BOOL)show sectionIndex:(NSInteger)index{}
@end
