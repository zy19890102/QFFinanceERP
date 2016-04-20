//
//  ZYCostInfoSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCostInfoSections.h"

@implementation ZYCostInfoSections
{
    ZYSegmentedCell *costInfoChargeTypeCell;
    ZYInputCell *costInfoInterestIncomeCell;//利息收入
    ZYInputCell *costInfoPoundageCell;//手续费
    ZYInputCell *costInfoWaitForCostingCell;//待收费用
    ZYInputCell *costInfoSubsidyCell;//补贴
    ZYInputCell *costInfoCommissionCell;//应付佣金
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
    costInfoChargeTypeCell = [ZYSegmentedCell cellWithActionBlock:nil];
    costInfoChargeTypeCell.cellSegmentedTitles = [ZYForeclosureHouseValueModel costInfoChargeTypeArr];
    costInfoChargeTypeCell.cellTitle = @"收入方式";
    
    costInfoInterestIncomeCell = [ZYInputCell cellWithActionBlock:nil];
    costInfoInterestIncomeCell.cellTitle = @"利息收入";
    costInfoInterestIncomeCell.cellPlaceHolder = @"请输入利息收入";
    costInfoInterestIncomeCell.onlyFloat = YES;
    costInfoInterestIncomeCell.cellTailText = @"元";
    
    costInfoPoundageCell = [ZYInputCell cellWithActionBlock:nil];
    costInfoPoundageCell.cellTitle = @"手续费";
    costInfoPoundageCell.cellPlaceHolder = @"请输入手续费";
    costInfoPoundageCell.onlyFloat = YES;
    costInfoPoundageCell.cellTailText = @"元";
    
    costInfoWaitForCostingCell = [ZYInputCell cellWithActionBlock:nil];
    costInfoWaitForCostingCell.cellTitle = @"待收费用";
    costInfoWaitForCostingCell.cellPlaceHolder = @"请输入待收费用";
    costInfoWaitForCostingCell.onlyFloat = YES;
    costInfoWaitForCostingCell.cellTailText = @"元";
    
    costInfoSubsidyCell = [ZYInputCell cellWithActionBlock:nil];
    costInfoSubsidyCell.cellTitle = @"补贴";
    costInfoSubsidyCell.cellPlaceHolder = @"请输入补贴";
    costInfoSubsidyCell.onlyFloat = YES;
    costInfoSubsidyCell.cellTailText = @"元";
    
    costInfoCommissionCell = [ZYInputCell cellWithActionBlock:nil];
    costInfoCommissionCell.cellTitle = @"应付佣金";
    costInfoCommissionCell.cellPlaceHolder = @"请输入应付佣金";
    costInfoCommissionCell.onlyFloat = YES;
    costInfoCommissionCell.cellTailText = @"元";
    
    ZYSection *section = [ZYSection sectionWithCells:@[costInfoChargeTypeCell,
                                                       costInfoInterestIncomeCell,
                                                       costInfoPoundageCell,
                                                       costInfoWaitForCostingCell,
                                                       costInfoSubsidyCell,
                                                       costInfoCommissionCell]];
    self.sections = @[section];
}
@end
