//
//  ZYApplyInfoSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYApplyInfoSections.h"

@implementation ZYApplyInfoSections
{
    ZYInputCell *applyInfoBorrowerNameCell;
    ZYInputCell *applyInfoBorrowerCardNumberCell;
    ZYInputCell *applyInfoBorrowerTelphoneCell;
    ZYInputCell *applyInfoHousePropertyCardNumberCell;
    ZYInputCell *applyInfoAddressCell;
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
    applyInfoBorrowerNameCell = [ZYInputCell cellWithActionBlock:^{
        @strongify(self)
        [self cellSearch:applyInfoBorrowerNameCell withDataSourceSignal:[ZYForeclosureHouseValueModel borrowersSignal] showKey:@"name"];
    }];
    applyInfoBorrowerNameCell.cellTitle = @"借款人";
    applyInfoBorrowerNameCell.cellPlaceHolder = @"请输入或者选择借款人";
    applyInfoBorrowerNameCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    applyInfoBorrowerNameCell.maxLength = 5;
    
    applyInfoBorrowerCardNumberCell = [ZYInputCell cellWithActionBlock:nil];
    applyInfoBorrowerCardNumberCell.cellTitle = @"身份证号";
    applyInfoBorrowerCardNumberCell.cellPlaceHolder = @"请输入身份证号";
    
    applyInfoBorrowerTelphoneCell = [ZYInputCell cellWithActionBlock:nil];
    applyInfoBorrowerTelphoneCell.cellTitle = @"联系电话";
    applyInfoBorrowerTelphoneCell.cellPlaceHolder = @"请输入联系电话";
    
    applyInfoHousePropertyCardNumberCell = [ZYInputCell cellWithActionBlock:nil];
    applyInfoHousePropertyCardNumberCell.cellTitle = @"房产证号";
    applyInfoHousePropertyCardNumberCell.cellPlaceHolder = @"请输入房产证号";
    
    applyInfoAddressCell = [ZYInputCell cellWithActionBlock:nil];
    applyInfoAddressCell.cellTitle = @"联系地址";
    applyInfoAddressCell.cellPlaceHolder = @"请输入联系地址";
    
    ZYDoubleButtonCell *buttonCell = [ZYDoubleButtonCell cellWithActionBlock:nil];
    [buttonCell.rightButtonPressedSignal subscribeNext:^(id x) {
        [self cellNextStep];
    }];
    [buttonCell.leftButtonPressedSignal subscribeNext:^(id x) {
        [self cellLastStep];
    }];
    
    ZYSection *section = [ZYSection sectionWithCells:@[applyInfoBorrowerNameCell,
                                                       applyInfoBorrowerCardNumberCell,
                                                       applyInfoBorrowerTelphoneCell,
                                                       applyInfoHousePropertyCardNumberCell,
                                                       applyInfoAddressCell,
                                                       buttonCell]];
    self.sections = @[section];
}
@end
