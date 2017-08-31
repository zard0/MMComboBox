//
//  MMSingleFitlerSearchHistoryView.m
//  MMComboBoxDemo
//
//  Created by linkunzhu on 2017/8/30.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "MMSingleFitlerSearchHistoryView.h"
#import "MMSingleItem.h"
#import "UIView+YTEmptyView.h"

// 头部高度
static const CGFloat PopupViewHeaderHeight = 40.0f;
// 头部内容边距
static const CGFloat PopupViewHeaderHorizonalMargin = 16.0f;

@interface MMSingleFitlerSearchHistoryView()

@property (nonatomic, strong) MMSingleItem *item;

@end

@implementation MMSingleFitlerSearchHistoryView

- (id)initMMSingleFitlerSearchHistoryViewWithItem:(MMItem *)item{
    item.selectedType = MMPopupViewSingleSelection;
    if (self = [super initWithItem:item]) {
        self.item = (MMSingleItem *)item;
    }
    return self;
}

- (UIView *)headerView{
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor yellowColor];
    UIImage *image = [UIImage imageNamed:@"list_selected"];
    UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
    imageV.frame = CGRectMake(PopupViewHeaderHorizonalMargin, (PopupViewHeaderHeight - image.size.height)/2, image.size.width, image.size.height);
    [headerView addSubview:imageV];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"清除历史记录";
    [label sizeToFit];
    label.frame = CGRectMake(imageV.right + 10, (PopupViewHeaderHeight - label.height)/2, label.width, label.height);
    [headerView addSubview:label];
    
    UIImage *image2 = [UIImage imageNamed:@"list_selected"];
    UIImageView *imageV2 = [[UIImageView alloc] initWithImage:image2];
    imageV2.frame = CGRectMake(self.width - PopupViewHeaderHorizonalMargin - image2.size.width, (PopupViewHeaderHeight - image2.size.height)/2, image2.size.width, image2.size.height);
    imageV2.userInteractionEnabled = YES;
    [self addSubview:imageV2];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearHistory)];
    [imageV2 addGestureRecognizer:tap];

    return headerView;
}

- (void)clearHistory{
    self.item.childrenNodes = nil;
    [self.mainTableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismiss];
    });
    [[NSNotificationCenter defaultCenter] postNotificationName:MMPopupViewClearSearchHistoryNotification object:nil];
}

#pragma mark - 重写
- (void)popupViewFromSourceFrame:(CGRect)frame completion:(void (^)(void))completion{
    self.popupViewHeight = PopupViewHeaderHeight + [self.item.childrenNodes count] * PopupViewRowHeight;
    [super popupViewFromSourceFrame:frame completion:completion];
}

#pragma mark - UITableViewDataSource

/**
 定制header高度
 
 @param tableView <#tableView description#>
 @param section <#section description#>
 @return <#return value description#>
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return PopupViewHeaderHeight;
}


/**
 定制headerView
 
 @param tableView <#tableView description#>
 @param section <#section description#>
 @return <#return value description#>
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self headerView];
}


@end
