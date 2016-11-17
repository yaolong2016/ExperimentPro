//
//  ABELTableView.h
//  ABELTableViewDemo
//
//  Created by abel on 14-4-28.
//  Copyright (c) 2014年 abel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullToRefreshTableView.h"

@protocol BATableViewDelegate;
@class PullToRefreshTableView;
///搜索＋索引＋刷新
@interface BATableView : UIView


@property (nonatomic, strong) PullToRefreshTableView * tableView;
@property (nonatomic, weak) IBOutlet id<BATableViewDelegate> delegate;
@property (nonatomic, assign) UIColor * setSeparatorColor;

- (void)reloadData;
- (void)hideFlotage;
//添加的
- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
-(void)beginUpdates;
-(void)endUpdates;
///设置列表的头和尾 放在viewdidload里面
- (void) setTableViewHeaderViewAndFooterView:(BOOL) heads footerView:(BOOL) Fview;


@end

@protocol BATableViewDelegate <UITableViewDataSource,UITableViewDelegate>

///如果不实现这个函数就不会展示右边的搜索索引
- (NSArray *)sectionIndexTitlesForABELTableView:(BATableView *)tableView;
///如果不实现这个函数就不会展示右边的搜索索引
- (NSString *)titleString:(NSInteger)section;


@end