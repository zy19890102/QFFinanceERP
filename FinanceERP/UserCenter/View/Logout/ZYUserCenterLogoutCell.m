//
//  ZYUserCenterLogoutCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/29.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYUserCenterLogoutCell.h"

@interface ZYUserCenterLogoutCell ()
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end

@implementation ZYUserCenterLogoutCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_logoutButton roundRectWith:_logoutButton.height*ROUND_RECT_HEIGHT_RATE];
}
+ (CGFloat)defaultHeight
{
    return 120.f;
}

@end
