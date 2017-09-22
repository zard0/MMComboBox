//
//  MMBasePopupView.h
//  MMComboBoxDemo
//
//  Created by wyy on 2016/12/7.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMItem;
@protocol MMPopupViewDelegate;
@protocol MMPopupViewDataSource;

@interface MMBasePopupView : UIView 
//@property (nonatomic, strong) MMItem *item;
@property (nonatomic, assign) CGRect sourceFrame;                                       /* tapBar的frame**/
@property (nonatomic, strong) UIView *shadowView;                                       /* 遮罩层**/
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UITableView *subTableView;
@property (nonatomic, strong) NSMutableArray *selectedArray;                            /* 记录所选的item**/
@property (nonatomic, strong) NSArray *temporaryArray;                                  /* 暂存最初的状态**/


@property (nonatomic, weak) id<MMPopupViewDelegate> delegate;
@property (nonatomic, weak) id<MMPopupViewDataSource> dataSource;
+ (MMBasePopupView *)getSubPopupView:(MMItem *)item;
- (id)initWithItem:(MMItem *)item;

- (void)popupViewFromSourceFrame:(CGRect)frame completion:(void (^)(void))completion;
- (void)dismiss;
- (void)dismissWithOutAnimation;

@end

@protocol MMPopupViewDelegate <NSObject>
@optional
- (void)popupView:(MMBasePopupView *)popupView didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index;
@required
- (void)popupViewWillDismiss:(MMBasePopupView *)popupView;
@end


/**
 通过这个数据源协议，让调用方可以对PopupView做一些个性化定制
 */
@protocol MMPopupViewDataSource <NSObject>

/**
 头部高度

 @param view <#view description#>
 @return <#return value description#>
 */
- (CGFloat)headerHeightForPopupView:(MMBasePopupView *)view;

/**
 底部高度

 @param view <#view description#>
 @return <#return value description#>
 */
- (CGFloat)footerHeightForPopupView:(MMBasePopupView *)view;

/**
 头部视图

 @param view <#view description#>
 @return <#return value description#>
 */
- (UIView *)headerViewForPopupView:(MMBasePopupView *)view;

/**
 底部视图

 @param view <#view description#>
 @return <#return value description#>
 */
- (UIView *)footerViewForPopupView:(MMBasePopupView *)view;

/**
 PopupView底部距离屏幕底部的高度

 @param view <#view description#>
 @return <#return value description#>
 */
- (CGFloat)bottomDistanceForPopupView:(MMBasePopupView *)view;

@end














