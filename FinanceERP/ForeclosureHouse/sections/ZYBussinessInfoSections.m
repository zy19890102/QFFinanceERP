//
//  ZYBussinessInfoSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBussinessInfoSections.h"

@implementation ZYBussinessInfoSections
{
    ZYSegmentedCell *bussinessInfoComeFromTypeCell;
    ZYSelectCell *bussinessInfoComeFromTypeSubCell;
    
    ZYInputCell *bussinessInfoAreaCell;
    ZYInputCell *bussinessInfoLoanMoneyCell;
    ZYInputCell *bussinessInfoDaysCell;
    ZYSelectCell *bussinessInfoDateCell;
    ZYInputCell *bussinessInfoAccountCell;
    ZYInputCell *bussinessInfoUsernameCell;
    ZYInputCell *bussinessInfoLinkmanCell;
    ZYInputCell *bussinessInfoTelephoneCell;
    ZYSegmentedCell *bussinessInfoOrderTypeCell;
    ZYSegmentedCell *bussinessInfoTransactionTypeCell;
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

    bussinessInfoComeFromTypeCell = [ZYSegmentedCell cellWithActionBlock:nil];
    bussinessInfoComeFromTypeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    bussinessInfoComeFromTypeCell.lineHidden = YES;
    bussinessInfoComeFromTypeCell.cellSegmentedTitles = [ZYForeclosureHouseValueModel foreclosureHouseBussinessInfoComeFromArr];
    bussinessInfoComeFromTypeCell.cellTitle = @"业务来源";
    
    @weakify(self)
    bussinessInfoComeFromTypeSubCell = [ZYSelectCell cellWithActionBlock:^{
        @strongify(self)
        switch (bussinessInfoComeFromTypeCell.cellSegmentedSelecedIndex) {
            case ZYForeclosureHouseBussinessInfoComeFromBank:
            {
                [self cellSearch:bussinessInfoComeFromTypeCell withDataSourceSignal:[ZYForeclosureHouseValueModel bankSearchSignal] showKey:@"name"];///银行数据较多 跳转可搜索页面
            }
                break;
            case ZYForeclosureHouseBussinessInfoComeFromCooperativeOrganization:
            {
                [self cellPicker:bussinessInfoComeFromTypeCell withDataSourceSignal:[ZYForeclosureHouseValueModel cooperativeOrganizationArrSignal] showKey:@"name"];
            }
                break;
            case ZYForeclosureHouseBussinessInfoComeFromIntermediary:
            {
                [self cellPicker:bussinessInfoComeFromTypeCell withDataSourceSignal:[ZYForeclosureHouseValueModel intermediaryArrSignal] showKey:@"name"];
            }
                break;
            default:
                break;
        }
    }];
    
    ZYSection *comeFromTypeSection = [ZYSection sectionWithCells:@[bussinessInfoComeFromTypeCell]];//单独一个section 便于折叠
    ZYSection *comeFromTypeSubSection = [ZYSection sectionWithCells:@[bussinessInfoComeFromTypeSubCell]];
    
    bussinessInfoAreaCell = [ZYInputCell cellWithActionBlock:nil];
    bussinessInfoAreaCell.cellTitle = @"区域";
    bussinessInfoAreaCell.maxLength = 20;
    bussinessInfoAreaCell.cellPlaceHolder = @"请输入区域";
    
    bussinessInfoLoanMoneyCell = [ZYInputCell cellWithActionBlock:nil];
    bussinessInfoLoanMoneyCell.cellTitle = @"贷款金额";
    bussinessInfoLoanMoneyCell.cellPlaceHolder = @"请输入贷款金额";
    bussinessInfoLoanMoneyCell.onlyFloat = YES;
    
    bussinessInfoDaysCell = [ZYInputCell cellWithActionBlock:nil];
    bussinessInfoDaysCell.cellTitle = @"贷款天数";
    bussinessInfoDaysCell.cellPlaceHolder = @"请输入贷款天数";
    bussinessInfoDaysCell.onlyInt = YES;
    
    bussinessInfoDateCell = [ZYSelectCell cellWithActionBlock:^{
        @strongify(self)
        [self cellDatePicker:bussinessInfoDateCell];
    }];
    bussinessInfoDateCell.cellTitle = @"计划放款日期";
    
    bussinessInfoAccountCell = [ZYInputCell cellWithActionBlock:nil];
    bussinessInfoAccountCell.cellTitle = @"回款账号";
    bussinessInfoAccountCell.cellPlaceHolder = @"请输入回款账号";
    bussinessInfoAccountCell.onlyInt = YES;
    bussinessInfoAccountCell.maxLength = 20;
    
    bussinessInfoUsernameCell = [ZYInputCell cellWithActionBlock:nil];
    bussinessInfoUsernameCell.cellTitle = @"回款户名";
    bussinessInfoUsernameCell.cellPlaceHolder = @"请输入回款户名";
    
    bussinessInfoLinkmanCell = [ZYInputCell cellWithActionBlock:nil];
    bussinessInfoLinkmanCell.cellTitle = @"业务联系人";
    bussinessInfoLinkmanCell.cellPlaceHolder = @"请输入业务联系人";
    
    bussinessInfoTelephoneCell = [ZYInputCell cellWithActionBlock:nil];
    bussinessInfoTelephoneCell.cellTitle = @"联系电话";
    bussinessInfoTelephoneCell.cellPlaceHolder = @"请输入联系电话";
    bussinessInfoTelephoneCell.onlyInt = YES;
    bussinessInfoTelephoneCell.maxLength = 11;
    
    bussinessInfoOrderTypeCell = [ZYSegmentedCell cellWithActionBlock:nil];
    bussinessInfoOrderTypeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    bussinessInfoOrderTypeCell.cellSegmentedTitles = [ZYForeclosureHouseValueModel foreclosureHouseBussinessInfoOrderArr];
    bussinessInfoOrderTypeCell.cellTitle = @"内外单";
    
    bussinessInfoTransactionTypeCell = [ZYSegmentedCell cellWithActionBlock:nil];
    bussinessInfoTransactionTypeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    bussinessInfoTransactionTypeCell.cellSegmentedTitles = [ZYForeclosureHouseValueModel foreclosureHouseBussinessInfoTransactionArr];
    bussinessInfoTransactionTypeCell.cellTitle = @"交易类型";
    
    ZYSingleButtonCell *buttonCell = [ZYSingleButtonCell cellWithActionBlock:nil];
    [buttonCell.buttonPressedSignal subscribeNext:^(id x) {
        [self cellNextStep];
    }];
    
    ZYSection *section = [ZYSection sectionWithCells:@[bussinessInfoAreaCell,bussinessInfoLoanMoneyCell,bussinessInfoDaysCell,bussinessInfoDateCell,bussinessInfoAccountCell,bussinessInfoUsernameCell,bussinessInfoLinkmanCell,bussinessInfoTelephoneCell,bussinessInfoOrderTypeCell,bussinessInfoTransactionTypeCell,buttonCell]];
    
    self.sections = @[comeFromTypeSection,comeFromTypeSubSection,section];
}
- (void)blendModel:(ZYForeclosureHouseValueModel*)model
{
    
}
@end
