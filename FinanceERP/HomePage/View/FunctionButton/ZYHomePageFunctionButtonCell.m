//
//  ZYHomePageFunctionButtonCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYHomePageFunctionButtonCell.h"

@implementation ZYHomePageFunctionButtonCell

+ (CGFloat)defaultHeight
{
    return 228.f;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *titleArr = @[@"业务申请",@"业务办理",@"我的业务",@"我的客户",@"申请事项"];
        CGFloat buttonHeight = 84;
        CGFloat buttonWidth = 64;
        CGFloat sideGap = 20;
        NSInteger countY = 3;
        CGFloat gapX = (FUll_SCREEN_WIDTH-2*sideGap-countY*buttonWidth)/(countY-1);
        NSInteger countX = 2;
        CGFloat gapY = ([ZYHomePageFunctionButtonCell defaultHeight]-2*sideGap-countX*buttonHeight)/(countX-1);
        
        [titleArr enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
            NSInteger row = idx/countY;
            NSInteger column = idx%countY;
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(sideGap+column*(buttonWidth+gapX), sideGap+row*(buttonHeight+gapY), buttonWidth, buttonHeight)];
            button.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0);
            button.titleLabel.font = FONT(14);
            button.titleEdgeInsets = UIEdgeInsetsMake(64, -64, 0, 0);
            [button setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
            NSString *imageName = [NSString stringWithFormat:@"ind_ic%lu",idx+1];
            [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [button setTitle:titleArr[idx] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(functionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            button.tag = idx;
        }];
    }
    return self;
}

- (void)functionButtonPressed:(UIButton*)button {
    
}
- (RACSignal*)functionButtonPressSignal
{
    if(_functionButtonPressSignal==nil)
    {
        _functionButtonPressSignal = [[self rac_signalForSelector:@selector(functionButtonPressed:)] map:^id(RACTuple *value) {
            UIButton *button = value.first;
            return @(button.tag);
        }];
    }
    return _functionButtonPressSignal;
}
@end
