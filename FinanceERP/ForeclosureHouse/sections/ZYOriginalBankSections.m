//
//  ZYOriginalBankSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYOriginalBankSections.h"

@implementation ZYOriginalBankSections
{
    ZYSelectCell *originalBankNameCell;
    
    ZYInputCell *originalBankLoanMoneyCell;
    ZYInputCell *originalBankDebtCell;
    
    ZYSelectCell *originalBankLoanEndTimeCell;
    
    ZYInputCell *originalBankLinkmanCell;
    ZYInputCell *originalBankTelephoneCell;
    ZYInputCell *originalBankThirdPartyLoanCell;
    ZYInputCell *originalBankThirdPartyCardNumberCell;
    ZYInputCell *originalBankThirdPartyTelephoneCell;
    ZYInputCell *originalBankThirdPartyAddressCell;
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
    originalBankNameCell = [ZYSelectCell cellWithActionBlock:^{
        @strongify(self)
        [self cellSearch:originalBankNameCell withDataSourceSignal:[ZYForeclosureHouseValueModel bankSearchSignal] showKey:@"name"];
    }];
    originalBankNameCell.cellTitle = @"原贷款银行";
    
    originalBankLoanMoneyCell = [ZYInputCell cellWithActionBlock:nil];
    originalBankLoanMoneyCell.cellTitle = @"原贷款金额";
    originalBankLoanMoneyCell.cellPlaceHolder = @"请输入原贷款金额";
    originalBankLoanMoneyCell.onlyFloat = YES;
    originalBankLoanMoneyCell.cellTailText = @"元";
    
    originalBankDebtCell = [ZYInputCell cellWithActionBlock:nil];
    originalBankDebtCell.cellTitle = @"欠款金额";
    originalBankDebtCell.cellPlaceHolder = @"请输入欠款金额";
    originalBankDebtCell.onlyFloat = YES;
    originalBankDebtCell.cellTailText = @"元";
    
    originalBankLoanEndTimeCell = [ZYSelectCell cellWithActionBlock:^{
        @strongify(self)
        [self cellDatePicker:originalBankLoanEndTimeCell];
    }];
    originalBankLoanEndTimeCell.cellTitle = @"贷款结束时间";
    
    originalBankLinkmanCell = [ZYInputCell cellWithActionBlock:nil];
    originalBankLinkmanCell.cellTitle = @"银行联系人";
    originalBankLinkmanCell.cellPlaceHolder = @"请输入银行联系人";
    originalBankLinkmanCell.cellNullable = YES;
    
    originalBankTelephoneCell = [ZYInputCell cellWithActionBlock:nil];
    originalBankTelephoneCell.cellTitle = @"联系电话";
    originalBankTelephoneCell.cellPlaceHolder = @"联系电话";
    originalBankTelephoneCell.onlyInt = YES;
    originalBankTelephoneCell.maxLength = 11;
    originalBankTelephoneCell.cellNullable = YES;
    
    originalBankThirdPartyLoanCell = [ZYInputCell cellWithActionBlock:nil];
    originalBankThirdPartyLoanCell.cellTitle = @"第三借款人";
    originalBankThirdPartyLoanCell.cellPlaceHolder = @"请输入第三借款人";
    originalBankThirdPartyLoanCell.cellNullable = YES;
    
    originalBankThirdPartyCardNumberCell = [ZYInputCell cellWithActionBlock:nil];
    originalBankThirdPartyCardNumberCell.cellTitle = @"身份证号";
    originalBankThirdPartyCardNumberCell.cellPlaceHolder = @"请输入身份证号";
    originalBankThirdPartyCardNumberCell.cellNullable = YES;
    
    originalBankThirdPartyTelephoneCell = [ZYInputCell cellWithActionBlock:nil];
    originalBankThirdPartyTelephoneCell.cellTitle = @"手机号码";
    originalBankThirdPartyTelephoneCell.onlyInt = YES;
    originalBankThirdPartyTelephoneCell.maxLength = 11;
    originalBankThirdPartyTelephoneCell.cellPlaceHolder = @"请输入手机号码";
    originalBankThirdPartyTelephoneCell.cellNullable = YES;
    
    originalBankThirdPartyAddressCell = [ZYInputCell cellWithActionBlock:nil];
    originalBankThirdPartyAddressCell.cellTitle = @"家庭地址";
    originalBankThirdPartyAddressCell.cellPlaceHolder = @"请输入家庭地址";
    originalBankThirdPartyAddressCell.cellNullable = YES;
    
    ZYTableViewCell *footCell = [ZYTableViewCell cellWithStyle:UITableViewCellStyleDefault height:[ZYDoubleButtonCell defaultHeight] actionBlock:nil];
    
    ZYSection *section = [ZYSection sectionWithCells:@[originalBankNameCell,
                                                       originalBankLoanMoneyCell,
                                                       originalBankDebtCell,
                                                       originalBankLoanEndTimeCell,
                                                       originalBankLinkmanCell,
                                                       originalBankTelephoneCell,
                                                       originalBankThirdPartyLoanCell,
                                                       originalBankThirdPartyCardNumberCell,
                                                       originalBankThirdPartyTelephoneCell,
                                                       originalBankThirdPartyAddressCell,
                                                       footCell]];
    self.sections = @[section];
}
@end
