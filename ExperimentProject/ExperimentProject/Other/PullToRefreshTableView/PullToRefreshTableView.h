//
//  PullToRefreshTableView.h
//  
//  Version 1.0
//
//  下拉刷新 及 上拖加载 表视图
//  使用本类，您无需去关注StateView中的方法，只要调用PullToRefreshTableView中以下三种方法即可
// 
//  - (void)tableViewDidDragging;
//  - (int)tableViewDidEndDragging;
//  - (void)reloadData:(BOOL)dataIsAllLoaded;
//
//  本类未对DataSource及Delegate进行任何处理，您可自定义您的数据源及委托
//  Created by Chyo on 12-1-30.
//  Copyright (c) 2012年 QQ:115940737. All rights reserved.
//

/*使用的时候直接将这几个方法复制到tableview的界面里面*/
/*
 需要调用这个函数来设置头尾:
 [self.tableView_m initHeaderAndFooter:[ToolFuncation screenSize]];
 第一次加载：
 [NSThread detachNewThreadSelector:@selector(updateThread:) toTarget:self withObject:[NSString stringWithFormat:@"%d",k_RETURN_REFRESH]];
 */
/*
 
 #pragma PTableView
 - (void)updateThread:(NSString *)returnKey{
 sleep(2);
 [self performSelectorOnMainThread:@selector(updateTableView) withObject:nil waitUntilDone:NO];
 
 }
 
 - (void)updateTableView{
 NSInteger much = 0;
 NSInteger dataMax = 0;
// if (self.selectedList == Type_Document) {
// much = self.saveDocumentArray.count;
// dataMax = 5;
// } else if (self.selectedList == Type_Picture) {
// much = self.saveImgArray.count;
// dataMax = 21;
// } else if (self.selectedList == Type_Other) {
// much = self.saveOtherArray.count;
// dataMax = 5;
// }
 if (much < dataMax) {
 //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
 [self.tableView_m reloadData:NO];
 } else {
 //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
 [self.tableView_m reloadData:YES];
 }
 }
 
 #pragma mark -
 #pragma mark Scroll View Delegate
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView{
 [self.tableView_m tableViewDidDragging];
 }
 
 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
 NSInteger returnKey = [self.tableView_m tableViewDidEndDragging];
 
 //  returnKey用来判断执行的拖动是下拉还是上拖，如果数据正在加载，则返回DO_NOTHING
 if (returnKey != k_RETURN_DO_NOTHING) {
 NSString * key = [NSString stringWithFormat:@"%ld", (long)returnKey];
 [NSThread detachNewThreadSelector:@selector(updateThread:) toTarget:self withObject:key];
 }
 }
 
 -(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 NSInteger much = 0;

 
 if (much == 0) {
 //  本方法是为了在数据未空时，让“下拉刷新”视图可直接显示，比较直观
 self.tableView_m.contentInset = UIEdgeInsetsMake(k_STATE_VIEW_HEIGHT, 0, 0, 0);
 }
 return 5;
 }
 
 */

#import <UIKit/UIKit.h>

#define k_PULL_STATE_NORMAL         0     //  状态标识：下拉可以刷新/上拖加载更多
#define k_PULL_STATE_DOWN           1     //  状态标识：释放可以刷新
#define k_PULL_STATE_LOAD           2     //  状态标识：正在加载
#define k_PULL_STATE_UP             3     //  状态标识：释放加载更多
#define k_PULL_STATE_END            4     //  状态标识：已加载全部数据

#define k_RETURN_DO_NOTHING         0     //  返回值：不执行
#define k_RETURN_REFRESH            1     //  返回值：下拉刷新
#define k_RETURN_LOADMORE           2     //  返回值：加载更多

#define k_VIEW_TYPE_HEADER          0     //  视图标识：下拉刷新视图
#define k_VIEW_TYPE_FOOTER          1     //  视图标识：上拖加载视图

#define k_STATE_VIEW_HEIGHT         40    //  视图窗体：视图高度
#define k_STATE_VIEW_INDICATE_WIDTH 60    //  视图窗体：视图箭头指示器宽度

/**
 *
 *  下拉/上拖 状态视图
 *  本接口作为内部接口使用，使用本类，您无需关注本接口，只要调用PullToRefreshTableView中以下三种方法即可
 *
 **/
@interface StateView : UIView {
@private
    UIActivityIndicatorView * indicatorView;  //  加载指示器（菊花圈）
    UIImageView             * arrowView;      //  箭头视图
    UILabel                 * stateLabel;     //  状态文本
    UILabel                 * timeLabel;      //  时间文本 
    int                       viewType;       //  标识是下拉还是上拖视图
    int                       currentState;   //  标识视图当前状态
}

@property (nonatomic, retain) UIActivityIndicatorView * indicatorView;
@property (nonatomic, retain) UIImageView             * arrowView;
@property (nonatomic, retain) UILabel                 * stateLabel;
@property (nonatomic, retain) UILabel                 * timeLabel;
@property (nonatomic)         int                       viewType; 
@property (nonatomic)         int                       currentState; 

/** 
 *  初始化视图 
 *  type : 下拉/上拖视图标识  k_VIEW_TYPE_HEADER 或 k_VIEW_TYPE_FOOTER
 **/
- (id)initWithFrame:(CGRect)frame viewType:(int)type;

/**
 *  改变视图状态
 *  state : 视图状态 k_PULL_STATE_XXX
 **/
- (void)changeState:(int)state;

/**
 *  更新时间文本（当前时间）
 **/ 
- (void)updateTimeLabel;

@end

/**
 *
 *  下拉刷新/上拖加载 表视图
 *  使用本类，您只要调用以下三种方法即可
 *  没有右边的索引搜索
 **/
///刷新没有搜索索引
@interface PullToRefreshTableView : UITableView{
    StateView * headerView;  //  下拉刷新视图
    StateView * footerView;  //  上拖加载视图
}

///移除头试图
- (void) removeCurrentHeaderView;

///移除尾试图
- (void) removeCurrentFooterView;


/**
 *  当表视图拖动时的执行方法
 *  使用方法：设置表视图的delegate，实现- (void)scrollViewDidScroll:(UIScrollView *)scrollView方法，在垓方法中直接调用本方法
 **/
- (void)tableViewDidDragging;

/**
 *  当表视图结束拖动时的执行方法
 *  使用方法：设置表视图的delegate，实现- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate方法，在垓方法中直接调用本方法
 **/
- (int)tableViewDidEndDragging;

/**
 *  刷新表视图数据
 *  dataIsAllLoaded 标识数据是否已全部加载（即“上拖加载更多”是否可用）
 **/
- (void)reloadData:(BOOL)dataIsAllLoaded;

///**
// 重置头和顶的大小
// **/
//- (void) reSetHeadAndFooterSize:(CGSize) size;

///初始化头和尾
- (void) initHeaderAndFooter:(CGSize) size;

///改变头部提示文字
- (void) resetHeaderPrompt:(NSString*) txt;

///改变尾部提示文字
- (void) resetFooterPrompt:(NSString*) txt;

///获取头尾提示文本(yes:头部文本; no: 尾部)
- (NSString*) headerAndFooterText:(BOOL) mark;

- (void) setHeadAndFooter:(BOOL) headerViews footerView:(BOOL) fview;

@end