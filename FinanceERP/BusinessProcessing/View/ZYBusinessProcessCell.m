//
//  ZYBusinessProcessCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/25.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBusinessProcessCell.h"

@interface ZYBusinessProcessCell()

@property(nonatomic,strong)UILabel *cellTitleLabel;
@property(nonatomic,strong)UILabel *cellSubTitleLabel;
@property(nonatomic,strong)UILabel *cellPriceLabel;
@property(nonatomic,strong)UILabel *cellDateLabel;
@end

@implementation ZYBusinessProcessCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat labelWidth = 200.f;
        CGFloat labelHeight = 20.f;
        _cellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, GAP, labelWidth, labelHeight)];
        _cellTitleLabel.textColor = BLUE;
        [self addSubview:_cellTitleLabel];
        
        _cellSubTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, GAP+_cellTitleLabel.Y+_cellTitleLabel.height, labelWidth, labelHeight)];
        _cellSubTitleLabel.textColor = TITLE_COLOR;
        [self addSubview:_cellSubTitleLabel];
        
        _cellPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, GAP+_cellSubTitleLabel.Y+_cellSubTitleLabel.height, labelWidth, labelHeight)];
        _cellPriceLabel.textColor = TITLE_COLOR;
        [self addSubview:_cellPriceLabel];
        
        _cellDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, GAP+_cellPriceLabel.Y+_cellPriceLabel.height, labelWidth, labelHeight)];
        _cellDateLabel.textColor = TITLE_COLOR;
        [self addSubview:_cellDateLabel];
        
        labelHeight = 12.f;
        _cellDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, GAP+_cellDateLabel.Y+_cellDateLabel.height, labelWidth, labelHeight)];
        _cellDateLabel.textColor = TEXT_COLOR;
        [self addSubview:_cellDateLabel];
    }
    return self;
}
+ (CGFloat)defaultHeight{
    return 108.f;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
