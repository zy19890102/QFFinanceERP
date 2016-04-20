//
//  ZYTableViewController.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/1.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewController.h"
#import "ZYSection.h"
#import "ZYTableViewCell.h"
#import "ZYViewController.h"

@interface ZYTableViewController : ZYViewController

/**
 *  cell分组
 */
@property (strong,nonatomic) NSArray *sections;

@property (assign,nonatomic) BOOL autoReload;///默认自动刷新

//- (UITableView*)tableView;

- (void)showSection:(BOOL)show sectionIndex:(NSInteger)sectionIndex;

@property(nonatomic,assign)CGRect frame;
@end
