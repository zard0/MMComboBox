//
//  BuyerTableFooterView.h
//  DongDongBroker
//
//  Created by yitudev on 2017/8/9.
//  Copyright © 2017年 深圳市易图资讯股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YTTextField;

/// 价格&面积输入框 delegate
@protocol BuyerTableFooterViewDelegate <NSObject>

- (void)sureButtonClickedMinTextString:(NSString *)minTextString maxTextString:(NSString *)maxTextString;

@end

@interface DDPriceFilterFooterView : UIView

/// Delegate
@property (assign, nonatomic) id<BuyerTableFooterViewDelegate> aDelegate;

@end
