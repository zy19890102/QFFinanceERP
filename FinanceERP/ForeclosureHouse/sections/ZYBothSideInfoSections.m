//
//  ZYBothSideInfoSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBothSideInfoSections.h"

@implementation ZYBothSideInfoSections
{
    ZYInputCell *bothSideInfoSellerNameCell;
    ZYInputCell *bothSideInfoSellerCardNumberCell;
    ZYInputCell *bothSideInfoSellerTelephoneCell;
    ZYInputCell *bothSideInfoSellerAddressCell;
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
    bothSideInfoSellerNameCell = [ZYInputCell cellWithActionBlock:nil];
    bothSideInfoSellerNameCell.cellTitle = @"卖家名称";
    bothSideInfoSellerNameCell.cellPlaceHolder = @"请输入卖家名称";
    
    bothSideInfoSellerCardNumberCell = [ZYInputCell cellWithActionBlock:nil];
    bothSideInfoSellerCardNumberCell.cellTitle = @"身份证";
    bothSideInfoSellerCardNumberCell.cellPlaceHolder = @"请输入身份证号";
    
    bothSideInfoSellerTelephoneCell = [ZYInputCell cellWithActionBlock:nil];
    bothSideInfoSellerTelephoneCell.cellTitle = @"联系电话";
    bothSideInfoSellerTelephoneCell.cellPlaceHolder = @"请输入联系电话";
    bothSideInfoSellerTelephoneCell.onlyInt = YES;
    bothSideInfoSellerTelephoneCell.maxLength = 11;
    
    bothSideInfoSellerAddressCell = [ZYInputCell cellWithActionBlock:nil];
    bothSideInfoSellerAddressCell.cellTitle = @"家庭住址";
    bothSideInfoSellerAddressCell.cellPlaceHolder = @"请输入家庭住址";
    
    ZYTableViewCell *footCell = [ZYTableViewCell cellWithStyle:UITableViewCellStyleDefault height:[ZYDoubleButtonCell defaultHeight] actionBlock:nil];
    
    ZYSection *section = [ZYSection sectionWithCells:@[bothSideInfoSellerNameCell,bothSideInfoSellerCardNumberCell,bothSideInfoSellerTelephoneCell,bothSideInfoSellerAddressCell,footCell]];
    
    self.sections = @[section];
}
@end
