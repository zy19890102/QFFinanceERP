//
//  ZYForeclosureHouseController.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYForeclosureHouseController.h"
#import "ZYBussinessInfoSections.h"
#import "ZYApplyInfoSections.h"
#import "ZYHousePropertyInfoSections.h"
#import "ZYBothSideInfoSections.h"
#import "ZYOriginalBankSections.h"
#import "ZYCurrentBankSections.h"
#import "ZYOrderInfoSections.h"
#import "ZYApplicationSections.h"
#import "ZYCostInfoSections.h"
#import "ZYStepView.h"
#import "ZYTopTabBar.h"

@interface ZYForeclosureHouseSubController : ZYSliderViewController

@end

@implementation ZYForeclosureHouseSubController
{
    ZYHousePropertyInfoSections *housePropertyInfoSections;
    ZYBothSideInfoSections *bothSideInfoSections;
    ZYOriginalBankSections *originalBankSections;
    ZYCurrentBankSections *currentBankSections;
    
    NSArray *sectionsArr;
    
    ZYTopTabBar *topBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
}
- (void)buildUI
{
    housePropertyInfoSections = [[ZYHousePropertyInfoSections alloc] initWithTitle:@"物业信息"];
    bothSideInfoSections = [[ZYBothSideInfoSections alloc] initWithTitle:@"买卖双方信息"];
    originalBankSections = [[ZYOriginalBankSections alloc] initWithTitle:@"原贷款银行信息"];
    currentBankSections = [[ZYCurrentBankSections alloc] initWithTitle:@"新贷款银行信息"];
    
    sectionsArr = @[housePropertyInfoSections,
                    bothSideInfoSections,
                    originalBankSections,
                    currentBankSections,];
    [self buildTableViewController];
    
    NSMutableArray *titleArr = [NSMutableArray arrayWithCapacity:4];
    for(ZYSections *sections in sectionsArr)
    {
        [titleArr addObject:sections.title];
    }
    
    topBar = [[ZYTopTabBar alloc] initWithTabs:titleArr];
    topBar.backgroundColor = [UIColor whiteColor];
    topBar.frame = CGRectMake(0, 0, FUll_SCREEN_WIDTH, 50);
    [self.view addSubview:topBar];
    
    [topBar.tabButtonPressedSignal subscribeNext:^(NSNumber *index) {
        [self changePage:index.longLongValue];
    }];
    
    ZYDoubleButtonCell *buttonView = [ZYDoubleButtonCell cellWithActionBlock:nil];
    buttonView.frame = CGRectMake(0, FUll_SCREEN_HEIGHT-50-64-[ZYDoubleButtonCell defaultHeight], FUll_SCREEN_WIDTH, [ZYDoubleButtonCell defaultHeight]);
    buttonView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:buttonView];
    
    [[buttonView leftButtonPressedSignal] subscribeNext:^(id x) {
        
    }];
    [[buttonView rightButtonPressedSignal] subscribeNext:^(id x) {
        
    }];
}
- (ZYSections*)sliderController:(ZYSliderViewController*)controller sectionsWithPage:(NSInteger)page
{
    return sectionsArr[page];
}
- (NSInteger)countOfControllerSliderController:(ZYSliderViewController *)controller
{
    return sectionsArr.count;
}
- (CGRect)sliderController:(ZYSliderViewController*)controller frameWithPage:(NSInteger)page
{
    return CGRectMake(page*FUll_SCREEN_WIDTH, 50, FUll_SCREEN_WIDTH, FUll_SCREEN_HEIGHT-100-64);
}
- (void)sliderController:(ZYSliderViewController *)controller changingPage:(NSInteger)index direction:(ZYSliderDirection)direction rate:(CGFloat)rate
{
    topBar.rate = rate;
}
- (void)sliderController:(ZYSliderViewController *)controller didChangePage:(NSInteger)index direction:(ZYSliderDirection)direction
{
    topBar.highlightIndex = index;
}
@end

@interface ZYForeclosureHouseController ()

@property (weak, nonatomic) IBOutlet UIView *progressBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidth;
@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressWidth;

@property (weak, nonatomic) IBOutlet UIScrollView *stepScrollView;

@property (strong, nonatomic)NSMutableArray *labelArr;
@property (strong, nonatomic)NSMutableArray *viewArr;

@end

@implementation ZYForeclosureHouseController
{
    NSArray *sectionsArr;
    
    ZYBussinessInfoSections *bussinessInfoSections;
    ZYApplyInfoSections *applyInfoSections;
    ZYSections *foreclosureHouseInfoSections;
    ZYCostInfoSections *costInfoSections;
    ZYOrderInfoSections *orderInfoSections;
    ZYApplicationSections *applicationSections;
    
    ZYForeclosureHouseSubController *subSliderViewCtl;
    
    NSInteger steps;
    CGFloat stepWidth;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
}
- (void)updateViewConstraints
{
    [super updateViewConstraints];
    self.contentWidth.constant = 1.5*FUll_SCREEN_WIDTH;
}
- (void)buildUI
{
    bussinessInfoSections = [[ZYBussinessInfoSections alloc] initWithTitle:@"业务信息"];
    applyInfoSections = [[ZYApplyInfoSections alloc] initWithTitle:@"申请信息 "];
    foreclosureHouseInfoSections = [[ZYSections alloc] initWithTitle:@"赎楼信息"];
    costInfoSections = [[ZYCostInfoSections alloc] initWithTitle:@"费用信息"];
    orderInfoSections = [[ZYOrderInfoSections alloc] initWithTitle:@"赎楼清单"];
    applicationSections = [[ZYApplicationSections alloc] initWithTitle:@"申请信息"];
    
    sectionsArr = @[bussinessInfoSections,
                    applyInfoSections,
                    foreclosureHouseInfoSections,
                    costInfoSections,
                    orderInfoSections,
                    applicationSections];
    
    subSliderViewCtl = [[ZYForeclosureHouseSubController alloc] init];
    
    _labelArr = [NSMutableArray arrayWithCapacity:10];
    _viewArr = [NSMutableArray arrayWithCapacity:10];
    
    steps = sectionsArr.count;
    stepWidth = 1.5*FUll_SCREEN_WIDTH/steps;
    [sectionsArr enumerateObjectsUsingBlock:^(ZYSections * _Nonnull sections, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = sections.title;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(stepWidth/2.f+idx*stepWidth-30, -30, 60, 15)];
        label.font = FONT(12);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithHexString:@"c3c3c3"];
        label.text = title;
        
        ZYStepView *stepView = [[ZYStepView alloc] initWithFrame:CGRectMake(stepWidth/2.f+idx*stepWidth-10, -8, 20, 20)];
        stepView.text = [NSString stringWithFormat:@"%lu",(unsigned long)idx+1];
        [_progressBackView addSubview:stepView];
        [_progressBackView addSubview:label];
        [_labelArr addObject:label];
        [_viewArr addObject:stepView];
        if(idx==0)
        {
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor colorWithHexString:@"0086d1"];
            [stepView highlight:YES];
        }
    }];
    if(steps!=0)
        self.progressWidth.constant = (self.contentWidth.constant/steps)/2.f;
    
    [self buildTableViewController];
}
- (ZYSections*)sliderController:(ZYSliderViewController*)controller sectionsWithPage:(NSInteger)page
{
    return sectionsArr[page];
}
- (NSInteger)countOfControllerSliderController:(ZYSliderViewController *)controller
{
    return sectionsArr.count;
}
- (CGRect)sliderController:(ZYSliderViewController*)controller frameWithPage:(NSInteger)page
{
    return CGRectMake(page*FUll_SCREEN_WIDTH, 50+64, FUll_SCREEN_WIDTH, FUll_SCREEN_HEIGHT-64-50);
}
- (UIView*)sliderController:(ZYSliderViewController *)controller customViewWithpage:(NSInteger)page
{
    if(page==2)
    {
        return subSliderViewCtl.view;
    }
    return nil;
}
- (void)sliderController:(ZYSliderViewController *)controller changingPage:(NSInteger)index direction:(ZYSliderDirection)direction rate:(CGFloat)rate
{
    self.progressWidth.constant = stepWidth/2.f+(1.5*FUll_SCREEN_WIDTH-stepWidth)*rate;
}
- (void)sliderController:(ZYSliderViewController *)controller didChangePage:(NSInteger)index direction:(ZYSliderDirection)direction
{
    for(int i=0;i<_labelArr.count;i++)
    {
        UILabel *label = _labelArr[i];
        ZYStepView *view = _viewArr[i];
        if(i<=index)
        {
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor colorWithHexString:@"0086d1"];
            [view highlight:YES];
            
        }
        else
        {
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor colorWithHexString:@"c3c3c3"];
            [view highlight:NO];
        }
    }
    
    CGPoint point = _stepScrollView.contentOffset;
    
    if (index!=steps-1&&index>=3&&direction==ZYSliderToRight)
    {
        point.x = (index-2)*stepWidth;
        [self.stepScrollView setContentOffset:point animated:YES];
    }
    if ((index==3||index==2)&&direction==ZYSliderToLeft)
    {
        point.x = (index-2)*stepWidth;
        [self.stepScrollView setContentOffset:point animated:YES];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
