//
//  ZYHomePageViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/26.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYHomePageViewModel.h"
#import "ZYWarningEvent.h"

@implementation ZYHomePageViewModel

- (void)requestBannerArr
{
    NSMutableArray *itemArr = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i=0; i<5; i++) {
        ZYBannerItem *item = [[ZYBannerItem alloc] init];
        item.source = ZYBannerSourceOnlyWebSource;
        item.imageUrl = @"http://pic12.nipic.com/20101224/657597_134044727179_2.jpg";
        [itemArr addObject:item];
    }
    self.bannerArr = itemArr;
}
- (void)requestCheckInDays
{
    self.checkInDays = 5;
}
- (void)requestWarningEvent
{
    NSMutableArray *itemArr = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i=0; i<5; i++) {
        ZYWarningEvent *event = [[ZYWarningEvent alloc] init];
        event.eventTitle = @"项目20160215025待过户";
        [itemArr addObject:event];
    }
    self.eventArr = itemArr;
}
- (void)requestHasCheckIn
{
    self.hasCheckIn = NO;
}
@end
