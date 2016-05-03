//
//  ZYHomePageViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/26.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYHomePageViewModel.h"
#import "ZYWarningEvent.h"
#import "ZYTools.h"

@implementation ZYHomePageViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.needShowLoginController = ![ZYTools hasAccountAndPassword];
        self.hasCheckIn = YES;
        self.navState = @"首页";
    }
    return self;
}
- (void)autoLogin
{
    ZYLoginRequest *request = [ZYLoginRequest request];
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[ZYTools getKeychain:[ZYTools appVersionToken]];
    request.user_name = [usernamepasswordKVPairs objectForKey:userNameKeychainName];
    request.password = [usernamepasswordKVPairs objectForKey:passwordKeychainName];
    [[[ZYRoute route] loginWith:request] subscribeNext:^(ZYUser *user) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_NOTIFICATION object:user];
    } error:^(NSError *error) {
        //登陆失败 清空账号密码 手动登陆
        if([error.userInfo[@"code"] isEqualToString:@"EB10002"])
        {
            NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
            [usernamepasswordKVPairs setObject:request.user_name forKey:userNameKeychainName];
            [ZYTools saveKeychain:[ZYTools appVersionToken] data:usernamepasswordKVPairs];
            self.needShowLoginController = YES;
        }
    } completed:^{
    }];
}
- (void)requestBannerArr:(ZYUser*)user
{
    ZYBannerRequest *request = [[ZYBannerRequest alloc] init];
    request.user_id = user.pid;
    [[[ZYRoute route] bannersWith:request] subscribeNext:^(NSArray *banners) {
        self.bannerArr = banners;
    } error:^(NSError *error) {
        
    } completed:^{
        
    }];
}
- (void)requestCheckInDays:(ZYUser*)user
{
    ZYCheckInDaysRequest *request = [[ZYCheckInDaysRequest alloc] init];
    request.user_id = user.pid;
    [[[ZYRoute route] checkInDaysWith:request] subscribeNext:^(ZYCheckInModel *checkInModel) {
        self.hasCheckIn = checkInModel.to_day_is_sign;
        self.checkInDays = checkInModel.sign_days;
    } error:^(NSError *error) {
        
    } completed:^{
        
    }];
}
- (void)requestCheckIn:(ZYUser*)user
{
    ZYCheckInRequest *request = [[ZYCheckInRequest alloc] init];
    request.user_id = user.pid;
    [[[ZYRoute route] checkInWith:request] subscribeNext:^(ZYCheckInModel *checkInModel) {
        self.hasCheckIn = checkInModel.to_day_is_sign;
        self.checkInDays = checkInModel.sign_days;
    } error:^(NSError *error) {
        self.error = error.domain;
    } completed:^{
        
    }];
}
- (void)requestWarningEvent:(ZYUser*)user
{
    ZYWarningEventRquest *request = [[ZYWarningEventRquest alloc] init];
    request.user_id = user.pid;
    [[[ZYRoute route] warningEventList:request] subscribeNext:^(NSArray *eventArr) {
        self.eventArr = eventArr;
    } error:^(NSError *error) {
    } completed:^{
    }];
}

@end
