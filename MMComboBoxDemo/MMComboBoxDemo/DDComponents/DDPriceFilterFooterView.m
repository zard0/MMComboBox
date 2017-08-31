//
//  BuyerTableFooterView.m
//  DongDongBroker
//
//  Created by yitudev on 2017/8/9.
//  Copyright © 2017年 深圳市易图资讯股份有限公司. All rights reserved.
//

#import "DDPriceFilterFooterView.h"
#import "YTTextField.h"
#import "UIColor+Fetch.h"
#import "YTImageUtils.h"
#import "UIView+YTEmptyView.h"
#import "MMComboBoxHeader.h"

@interface DDPriceFilterFooterView ()<UITextFieldDelegate>

/// 自定义文字
@property (nonatomic, strong) UILabel *tipLabel;
/// 中间view
@property (nonatomic, strong) UIView *middleView;
/// 最小价格输入框
@property (nonatomic, strong) YTTextField *minPriceTextField;
/// 最大价格输入框
@property (nonatomic, strong) YTTextField *maxPriceTextField;
/// 万
@property (nonatomic, strong) UILabel *tenThousandLabel;
/// -
@property (nonatomic, strong) UIView *lineView;
/// 确定按钮
@property (nonatomic, strong) UIButton *sureButton;

@end

@implementation DDPriceFilterFooterView

/**
 释放内存
 */
- (void)dealloc {
    [_tipLabel removeFromSuperview];
    _tipLabel = nil;
    [_middleView removeFromSuperview];
    _middleView = nil;
    [_minPriceTextField removeFromSuperview];
    _minPriceTextField = nil;
    [_maxPriceTextField removeFromSuperview];
    _maxPriceTextField = nil;
    [_tenThousandLabel removeFromSuperview];
    _tenThousandLabel = nil;
    [_lineView removeFromSuperview];
    _lineView = nil;
}

/**
 初始化视图

 @param frame frame description
 @return return value description
 */
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithNumber:13];
        // 加单击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:tapGesture];
        [self setUpSubView];
    }
    return self;
}

/**
 子视图
 */
- (void)setUpSubView {
    // 自定义
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 50, 62)];
    _tipLabel.font = [UIFont systemFontOfSize:14];
    _tipLabel.textColor = [UIColor colorWithNumber:18];
    _tipLabel.text = @"自定义";
    [self addSubview:_tipLabel];
    
    // 包含 最小、最大价格输入框、万、-
    _middleView = [[UIView alloc] init];
    [self addSubview:_middleView];
    
    UIImage *textImage = [YTImageUtils getImageWithNameByPath:@"CustomerDemand/CustomerDemand_Input"];
    // 最小价格输入框
    _minPriceTextField = [self createYYTextField];
    _minPriceTextField.frame = CGRectMake(0, 0, 70, 30);
    _minPriceTextField.tag = 100;
    _minPriceTextField.placeholder = @"最低价";
    [_minPriceTextField setBackground:[textImage stretchableImageWithLeftCapWidth:textImage.size.width / 2 topCapHeight:textImage.size.height / 2]];
    [_middleView addSubview:_minPriceTextField];
    
    // -
    _lineView = [UIView new];
    _lineView.backgroundColor = [UIColor colorWithNumber:18];
    _lineView.frame = CGRectMake(_minPriceTextField.right + 5, 0, 10, 1);
    _lineView.centerY = _minPriceTextField.centerY;
    [_middleView addSubview:_lineView];
    
    // 最大价格输入框
    _maxPriceTextField = [self createYYTextField];
    _maxPriceTextField.frame = CGRectMake(_lineView.right + 5, 0, 70, 30);
    _maxPriceTextField.tag = 101;
    _maxPriceTextField.placeholder = @"最高价";
    [_maxPriceTextField setBackground:[textImage stretchableImageWithLeftCapWidth:textImage.size.width / 2 topCapHeight:textImage.size.height / 2]];
    [_middleView addSubview:_maxPriceTextField];
    
    // 万
    _tenThousandLabel = [UILabel new];
    _tenThousandLabel.font = [UIFont systemFontOfSize:18];
    _tenThousandLabel.textColor = [UIColor colorWithNumber:18];
    _tenThousandLabel.text = @"万";
    [_tenThousandLabel sizeToFit];
    _tenThousandLabel.x = _maxPriceTextField.right + 5;
    _tenThousandLabel.centerY = _maxPriceTextField.centerY;
    [_middleView addSubview:_tenThousandLabel];
    
    _middleView.frame = CGRectMake(0, 15, _minPriceTextField.width + _lineView.width + _maxPriceTextField.width + _tenThousandLabel.width + 15, 30);
    _middleView.centerX = self.centerX;
    
    
    // 确定按钮
    UIImage *buttonImage = [YTImageUtils getImageWithNameByPath:@"Home/MutiColor" resizable:YES];
    _sureButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 62, kScreenWidth, 50)];
    [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sureButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [_sureButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [_sureButton addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sureButton];
    
}


/**
 创建输入框

 @return <#return value description#>
 */
- (YTTextField *)createYYTextField {
    YTTextField *textField = [[YTTextField alloc] initWithFrame:CGRectZero hideKeyBoard:YES];
    textField.delegate = self;
    textField.backgroundColor = [UIColor clearColor];
    textField.textColor = [UIColor blackColor];
    textField.font = [UIFont systemFontOfSize:18.0];
    textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    textField.inputFormatType = InputFormatFloatNumberType;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.textLength = 6;
    return textField;
}

#pragma mark - BuyerTableFooterViewDelegate

- (void)pressedButton:(UIButton *)sender {
    NSString *minTextString = @"";
    NSString *maxTextString = @"";
    if (_minPriceTextField.text.length == 0) {
        minTextString = @"0";
    } else {
        minTextString = _minPriceTextField.text;
    }
    if (_maxPriceTextField.text.length == 0) {
        maxTextString = _maxPriceTextField.placeholder;
    } else {
        maxTextString = _maxPriceTextField.text;
    }
    
    if ([self.aDelegate respondsToSelector:@selector(sureButtonClickedMinTextString:maxTextString:)]) {
        [self.aDelegate sureButtonClickedMinTextString:minTextString maxTextString:maxTextString];
    }

}

#pragma mark - 单击手势

/**
 *  单击
 *
 *  @param tap <#tap description#>
 */
- (void)tapGesture:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self];
    if (CGRectContainsPoint(self.middleView.frame, point)) {
        return;
    }
    [self.minPriceTextField resignFirstResponder];
    [self.maxPriceTextField resignFirstResponder];
}

@end
