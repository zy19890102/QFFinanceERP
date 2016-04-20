//
//  ZYUserCenterViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/29.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"
#import "ZYUser.h"


@interface ZYUserCenterViewModel : ZYViewModel

@property(nonatomic,strong)ZYUser *user;

- (NSString*)imageForIndex:(NSInteger)index;
- (NSString*)contentForIndex:(NSInteger)index;

@end
