//
//  ZYFilterBar.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/21.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYFilterBar.h"
#import "ZYTableViewCell.h"
@interface ZYFilterBar()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ZYFilterBar
{
    UIViewController *controller;
    NSMutableArray *topButtonArr;
    NSMutableArray *dropImageArr;
    
    CGFloat bottomGap;
    
    UIView *bgView;
    
    NSInteger currentIndex;
    
    NSInteger currentLevel;
    
    NSInteger currentRow;
    
    UITableView *dropTableView;
    UITableView *dropSubTableView;
    
    NSArray *dataSource;
    NSArray *subDataSource;
    BOOL droped;
}
- (instancetype)initWithController:(UIViewController*)ctl frame:(CGRect)frame delegate:(id)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        controller = ctl;
        
        self.backgroundColor = [UIColor whiteColor];
        
        NSArray *titles = nil;
        if([_delegate respondsToSelector:@selector(filterBarTitles:)])
        {
            titles = [_delegate filterBarTitles:self];
        }
        NSInteger totleLevel = titles.count;
        CGFloat levelWidth = frame.size.width/totleLevel;
        CGFloat levelHeight = frame.size.height;
        topButtonArr = [NSMutableArray arrayWithCapacity:totleLevel];
        dropImageArr = [NSMutableArray arrayWithCapacity:totleLevel];
        bottomGap = FUll_SCREEN_HEIGHT-frame.origin.y-frame.size.height;
        
        [titles enumerateObjectsUsingBlock:^(NSString* _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(levelWidth*idx, 0, levelWidth, levelHeight);
            button.titleLabel.font = FONT(14);
            [button setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
            [button setTitle:title forState:UIControlStateNormal];
            [button addTarget:self action:@selector(topButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            button.tag = idx;
            [topButtonArr addObject:button];
            
            UIImage *image = [UIImage imageNamed:@"drop"];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(button.width-image.size.width-GAP, (button.height-image.size.height)/2.f, image.size.width, image.size.height)];
            imageView.image = image;
            [dropImageArr addObject:imageView];
            [button addSubview:imageView];
            
            //        CGSize size = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
//            CGFloat gap = button.width/2.f+image.size.width;
//            [button setImageEdgeInsets:UIEdgeInsetsMake(0, gap, 0, -gap)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width+GAP, 0, image.size.width-GAP)];
        }];
        
        dropTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, frame.origin.y+frame.size.height, FUll_SCREEN_WIDTH, 0) style:UITableViewStylePlain];
        dropTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        dropTableView.delegate = self;
        dropTableView.dataSource = self;
        [controller.view addSubview:dropTableView];
        
        dropSubTableView = [[UITableView alloc] initWithFrame:CGRectMake(FUll_SCREEN_WIDTH/2.f, frame.origin.y+frame.size.height, FUll_SCREEN_WIDTH/2.f, 0) style:UITableViewStylePlain];
        dropSubTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        dropSubTableView.delegate = self;
        dropSubTableView.dataSource = self;
        dropSubTableView.backgroundColor = TEXT_COLOR;
        [controller.view addSubview:dropSubTableView];
        
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.Y+self.height, FUll_SCREEN_WIDTH, bottomGap)];
        bgView.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTap)];
        [bgView addGestureRecognizer:tap];
        bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        [controller.view addSubview:bgView];
    }
    return self;
}

- (void)bgTap//背景触摸
{
    [self dropTableView:NO];
}
- (void)topButtonPressed:(UIButton*)button
{
    [self resetTopButton];
    [self resetDropImage];
    [button setTitleColor:BLUE forState:UIControlStateNormal];
    UIImageView *drop = dropImageArr[button.tag];
    [UIView animateWithDuration:0.1 animations:^{
        drop.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    currentIndex = button.tag;
    
    if(_delegate&&[_delegate respondsToSelector:@selector(filterBar:itemsWithIndex:level:)])
    {
        currentLevel = 0;
        dataSource = [_delegate filterBar:self itemsWithIndex:currentIndex level:currentLevel];
        currentLevel = 1;
        subDataSource = [_delegate filterBar:self itemsWithIndex:currentIndex level:currentLevel];
    }
    else
    {
        dataSource = nil;
    }
    [self dropTableView:!droped];
}
- (void)dropTableView:(BOOL)drop
{
    [dropTableView reloadData];
    [dropSubTableView reloadData];
    NSInteger levelCount = 0;
    if(_delegate&&[_delegate respondsToSelector:@selector(filterBar:levelCountWithIndex:)])
    {
        levelCount = [_delegate filterBar:self levelCountWithIndex:currentIndex];
    }
    levelCount = levelCount>2?2:levelCount;
    levelCount = levelCount<=0?1:levelCount;
    if(levelCount==2)
    {
        dropTableView.width = FUll_SCREEN_WIDTH/2.f;
    }
    if(drop)
    {
        bgView.hidden = NO;
        [controller.view bringSubviewToFront:bgView];
        [controller.view bringSubviewToFront:dropSubTableView];
        [controller.view bringSubviewToFront:dropTableView];
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            dropTableView.height = bottomGap*2.f/3.f;
            if(levelCount==2)
            {
                dropSubTableView.height = bottomGap*2.f/3.f;
            }
            bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        } completion:^(BOOL finished) {
            
        }];
        droped = YES;
    }
    else
    {
        [controller.view sendSubviewToBack:bgView];
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            dropTableView.height = 0;
            if(levelCount==2)
            {
                dropSubTableView.height = 0;
            }
            bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        } completion:^(BOOL finished) {
            bgView.hidden = YES;
            [self resetTopButton];
            [self resetDropImage];
        }];
        droped = NO;
    }
    
}
- (void)resetTopButton
{
    [topButtonArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        [button setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    }];
}
- (void)resetDropImage
{
    [dropImageArr enumerateObjectsUsingBlock:^(UIImageView*  _Nonnull drop, NSUInteger idx, BOOL * _Nonnull stop) {
        [UIView animateWithDuration:0.1 animations:^{
            drop.transform = CGAffineTransformMakeRotation(0);
        }];
    }];
}
- (void)hidden
{
    [self dropTableView:NO];
}
- (void)changeTitle:(NSString*)title atIndex:(NSInteger)index
{
    UIButton *button = topButtonArr[index];
    [button setTitle:title forState:UIControlStateNormal];
}
- (void)drawRect:(CGRect)rect {
    
//    CGFloat width = 1/[UIScreen mainScreen].scale;
//    
//    CALayer *line = [CALayer layer];
//    line.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"].CGColor;
//    line.frame = CGRectMake(0, rect.size.height-width, rect.size.width, width);
//    [self.layer addSublayer:line];
//    
//    for(int i=0;i<topButtonArr.count;i++)
//    {
//        CGFloat gap = rect.size.width/topButtonArr.count;
//        CALayer *line = [CALayer layer];
//        line.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"].CGColor;
//        line.frame = CGRectMake(gap+gap*i-width, 10, width, rect.size.height-20.f);
//        [self.layer addSublayer:line];
//    }
//    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==dropTableView)
        return dataSource.count;
    if(tableView==dropSubTableView)
        return subDataSource.count;
    return 0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil)
    {
        cell = [[ZYTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = FONT(14);
    }
    if(tableView==dropTableView)
    {
        cell.textLabel.text = dataSource[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
    }
    if(tableView==dropSubTableView)
    {
        cell.textLabel.text = subDataSource[indexPath.row];
        cell.backgroundColor = TEXT_COLOR;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentRow = indexPath.row;
    if(tableView==dropTableView)
    {
        currentLevel = 0;
        [tableView reloadData];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = TEXT_COLOR;
        if(_delegate&&[_delegate respondsToSelector:@selector(filterBar:selecedWithIndex:level:row:)])
        {
            currentLevel = 0;
            if(![_delegate filterBar:self selecedWithIndex:currentIndex level:currentLevel row:currentRow])
            {
                dataSource = nil;
                [dropSubTableView reloadData];
                [self hidden];
                return;
            }
        }
        currentLevel = 1;
        if(_delegate&&[_delegate respondsToSelector:@selector(filterBar:itemsWithIndex:level:)])
        {
            subDataSource = [_delegate filterBar:self itemsWithIndex:currentIndex level:currentLevel];
        }
        else
        {
            subDataSource = nil;
        }
        [dropSubTableView reloadData];
    }
    if(tableView==dropSubTableView)
    {
        currentLevel = 1;
        if(_delegate&&[_delegate respondsToSelector:@selector(filterBar:selecedWithIndex:level:row:)])
        {
            if(![_delegate filterBar:self selecedWithIndex:currentIndex level:currentLevel row:currentRow])
            {
                [self hidden];
                return;
            }
        }
    }
}
@end
