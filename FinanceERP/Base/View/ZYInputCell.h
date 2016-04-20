//
//  ZYInputCell.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/8.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYTableViewCell.h"

@interface ZYInputCell : ZYTableViewCell

@property(nonatomic,strong)NSString *cellTitle;
@property(nonatomic,strong)NSString *cellText;
@property(nonatomic,strong)NSString *cellPlaceHolder;
@property(nonatomic,strong)NSString *cellTailText;

@property(nonatomic,assign)BOOL onlyFloat;
@property(nonatomic,assign)BOOL onlyInt;

@property(nonatomic,assign)BOOL onlyCustom;///自定义输入内容
@property(nonatomic,strong)NSString *customInput;///制定只能输入哪些字符
/**
 *  输入最长字符
 */
@property(nonatomic,assign)NSInteger maxLength;

@property(nonatomic,assign)UIKeyboardType keyboardType;

@property(nonatomic,assign)BOOL cellNullable;/// 默认不能为空

@property(nonatomic,assign)BOOL checkInput;///检查是否为空  用于赋值

@property(nonatomic,assign)BOOL available;///是否可用  用于监听
@end
