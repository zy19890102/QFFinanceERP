//
//  ZYCurrentBankSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCurrentBankSections.h"

@implementation ZYCurrentBankSections
{
    ZYSelectCell *newBankCell;
    ZYInputCell *newBankLoanMoneyCell;
    ZYInputCell *newBankLinkmanCell;
    ZYInputCell *newBankTelephoneCell;
    ZYSegmentedCell *newBankLoanTypeCell;
    
    ZYInputCell *newBankForeclosureAccountCell;
    ZYSelectCell *newBankPublicFundBankCell;
    ZYInputCell *newBankPublicFundMoneyCell;
    
    ZYInputCell *newBankSuperviseOrganizationCell;
    ZYInputCell *newBankSuperviseMoneyCell;
    ZYInputCell *newBankSuperviseAccountCell;
    
    ZYSelectCell *newBankJusticeDateCell;
    ZYSelectCell *newBankContractDateCell;
    
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
    @weakify(self)
    newBankCell = [ZYSelectCell cellWithActionBlock:^{
        @strongify(self)
        [self cellSearch:newBankCell withDataSourceSignal:[ZYForeclosureHouseValueModel bankSearchSignal] showKey:@"name"];
    }];
    newBankCell.cellTitle = @"新贷款银行";
    
    newBankLoanMoneyCell = [ZYInputCell cellWithActionBlock:nil];
    newBankLoanMoneyCell.cellTitle = @"新贷款金额";
    newBankLoanMoneyCell.onlyInt = YES;
    newBankLoanMoneyCell.maxLength = 20;
    newBankLoanMoneyCell.cellTailText = @"元";
    newBankLoanMoneyCell.cellPlaceHolder = @"请输入新贷款金额";
    
    newBankLinkmanCell = [ZYInputCell cellWithActionBlock:nil];
    newBankLinkmanCell.cellTitle = @"银行联系人";
    newBankLinkmanCell.cellNullable = YES;
    newBankLinkmanCell.cellPlaceHolder = @"请输入银行联系人";
    
    newBankTelephoneCell = [ZYInputCell cellWithActionBlock:nil];
    newBankTelephoneCell.cellTitle = @"联系电话";
    newBankTelephoneCell.maxLength = 11;
    newBankTelephoneCell.cellNullable = YES;
    newBankTelephoneCell.onlyInt = YES;
    newBankTelephoneCell.cellPlaceHolder = @"请输入联系电话";
    
    newBankLoanTypeCell = [ZYSegmentedCell cellWithActionBlock:nil];
    newBankLoanTypeCell.cellTitle = @"贷款方式";
    newBankLoanTypeCell.cellSegmentedTitles = @[@"商业贷款",@"公积金贷款",@"混合贷款",@"一次付清"];
    
    newBankForeclosureAccountCell = [ZYInputCell cellWithActionBlock:nil];
    newBankForeclosureAccountCell.cellTitle = @"赎楼账号";
    newBankForeclosureAccountCell.cellPlaceHolder = @"请输入赎楼账号";
    newBankForeclosureAccountCell.onlyInt = YES;
    
    newBankPublicFundBankCell = [ZYSelectCell cellWithActionBlock:^{
        @strongify(self)
        [self cellSearch:newBankPublicFundBankCell withDataSourceSignal:[ZYForeclosureHouseValueModel bankSearchSignal] showKey:@"name"];
    }];
    newBankPublicFundBankCell.cellTitle = @"公积金银行";
    newBankPublicFundBankCell.cellNullable = YES;
    
    newBankPublicFundMoneyCell = [ZYInputCell cellWithActionBlock:nil];
    newBankPublicFundMoneyCell.cellTitle = @"公积金贷款额";
    newBankPublicFundMoneyCell.onlyFloat = YES;
    newBankPublicFundMoneyCell.maxLength = 20;
    newBankPublicFundMoneyCell.cellNullable = YES;
    newBankPublicFundMoneyCell.cellPlaceHolder = @"请输入公积金贷款金额";
    
    newBankSuperviseOrganizationCell = [ZYInputCell cellWithActionBlock:nil];
    newBankSuperviseOrganizationCell.cellTitle = @"资金监管单位";
    newBankSuperviseOrganizationCell.cellPlaceHolder = @"请输入资金监管单位";
    
    newBankSuperviseMoneyCell = [ZYInputCell cellWithActionBlock:nil];
    newBankSuperviseMoneyCell.cellTitle = @"资金监管金额";
    newBankSuperviseMoneyCell.cellPlaceHolder = @"请输入资金监管金额";
    
    newBankSuperviseAccountCell = [ZYInputCell cellWithActionBlock:nil];
    newBankSuperviseAccountCell.cellTitle = @"资金监管帐号";
    newBankSuperviseAccountCell.cellPlaceHolder = @"请输入资金监管帐号";
    
    newBankJusticeDateCell = [ZYSelectCell cellWithActionBlock:^{
        @strongify(self)
        [self cellDatePicker:newBankJusticeDateCell];
    }];
    newBankJusticeDateCell.cellTitle = @"委托公证日期";
    
    newBankContractDateCell = [ZYSelectCell cellWithActionBlock:^{
        @strongify(self)
        [self cellDatePicker:newBankContractDateCell];
    }];
    newBankContractDateCell.cellTitle = @"签署合同日期";
    
    
    ZYTableViewCell *footCell = [ZYTableViewCell cellWithStyle:UITableViewCellStyleDefault height:[ZYDoubleButtonCell defaultHeight] actionBlock:nil];
    
    ZYSection *section = [ZYSection sectionWithCells:@[newBankCell,
                                                       newBankLoanMoneyCell,
                                                       newBankLinkmanCell,
                                                       newBankTelephoneCell,
                                                       newBankLoanTypeCell,
                                                       newBankForeclosureAccountCell,
                                                       newBankPublicFundBankCell,
                                                       newBankPublicFundMoneyCell,
                                                       newBankSuperviseOrganizationCell,
                                                       newBankSuperviseMoneyCell,
                                                       newBankSuperviseAccountCell,
                                                       newBankJusticeDateCell,
                                                       newBankContractDateCell,footCell]];
    self.sections = @[section];
}
@end
