//
//  ZYHomePageViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/26.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"
#import "ZYBannerView.h"

@interface ZYHomePageViewModel : ZYViewModel
/**
 *  广告数组
 */
@property(nonatomic,strong)NSArray *bannerArr;
/**
 *  请求广告
 */
- (void)requestBannerArr;

/**
 *  签到天数
 */
@property(nonatomic,assign)NSInteger checkInDays;
/**
 *  请求签到天数
 */
- (void)requestCheckInDays;

/**
 *  是否签到
 */
@property(nonatomic,assign)BOOL hasCheckIn;
/**
 *  请求签到天数
 */
- (void)requestHasCheckIn;

/**
 *  签到天数
 */
@property(nonatomic,strong)NSArray *eventArr;
/**
 *  请求注意事项
 */
- (void)requestWarningEvent;

@end
