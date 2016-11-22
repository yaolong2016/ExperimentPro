//
//  DaiChuLiXiangQingViewController.m
//  ExperimentProject
//
//  Created by YJM on 2016/11/21.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "DaiChuLiXiangQingViewController.h"
#import "BATableView.h"
#import "DefineTool.h"
#import "ToolFuncation.h"
#import "DaiChuLiViewModel.h"

@interface DaiChuLiXiangQingViewController ()<BATableViewDelegate>
{
    BATableView *bgTableView;
}
@end

@implementation DaiChuLiXiangQingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    bgTableView = [[BATableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREENH_HEIGHT - 64)];
    [bgTableView setTableViewHeaderViewAndFooterView:NO footerView:NO];
    [bgTableView.tableView initHeaderAndFooter:[ToolFuncation screenSize]];
    bgTableView.delegate = self;
    [self.view addSubview:bgTableView];
    
    
    
    [NSThread detachNewThreadSelector:@selector(updateThread:) toTarget:self withObject:[NSString stringWithFormat:@"%d",k_RETURN_REFRESH]];
    
    
//    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 468)];
//    bgView.backgroundColor = ColorWithRGB(0xEFF6F9);
//    bgTableView.tableView.tableHeaderView = bgView;
//
//    DaiChuLiViewModel *daiChuLiViewModel = [DaiChuLiViewModel instanceDaiChuLiViewModel];
//    daiChuLiViewModel.frame = CGRectMake(5, 5, SCREEN_WIDTH - 10, 468);
//    
//    daiChuLiViewModel.viewType =(NSInteger) self.viewType;
//    
//    [bgView addSubview:daiChuLiViewModel];
    
    [self setHeaderViewWith:(NSInteger )self.viewType];

}

- (void)setHeaderViewWith:(NSInteger )viewType{
    CGFloat headerHeight = 0.0;
    switch (viewType) {
        case 0:
        {
            headerHeight = 468;
        }
            break;
        case 1:case 2:
        {
            headerHeight = 468 - 40;
        }
            break;
        case 3:
        {
            headerHeight = 210 ;;
        }
            break;
        default:
            break;
    }
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerHeight)];
    
    bgView.backgroundColor = ColorWithRGB(0xEFF6F9);
    bgTableView.tableView.tableHeaderView = bgView;
    
    DaiChuLiViewModel *daiChuLiViewModel = [DaiChuLiViewModel instanceDaiChuLiViewModel];
    daiChuLiViewModel.frame = CGRectMake(5, 5, SCREEN_WIDTH - 10, headerHeight - 10);
    
    daiChuLiViewModel.viewType =(NSInteger) self.viewType;
    
    [bgView addSubview:daiChuLiViewModel];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* STR = @"Cell";
    UITableViewCell* CELL = [tableView dequeueReusableCellWithIdentifier:STR];
    if (CELL == nil) {
        CELL = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:STR];
    }
    
    
    return CELL;
}


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
 [bgTableView.tableView reloadData:NO];
 } else {
 //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
 [bgTableView.tableView reloadData:YES];
 }
 }

 #pragma mark Scroll View Delegate
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView{
 [bgTableView.tableView tableViewDidDragging];
 }
 
 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
 NSInteger returnKey = [bgTableView.tableView tableViewDidEndDragging];
 
 //  returnKey用来判断执行的拖动是下拉还是上拖，如果数据正在加载，则返回DO_NOTHING
 if (returnKey != k_RETURN_DO_NOTHING) {
 NSString * key = [NSString stringWithFormat:@"%ld", (long)returnKey];
 [NSThread detachNewThreadSelector:@selector(updateThread:) toTarget:self withObject:key];
 }
 }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
