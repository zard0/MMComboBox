//
//  YTTextField.m
//  RentalYi
//
//  Created by yezhibiao on 13-9-23.
//  Copyright (c) 2013年 尹建军. All rights reserved.
//

#import "YTTextField.h"


@implementation YTTextField

/**
 *  释放
 */
- (void)dealloc {
}

/**
 *  初始化
 *
 *  @return <#return value description#>
 */
- (id)init {
    return [self initWithFrame:CGRectZero];
}

/**
 *  初始化方法
 *
 *  @param frame Frame
 *  @param hide  是否隐藏键盘的按钮
 *
 *  @return return value description
 */
- (id)initWithFrame:(CGRect)frame hideKeyBoard:(BOOL)hide {
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor clearColor];
        // 垂直居中
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

        if (!hide) {
            // 不隐藏
            UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, [[UIScreen mainScreen] bounds].size.width, 29.0)];
            self.inputAccessoryView = accessoryView;

            UIButton *keyBoardHideButton = [[UIButton alloc] initWithFrame:CGRectMake(self.inputAccessoryView.frame.size.width - 36.0, 0.0, 36.0, 29.0)];
            keyBoardHideButton.alpha = 0.70;
            self.keyboardAppearance = UIKeyboardAppearanceDefault;

            UIImage *normalImage = [UIImage imageNamed:@"KeyBoard_Hide_iOS7"];
            [keyBoardHideButton setImage:normalImage forState:UIControlStateNormal];
            [keyBoardHideButton addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
            [accessoryView addSubview:keyBoardHideButton];

            normalImage = nil;
            keyBoardHideButton = nil;
            accessoryView = nil;
        }
    }
    return self;
}

/**
 *  按钮触摸事件
 *
 *  @param sender <#sender description#>
 */
- (void)pressedButton:(UIButton *)sender {
    // 发送resignFirstResponder.
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

/**
 *  <#Description#>
 *
 *  @param placeholder <#placeholder description#>
 */
- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
}

/**
 *  <#Description#>
 *
 *  @param bounds <#bounds description#>
 *
 *  @return <#return value description#>
 */
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.edgeInsets.left, self.edgeInsets.right);
}

/**
 *  <#Description#>
 *
 *  @param bounds <#bounds description#>
 *
 *  @return <#return value description#>
 */
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.edgeInsets.left, self.edgeInsets.right);
}

/**
 *  <#Description#>
 *
 *  @param insets <#insets description#>
 */
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    _edgeInsets = edgeInsets;
    [self setNeedsDisplay];
}

/**
 *  <#Description#>
 *
 *  @param textcolor <#textcolor description#>
 */
- (void)setTextcolor:(UIColor *)textcolor {
    _textcolor = textcolor;
    self.textColor = self.textcolor;
}

/**
 *  <#Description#>
 *
 *  @param backgroundcolor <#backgroundcolor description#>
 */
- (void)setBackgroundcolor:(UIColor *)backgroundcolor {
    _backgroundcolor = backgroundcolor;
    self.backgroundColor = self.backgroundcolor;
}

/**
 *  <#Description#>
 *
 *  @param placeholdercolor <#placeholdercolor description#>
 */
- (void)setPlaceholdercolor:(UIColor *)placeholdercolor {
    _placeholdercolor = placeholdercolor;
    [self setValue:self.placeholdercolor forKeyPath:@"_placeholderLabel.textColor"];
}

/**
 *  textLength setter
 *
 *  @param textLength <#textLength description#>
 */
- (void)setTextLength:(NSInteger)textLength {
    _textLength = textLength;

    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setIsCustomDeleteBtn:(BOOL)isCustomDeleteBtn {
    _isCustomDeleteBtn = isCustomDeleteBtn;

    if (_isCustomDeleteBtn) {
        UIImage *image = [UIImage imageNamed:@"TextFieldClear_Icon"];
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setBackgroundImage:image forState:UIControlStateNormal];
        deleteBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [deleteBtn addTarget:self action:@selector(deleteText:) forControlEvents:UIControlEventTouchUpInside];

        self.rightView = deleteBtn;
        self.rightViewMode = UITextFieldViewModeWhileEditing;
        [self addTarget:self action:@selector(textChangeNew:) forControlEvents:UIControlEventEditingChanged];
    } else {
        [self removeTarget:self action:@selector(textChangeNew:) forControlEvents:UIControlEventEditingChanged];
        self.rightView = nil;
        self.rightViewMode = UITextFieldViewModeNever;
    }
}

- (void)deleteText:(UIButton *)button {
    self.text = @"";
    self.rightViewMode = UITextFieldViewModeNever;

    if (self.tapDeleteButton) {
        self.tapDeleteButton();
    }
}


- (void)textChangeNew:(UITextField *)textField {
    if (textField.text.length == 0) {
        self.rightViewMode = UITextFieldViewModeNever;
    } else {
        self.rightViewMode = UITextFieldViewModeWhileEditing;
    }
}

/**
 *  限制字符长度
 *
 *  @param textField <#textField description#>
 */
- (void)textFieldDidChange:(UITextField *)textField {

    NSInteger kTextFieldLengthLimit = _textLength;
    NSString *toBeString = textField.text;

    // 键盘输入模式(判断输入模式的方法是iOS7以后用到的)
    NSArray *currentar = [UITextInputMode activeInputModes];
    UITextInputMode *current = [currentar firstObject];

    if ([current.primaryLanguage isEqualToString:@"zh-Hans"]) {
        // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        // 获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kTextFieldLengthLimit) {
                textField.text = [toBeString substringToIndex:kTextFieldLengthLimit];
            }
        } else {
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    } else {
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kTextFieldLengthLimit) {
            textField.text = [toBeString substringToIndex:kTextFieldLengthLimit];
        }
    }

    toBeString = textField.text;
    // inputFormat
    if (self.inputFormatType == InputFormatNumberType) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        NSArray *stringArray = [toBeString componentsSeparatedByCharactersInSet:cs];
        textField.text = [stringArray componentsJoinedByString:@""];
    } else if (self.inputFormatType == InputFormatUNormalType) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"-0123456789"] invertedSet];
        NSArray *stringArray = [toBeString componentsSeparatedByCharactersInSet:cs];
        textField.text = [stringArray componentsJoinedByString:@""];
    } else if (self.inputFormatType == InputFormatFloatNumberType) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@".0123456789"] invertedSet];
        NSArray *stringArray = [toBeString componentsSeparatedByCharactersInSet:cs];
        textField.text = [stringArray componentsJoinedByString:@""];
    }
}

@end
