//
//  ViewController.m
//  MMComboBoxDemo
//
//  Created by wyy on 2016/12/7.
//  Copyri2ght © 2016年 wyy. All rights reserved.
//

#import "ViewController.h"
#import "DDConfigViewController.h"
#import "MMComBoBox.h"
#import "UIView+YTEmptyView.h"

@interface ViewController () <MMComBoBoxViewDataSource, MMComBoBoxViewDelegate>
@property (nonatomic, strong) NSArray *mutableArray;
@property (nonatomic, strong) MMComBoBoxView *comBoBoxView;
@property (nonatomic, strong) UIButton *nextPageBtn;
@property (nonatomic, strong) UIButton *dongdongConfigBtn;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//===============================================Init===============================================
    self.comBoBoxView = [[MMComBoBoxView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 40)];
    self.comBoBoxView.dataSource = self;
    self.comBoBoxView.delegate = self;
    [self.view addSubview:self.comBoBoxView];
    [self.comBoBoxView reload];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.dongdongConfigBtn];
    if (self.isMultiSelection == NO)
       [self.view addSubview:self.nextPageBtn];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.comBoBoxView dimissPopView];
}

#pragma mark - MMComBoBoxViewDataSource
- (NSUInteger)numberOfColumnsIncomBoBoxView :(MMComBoBoxView *)comBoBoxView {
    return self.mutableArray.count;
}

- (MMItem *)comBoBoxView:(MMComBoBoxView *)comBoBoxView infomationForColumn:(NSUInteger)column {
    return self.mutableArray[column];
}

#pragma mark - MMComBoBoxViewDelegate
- (void)comBoBoxView:(MMComBoBoxView *)comBoBoxViewd didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index {
    MMItem *rootItem = self.mutableArray[index];
    switch (rootItem.displayType) {
        case MMPopupViewDisplayTypeNormal:
        case MMPopupViewDisplayTypeMultilayer:{
            //拼接选择项
            NSMutableString *title = [NSMutableString string];
            __block NSInteger firstPath;
            [array enumerateObjectsUsingBlock:^(MMSelectedPath * path, NSUInteger idx, BOOL * _Nonnull stop) {
                [title appendString:idx?[NSString stringWithFormat:@";%@",[rootItem findTitleBySelectedPath:path]]:[rootItem findTitleBySelectedPath:path]];
                if (idx == 0) {
                firstPath = path.firstPath;
              }
            }];
            NSLog(@"当title为%@时，所选字段为 %@",rootItem.title ,title);
            break;}
        case MMPopupViewDisplayTypeFilters:{
           MMCombinationItem * combineItem = (MMCombinationItem *)rootItem;
            [array enumerateObjectsUsingBlock:^(NSMutableArray*  _Nonnull subArray, NSUInteger idx, BOOL * _Nonnull stop) {
                if (combineItem.isHasSwitch && idx == 0) {
                    for (MMSelectedPath *path in subArray) {
                     MMAlternativeItem *alternativeItem = combineItem.alternativeArray[path.firstPath];
                      NSLog(@"当title为: %@ 时，选中状态为: %d",alternativeItem.title,alternativeItem.isSelected);
                    }
                    return;
                }
                
                NSString *title;
                NSMutableString *subtitles = [NSMutableString string];
                for (MMSelectedPath *path in subArray) {
                    MMItem *firstItem = combineItem.childrenNodes[path.firstPath];
                    MMItem *secondItem = combineItem.childrenNodes[path.firstPath].childrenNodes[path.secondPath];
                    title = firstItem.title;
                    [subtitles appendString:[NSString stringWithFormat:@"  %@",secondItem.title]];
                }
                  NSLog(@"当title为%@时，所选字段为 %@",title,subtitles);
            }];

            break;}
        default:
            break;
    }
}

#pragma mark - Getter
- (NSArray *)mutableArray {
    if (_mutableArray == nil) {
       NSMutableArray *mutableArray = [NSMutableArray array];
       //root 1
       MMSingleItem *rootItem1 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:nil];

       NSMutableString *title = [NSMutableString string];
      [rootItem1 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:@"全部" subtitleName:[NSString stringWithFormat:@"%ld",random()%10000] code:nil]];
        [title appendString:@"全部"];
       for (int i = 0; i < 20; i ++) {
           MMItem *subItem = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"蛋糕系列%d",i] subtitleName:[NSString stringWithFormat:@"%ld",random()%10000] code:nil];
           [rootItem1 addNode:subItem];
      }
      rootItem1.title = title;
        
      //root 2
      MMSingleItem *rootItem2 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"排序"];
        
      if (self.isMultiSelection)
          rootItem2.selectedType = MMPopupViewMultilSeMultiSelection;
        
      [rootItem2  addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:@"排序" subtitleName:nil code:nil]];
      [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"智能排序"]]];
      [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"离我最近"]]];
      [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"好评优先"]]];
      [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"人气最高"]]];
        
        
      //root 3
      MMMultiItem *rootItem3 = [MMMultiItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"附近"];
      
      rootItem3.displayType = MMPopupViewDisplayTypeMultilayer;
      for (int i = 0; i < 30; i++){
          MMItem *item3_A = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"市%d",i] subtitleName:nil];
          item3_A.isSelected = (i == 0);
            [rootItem3 addNode:item3_A];
            for (int j = 0; j < random()%30; j ++) {
             MMItem *item3_B = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"市%d县%d",i,j] subtitleName:[NSString stringWithFormat:@"%ld",random()%10000]];
                item3_B.isSelected = (i == 0 && j == 0);
                [item3_A addNode:item3_B];
            }
      }
        
     //root 4
        MMCombinationItem *rootItem4 = [MMCombinationItem itemWithItemType:MMPopupViewDisplayTypeUnselected isSelected:NO titleName:@"筛选" subtitleName:nil];
         rootItem4.displayType = MMPopupViewDisplayTypeFilters;
        
        if (self.isMultiSelection)
        rootItem4.selectedType = MMPopupViewMultilSeMultiSelection;
        // 只让指定的sections可以多选
        rootItem4.multiSelectionEnableSections = @[@"2",@"1"];

        MMAlternativeItem *alternativeItem1 = [MMAlternativeItem itemWithTitle:@"只看免预约" isSelected:NO];
        MMAlternativeItem *alternativeItem2 = [MMAlternativeItem itemWithTitle:@"节假日可用" isSelected:YES];
        [rootItem4 addAlternativeItem:alternativeItem1];
        [rootItem4 addAlternativeItem:alternativeItem2];
 
        NSArray *arr = @[@{@"用餐时段":@[@"不限",@"早餐",@"午餐",@"下午茶",@"晚餐",@"夜宵"]},
                         @{@"用餐人数":@[@"不限",@"单人餐",@"双人餐",@"3~4人餐",@"5~10人餐",@"10人以上",@"代金券",@"其他"]},
                         @{@"餐厅服务":@[@"不限",@"优惠买单",@"在线点餐",@"外卖送餐",@"预定",@"食客推荐",@"在线排队"]} ];
        
        for (NSDictionary *itemDic in arr) {
            MMItem *item4_A = [MMItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:[itemDic.allKeys lastObject]];
            [rootItem4 addNode:item4_A];
            for (int i = 0; i <  [[itemDic.allValues lastObject] count]; i++) {
                NSString *title = [itemDic.allValues lastObject][i];
                 MMItem *item4_B = [MMItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:title];
                if (i == 0) {
                    item4_B.isSelected = YES;
                }
                [item4_A addNode:item4_B];
            }
        }
        
        //root 5
        MMMultiItem *rootItem5 = [MMMultiItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"地区"];
        
        rootItem5.displayType = MMPopupViewDisplayTypeMultilayer;
        rootItem5.numberOflayers = MMPopupViewThreelayers;
        for (int i = 0; i < MAX(5, random()%30); i++){
            MMItem *item5_A = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"市%d",i] subtitleName:nil];
            item5_A.isSelected = (i == 0);
            [rootItem5 addNode:item5_A];
            
            for (int j = 0; j < MAX(5, random()%30) ; j ++) {
                MMItem *item5_B = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"市%d县%d",i,j] subtitleName:[NSString stringWithFormat:@"%ld",random()%10000]];
                item5_B.isSelected = (i == 0 && j == 0);
                [item5_A addNode:item5_B];
                
                for (int k = 0; k < MAX(5, random()%30); k++) {
                    MMItem *item5_C = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"市%d县%d镇%d",i,j,k] subtitleName:[NSString stringWithFormat:@"%ld",random()%10000]];
                    item5_C.isSelected = (i == 0 && j == 0 && k == 0);
                    [item5_B addNode:item5_C];
                }
            }
        }
        
        
//      [mutableArray addObject:rootItem1];
      [mutableArray addObject:rootItem2];
      [mutableArray addObject:rootItem3];
      [mutableArray addObject:rootItem4];
      [mutableArray addObject:rootItem5];
      _mutableArray  = [mutableArray copy];
    }
    return _mutableArray;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.comBoBoxView.bottom, self.view.width, self.view.height - 64)];
        _imageView.image = [UIImage imageNamed:@"7.jpg"];
    }
    return _imageView;
}

- (UIButton *)nextPageBtn {
    if (_nextPageBtn == nil) {
        _nextPageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextPageBtn.frame = CGRectMake(self.view.width - 80, kScreenHeigth - 60, 100, 30);
        [_nextPageBtn setTitle:@"多选" forState:UIControlStateNormal];
        [_nextPageBtn addTarget:self action:@selector(respondsToButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _nextPageBtn;
}
- (UIButton *)dongdongConfigBtn{
    if (_dongdongConfigBtn == nil) {
        _dongdongConfigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dongdongConfigBtn.frame = CGRectMake(self.view.width - 120, kScreenHeigth - 200, 120, 30);
        [_dongdongConfigBtn setTitle:@"咚咚配置" forState:UIControlStateNormal];
        [_dongdongConfigBtn addTarget:self action:@selector(toDDConfigPage:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _dongdongConfigBtn;
}

#pragma mark - Action
- (void)respondsToButtonAction:(UIButton *)sender {
    ViewController *vc = [[ViewController alloc] init];
    vc.isMultiSelection = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toDDConfigPage:(UIButton *)sender {
    DDConfigViewController *vc = [[DDConfigViewController alloc] init];
    vc.isMultiSelection = NO;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
