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
    bothSideInfoSellerCardNumberCell.cellTitle = @"身份证号";
    bothSideInfoSellerCardNumberCell.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    bothSideInfoSellerCardNumberCell.cellRegular = [NSString checkCardNum];
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
    footCell.selectionStyle = UITableViewCellSelectionStyleNone;
    footCell.lineHidden = YES;
    
    ZYSection *section = [ZYSection sectionWithCells:@[bothSideInfoSellerNameCell,bothSideInfoSellerCardNumberCell,bothSideInfoSellerTelephoneCell,bothSideInfoSellerAddressCell,footCell]];
    
    self.sections = @[section];
}
- (void)blendModel:(ZYForeclosureHouseValueModel*)model
{
    RACChannelTo(model,bothSideInfoSellerName) = RACChannelTo(bothSideInfoSellerNameCell,cellText);
    RACChannelTo(model,bothSideInfoSellerCardNumber) = RACChannelTo(bothSideInfoSellerCardNumberCell,cellText);
    RACChannelTo(model,bothSideInfoSellerTelephone) = RACChannelTo(bothSideInfoSellerTelephoneCell,cellText);
    RACChannelTo(model,bothSideInfoSellerAddress) = RACChannelTo(bothSideInfoSellerAddressCell,cellText);
}
- (NSString*)error
{
    NSArray *errorArr = @[bothSideInfoSellerNameCell,
                          bothSideInfoSellerCardNumberCell,
                          bothSideInfoSellerTelephoneCell,
                          bothSideInfoSellerAddressCell];
    NSString *result = nil;
    for(id cell in errorArr)
    {
        if([cell respondsToSelector:@selector(checkInput:)])
        {
            NSString *error  = [cell checkInput:YES];
            if(error.length>0&&result==nil)
                result = error;
            else
                continue;
        }
        else
        {
            continue;
        }
    }
    errorArr = nil;
    return result;
}
@end
