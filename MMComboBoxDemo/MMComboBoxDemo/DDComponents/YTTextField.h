//
//  YTTextField.h
//  RentalYi
//
//  Created by yezhibiao on 13-9-23.
//  Copyright (c) 2013年 尹建军. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,InputFormatType){
    /// 无限制
    InputFormatNormalType = 0,
    /// 纯数字
    InputFormatNumberType,
    /// 数字 包括负号（-）
    InputFormatUNormalType,
    /// 数字包括小数点
    InputFormatFloatNumberType
    
};

typedef void (^TapDeleteButtonBlcok)();
@interface YTTextField : UITextField

/// 内边距
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
/// placeholder 颜色
@property (strong, nonatomic) UIColor *placeholdercolor;
/// 文字颜色
@property (strong, nonatomic) UIColor *textcolor;
/// 背景颜色
@property (strong, nonatomic) UIColor *backgroundcolor;
/// 长度限制
@property (nonatomic, assign) NSInteger textLength;
/// 输入格式
@property (nonatomic, assign) InputFormatType inputFormatType;
/// 自定义删除按钮
@property (nonatomic, assign) BOOL isCustomDeleteBtn;
/// 删除按钮点击事件
@property (nonatomic, copy) TapDeleteButtonBlcok tapDeleteButton;
/**
 *  初始化方法
 *
 *  @param frame Frame
 *  @param hide  是否隐藏键盘的按钮
 *
 *  @return return value description
 */
- (id)initWithFrame:(CGRect)frame hideKeyBoard:(BOOL)hide;

@end
