//
//  ZYSelectCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/8.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewCell.h"

@interface ZYSelectCell : ZYTableViewCell

@property(nonatomic,strong)NSString *cellTitle;
@property(nonatomic,strong)NSString *cellText;

@property(nonatomic,assign)BOOL cellNullable;/// 默认不能为空

@property(nonatomic,assign)BOOL checkInput;///检查是否为空

@property(nonatomic,assign)BOOL available;///是否可用
@end
