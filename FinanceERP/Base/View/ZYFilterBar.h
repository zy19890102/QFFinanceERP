//
//  ZYFilterBar.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/21.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZYFilterBarDelegate <NSObject>

- (NSArray*)filterBarTitles;

@end

@interface ZYFilterBar : UIView

@property(nonatomic,assign)id<ZYFilterBarDelegate>delegate;

- (instancetype)initWithController:(UIViewController*)ctl frame:(CGRect)frame;
@end
