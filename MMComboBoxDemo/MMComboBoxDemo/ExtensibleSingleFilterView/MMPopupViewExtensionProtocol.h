//
//  MMPopupViewExtensionProtocol.h
//  DongDong
//
//  Created by linkunzhu on 2017/9/15.
//  Copyright © 2017年 深圳市易图资讯股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 给MMComBoBoxView使用来向MMBasePopupView传递拓展数据的协议
 */
@protocol MMPopupViewExtensionDataSource <NSObject>

@optional
/**
 PopupView头部高度
 
 @return <#return value description#>
 */
- (CGFloat)popupViewHeaderHeight;

/**
 PopupView底部高度
 
 @return <#return value description#>
 */
- (CGFloat)popupViewFooterHeight;

/**
 PopupView头部视图
 
 @return <#return value description#>
 */
- (UIView *)popupViewHeaderView;

/**
 PopupView底部视图
 
 @return <#return value description#>
 */
- (UIView *)popupViewFooterView;

/**
 PopupView底部与屏幕底部的距离

 @return <#return value description#>
 */
- (CGFloat)popupViewBottomDistance;


@end

/**
 多选协议，提供确定选择按钮、取消选择按钮。不用实现这两个按钮的点击事件。
 */
@protocol MMPopupViewMultiSelectionProtocol <NSObject>

- (UIButton *)cancelButton;
- (UIButton *)sureButton;

@end

/**
 自定义值范围协议，提供最大值、最小值textField，确定完成编辑按钮
 */
@protocol MMPopupViewValueRangeProtocol <NSObject>

- (UIButton *)finishButton;
- (UITextField *)minValueTextField;
- (UITextField *)maxValueTextField;

@end
