//
//  ZYFilterBar.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/21.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYFilterBar.h"

@implementation ZYFilterBar
{
    UIViewController *controller;
    NSMutableArray *topButtonArr;
}
- (instancetype)initWithController:(UIViewController*)ctl frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        controller = ctl;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    
    CGRect frame = self.frame;
    NSArray *titles = nil;
    if([_delegate respondsToSelector:@selector(filterBarTitles)])
    {
        titles = [_delegate filterBarTitles];
    }
    NSInteger totleLevel = titles.count;
    CGFloat levelWidth = frame.size.width/totleLevel;
    CGFloat levelHeight = frame.size.height;
    topButtonArr = [NSMutableArray arrayWithCapacity:totleLevel];
    [titles enumerateObjectsUsingBlock:^(NSString* _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(levelWidth*idx, 0, levelWidth, levelHeight)];
        [button setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        UIImage *image = [UIImage imageNamed:@"drop"];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(topButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [topButtonArr addObject:button];
        CGSize size = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
        CGFloat gap = (button.width-image.size.width-size.width)/2.f;
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -gap)];
    }];
}
- (void)topButtonPressed:(UIButton*)button
{
    [self resetTopButton];
    [button setTitleColor:BLUE forState:UIControlStateNormal];
}
- (void)resetTopButton
{
    [topButtonArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        [button setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    }];
}
- (void)drawRect:(CGRect)rect {
    
    CGFloat width = 1/[UIScreen mainScreen].scale;
    
    CALayer *line = [CALayer layer];
    line.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"].CGColor;
    line.frame = CGRectMake(0, rect.size.height-width, rect.size.width, width);
    [self.layer addSublayer:line];
    
    for(int i=0;i<topButtonArr.count-1;i++)
    {
        CGFloat gap = rect.size.width/topButtonArr.count-1;
        CALayer *line = [CALayer layer];
        line.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"].CGColor;
        line.frame = CGRectMake(gap+gap*i, 10, width, rect.size.height-20.f);
        [self.layer addSublayer:line];
    }
    
}
@end
