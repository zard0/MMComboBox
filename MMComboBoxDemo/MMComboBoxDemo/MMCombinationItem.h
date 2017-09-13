//
//  MMCombinationItem.h
//  MMComboBoxDemo
//
//  Created by wyy on 17/4/9.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "MMItem.h"
#import "MMAlternativeItem.h"
@interface MMCombinationItem : MMItem

@property (nonatomic, assign) BOOL isHasSwitch;                         //是否有Switch类型
@property (nonatomic, strong) NSMutableArray <MMAlternativeItem *>*alternativeArray;         //当有这种的类型则一定为MMPopupViewDisplayTypeFilters类型
/// lkz: 只有当self.selectedType为MMPopupViewMultilSeMultiSelection，这个属性才有效。
/// 如果这个属性有值，就依照里面的值确定哪些sections允许多选，否则所有sections都可以多选。
/// 存放的是封装了NSInteger的对象
@property (nonatomic, strong) NSArray *multiSelectionEnableSections;

- (void)addLayoutInformationWhenTypeFilters;
- (void)addAlternativeItem:(MMAlternativeItem *)item;


@end
