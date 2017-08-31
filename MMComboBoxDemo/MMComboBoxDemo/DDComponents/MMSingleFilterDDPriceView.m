//
//  MMSingleFilterNumberRangeView.m
//  MMComboBoxDemo
//
//  Created by linkunzhu on 2017/8/31.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "MMSingleFilterDDPriceView.h"
#import "DDPriceFilterFooterView.h"
#import "UIView+YTEmptyView.h"

static const CGFloat MMPopupViewDDPriceFooterHeight = 112;

@interface MMSingleFilterDDPriceView() <BuyerTableFooterViewDelegate>

@property (nonatomic, strong) MMSingleItem *item;

@end

@implementation MMSingleFilterDDPriceView

- (id)initMMSingleFilterDDPriceViewWithItem:(MMItem *)item{
    item.selectedType = MMPopupViewSingleSelection;
    if (self = [super initWithItem:item]) {
        self.item = (MMSingleItem *)item;
    }
    return self;
}

#pragma mark - 重写
- (void)popupViewFromSourceFrame:(CGRect)frame completion:(void (^)(void))completion{
    self.popupViewHeight = MMPopupViewDDPriceFooterHeight + [self.item.childrenNodes count] * PopupViewRowHeight;
    [super popupViewFromSourceFrame:frame completion:completion];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return MMPopupViewDDPriceFooterHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    DDPriceFilterFooterView *view = [[DDPriceFilterFooterView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.width, MMPopupViewDDPriceFooterHeight)];
    view.aDelegate = self;
    return view;
}

#pragma mark - BuyerTableFooterViewDelegate

- (void)sureButtonClickedMinTextString:(NSString *)minTextString maxTextString:(NSString *)maxTextString{
    [self.mainTableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismiss];
    });
    
    NSDictionary *dic = @{DDFilterMaxHousePriceKey:@([maxTextString integerValue]),
                          DDFilterMinHousePriceKey:@([minTextString integerValue])};
    [[NSNotificationCenter defaultCenter] postNotificationName:MMPopupViewInputCustomPriceNotification object:dic];
}


@end
