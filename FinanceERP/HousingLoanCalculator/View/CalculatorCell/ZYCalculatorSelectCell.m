//
//  ZYCalculatorSelectCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/30.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCalculatorSelectCell.h"

@interface ZYCalculatorSelectCell ()
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellDetailLabel;


@end

@implementation ZYCalculatorSelectCell


#pragma mark - set method

- (void)setCellTitle:(NSString *)cellTitle
{
    _cellTitle = cellTitle;
    self.cellTitleLabel.text = cellTitle;
}
- (void)setCellDetail:(NSString *)cellDetail
{
    _cellDetail = cellDetail;
    self.cellDetailLabel.text = cellDetail;
}

@end
