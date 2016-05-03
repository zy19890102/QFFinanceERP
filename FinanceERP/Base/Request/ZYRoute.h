//
//  ZYRoute.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/25.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
#import "ZYLoginRequest.h"
#import "ZYUser.h"
#import "ZYBannerRequest.h"
#import "ZYBannerView.h"
#import "ZYCheckInDaysRequest.h"
#import "ZYCheckInRequest.h"
#import "ZYCheckInModel.h"
#import "ZYWarningEventRquest.h"
#import "ZYWarningEvent.h"
#import "ZYProductRequest.h"
#import "ZYProductModel.h"

@interface ZYRoute : NSObject

+ (instancetype)route;
//登陆
- (RACSignal*)loginWith:(ZYLoginRequest*)myRequest;
- (RACSignal*)bannersWith:(ZYBannerRequest*)myRequest;

- (RACSignal*)checkInWith:(ZYCheckInRequest*)myRequest;
- (RACSignal*)checkInDaysWith:(ZYCheckInDaysRequest*)myRequest;

- (RACSignal*)warningEventList:(ZYWarningEventRquest*)myRequest;

- (RACSignal*)productList:(ZYProductRequest*)myRequest;
@end
