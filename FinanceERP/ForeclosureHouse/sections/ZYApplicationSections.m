//
//  ZYApplicationSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYApplicationSections.h"
#import "ZYForeclosureHouseApplicationContentCell.h"

@implementation ZYApplicationSections
{
    ZYSelectCell *applicationDateCell;
    ZYInputCell *applicationLinkmanCell;
    ZYInputCell *applicationTelephoneCell;
    ZYForeclosureHouseApplicationContentCell *applicationExplainCell;
    ZYForeclosureHouseApplicationContentCell *applicationRemarksCell;
}
- (instancetype)initWithTitle:(NSString *)title
{
    self = [super initWithTitle:title];
    if (self) {
        [self initSection];
    }
    return self;
}
- (void)initSection
{
    applicationDateCell = [ZYSelectCell cellWithActionBlock:^{
    }];
    applicationDateCell.cellTitle = @"申请日期";
    
    applicationLinkmanCell = [ZYInputCell cellWithActionBlock:nil];
    applicationLinkmanCell.cellTitle = @"联系人";
    applicationLinkmanCell.cellPlaceHolder = @"请输入联系人";
    
    applicationTelephoneCell = [ZYInputCell cellWithActionBlock:nil];
    applicationTelephoneCell.cellTitle = @"联系电话";
    applicationTelephoneCell.cellPlaceHolder = @"请输入联系电话";
    
    applicationExplainCell = [ZYForeclosureHouseApplicationContentCell cellWithActionBlock:nil];
    applicationExplainCell.cellTitle = @"特殊说明";
    
    applicationRemarksCell = [ZYForeclosureHouseApplicationContentCell cellWithActionBlock:nil];
    applicationRemarksCell.cellTitle = @"备注";
    
    ZYSection *section = [ZYSection sectionWithCells:@[applicationDateCell,
                                                       applicationLinkmanCell,
                                                       applicationTelephoneCell,
                                                       applicationExplainCell,
                                                       applicationRemarksCell]];
    self.sections = @[section];
}
@end
