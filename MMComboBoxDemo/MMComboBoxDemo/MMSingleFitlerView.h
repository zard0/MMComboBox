//
//  MMSingleFitlerView.h
//  MMComboBoxDemo
//
//  Created by wyy on 2016/12/8.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import "MMBasePopupView.h"

@interface MMSingleFitlerView : MMBasePopupView <UITableViewDelegate, UITableViewDataSource>
/// lkz：子类有特殊需求，在调用- (void)popupViewFromSourceFrame:(CGRect)frame completion:(void (^)(void))completion方法之前，通过设置这个属性定制popupView的高度；否则用默认算法。
@property (nonatomic, assign) CGFloat popupViewHeight;

@end
