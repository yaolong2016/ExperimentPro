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
@property (nonatomic, weak) id<BATableViewDelegate> delegate;
- (void)reloadData;
- (void)hideFlotage;
//添加的
- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
-(void)beginUpdates;
-(void)endUpdates;
@end

@protocol BATableViewDelegate <UITableViewDataSource,UITableViewDelegate>

- (NSArray *)sectionIndexTitlesForABELTableView:(BATableView *)tableView;
- (NSString *)titleString:(NSInteger)section;


@end