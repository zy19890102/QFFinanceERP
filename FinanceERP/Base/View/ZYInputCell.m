//
//  ZYInputCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/8.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYInputCell.h"

#define FLOAT @"0123456789."
#define INT @"0123456789"

@interface ZYInputCell()<UITextFieldDelegate>

//@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
//@property (weak, nonatomic) IBOutlet UITextField *cellTextField;
//@property (weak, nonatomic) IBOutlet UILabel *tailLabel;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellTailLabelWidth;

@property (strong, nonatomic) UILabel *cellTitleLabel;
@property (strong, nonatomic) UITextField *cellTextField;
@property (strong, nonatomic) UILabel *tailLabel;

@end

@implementation ZYInputCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, 0, 100, [ZYInputCell defaultHeight])];
        _cellTitleLabel.textAlignment = NSTextAlignmentRight;
        _cellTitleLabel.font = FONT(14);
        _cellTitleLabel.textColor = TITLE_COLOR;
        [self addSubview:_cellTitleLabel];
        
        _tailLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, 0, 0, [ZYInputCell defaultHeight])];
        _tailLabel.font = FONT(14);
        _tailLabel.textColor = TITLE_COLOR;
        [self addSubview:_tailLabel];
        
        _cellTextField = [[UITextField alloc] initWithFrame:CGRectMake(_cellTitleLabel.width+2*GAP, 0, FUll_SCREEN_WIDTH-4*GAP-_cellTitleLabel.width-_tailLabel.width, [ZYInputCell defaultHeight])];
        _cellTextField.font = FONT(12);
        _cellTextField.textColor = TITLE_COLOR;
        [self addSubview:_cellTextField];
    }
    return self;
}

- (void)awakeFromNib
{
    _cellTextField.delegate = self;
    @weakify(self)
    [_cellTextField.rac_textSignal subscribeNext:^(NSString *text) {
        @strongify(self)
        self.cellText = text;
        if(_checkInput)
        {
            [self setCellTitle:self.cellTitle];
        }
    }];
}
- (void)setOnlyFloat:(BOOL)onlyFloat
{
    _onlyFloat = onlyFloat;
    self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
}
- (void)setOnlyInt:(BOOL)onlyInt
{
    _onlyInt = onlyInt;
    self.keyboardType = UIKeyboardTypeNumberPad;
}
- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    _keyboardType = keyboardType;
    _cellTextField.keyboardType = keyboardType;
}
- (void)setCellText:(NSString *)cellText
{
    _cellText = cellText;
    _cellTextField.text = cellText;
}
- (void)setCellTailText:(NSString *)cellTailText
{
    _cellTailText = cellTailText;
    _tailLabel.text = cellTailText;
    CGSize size = [cellTailText sizeWithAttributes:@{NSFontAttributeName:_tailLabel.font}];
    _tailLabel.width = size.width;
    _tailLabel.X = FUll_SCREEN_WIDTH-size.width-GAP;
    _cellTextField.width = FUll_SCREEN_WIDTH-_tailLabel.width-_cellTitleLabel.width-4*GAP;
}
- (void)setCellTitle:(NSString *)cellTitle
{
    _cellTitle = cellTitle;
    _cellTitleLabel.text = cellTitle;
    if(!_cellNullable)
    {
        if(!_checkInput||(_checkInput&&_cellText.length!=0))///需要检查是否为空
        {
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"* %@",cellTitle]];
            [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
            _cellTitleLabel.attributedText = attrStr;
            self.available = YES;
        }
        else
        {
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"* %@",cellTitle]];
            [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, attrStr.length)];
            _cellTitleLabel.attributedText = attrStr;
            self.available = NO;
        }
    }
    else
    {
        _cellTitleLabel.text = cellTitle;
    }
}
- (void)setCellNullable:(BOOL)cellNullable
{
    _cellNullable = cellNullable;
    [self setCellTitle:_cellTitle];
}
- (void)setCellPlaceHolder:(NSString *)cellPlaceHolder
{
    _cellPlaceHolder = cellPlaceHolder;
    _cellTextField.placeholder = cellPlaceHolder;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(self.onlyFloat)
    {
        NSCharacterSet*cs;///限制输入类型 为float
        if([textField.text rangeOfString:@"."].length==0)///没有小数点时候可以输入小数点
        {
            cs = [[NSCharacterSet characterSetWithCharactersInString:FLOAT] invertedSet];
        }
        else
        {
            cs = [[NSCharacterSet characterSetWithCharactersInString:INT] invertedSet];
        }
        NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest) {
            return NO;
        }
        _maxLength = _maxLength==0?11:_maxLength;
        if(textField.text.length+string.length>_maxLength)///限制长度
        {
            NSMutableString *str = [NSMutableString stringWithString:textField.text];
            [str replaceCharactersInRange:range withString:string];
            textField.text = [str substringToIndex:_maxLength];
            return NO;
        }
    }
    else if (self.onlyInt)
    {
        NSCharacterSet*cs;///限制输入类型 为float
        cs = [[NSCharacterSet characterSetWithCharactersInString:INT] invertedSet];
        NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest) {
            return NO;
        }
        _maxLength = _maxLength==0?10:_maxLength;
        if(textField.text.length+string.length>_maxLength)///限制长度
        {
            NSMutableString *str = [NSMutableString stringWithString:textField.text];
            [str replaceCharactersInRange:range withString:string];
            textField.text = [str substringToIndex:_maxLength];
            return NO;
        }
    }
    else if (self.onlyCustom&&_customInput.length>0)
    {
        NSCharacterSet*cs;///限制输入类型 为float
        cs = [[NSCharacterSet characterSetWithCharactersInString:_customInput] invertedSet];
        NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest) {
            return NO;
        }
        _maxLength = _maxLength==0?5:_maxLength;
        if(textField.text.length+string.length>_maxLength)///限制长度
        {
            NSMutableString *str = [NSMutableString stringWithString:textField.text];
            [str replaceCharactersInRange:range withString:string];
            textField.text = [str substringToIndex:_maxLength];
            return NO;
        }
    }
    else
    {
        _maxLength = _maxLength==0?10:_maxLength;
        if(textField.text.length+string.length>_maxLength)///限制长度
        {
            NSMutableString *str = [NSMutableString stringWithString:textField.text];
            [str replaceCharactersInRange:range withString:string];
            textField.text = [str substringToIndex:_maxLength];
            return NO;
        }
    }
    return YES;
}
- (void)setCheckInput:(BOOL)checkInput
{
    _checkInput = checkInput;
    if(_checkInput)
    {
        [self setCellTitle:self.cellTitle];
    }
}
@end
