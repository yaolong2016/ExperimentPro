//
//  AddMember.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/16.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "AddMember.h"
#import "ToolFuncation.h"
#import "ChineseString.h"
#import "MemberCell.h"
#import "PullToRefreshTableView.h"

@interface AddMember ()

///展示数据源
@property (nonatomic, strong) NSMutableArray *dataArray;

///保存当前数据所拥有的首字母
@property (nonatomic, strong) NSMutableArray *indexArray;

///经过处理后拥有排序的数据源(实际的展示数据源)
@property (nonatomic, strong) NSMutableArray *letterResultArr;

///保存我们的实际展示的视图数据
@property (nonatomic, strong) NSMutableArray *saveViewCellArr;

@end

@implementation AddMember
@synthesize tableView_m;
@synthesize bottonView_m;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    _dataArray =[NSMutableArray arrayWithObjects:
      @"￥hhh, .$",@" ￥Chin ese ",
      @"开源中国 ",
      @"www.oschina.net",
      @"开源技术",@"社区",@"开发者",@"传播",
      @"2014",@"a1",@"100",@"中国",@"暑假作业",
      @"键盘", @"鼠标",@"hello",@"world",@"b1",
      nil];
    
    self.indexArray = [ChineseString IndexArray:self.dataArray];
    
    self.letterResultArr = [ChineseString LetterSortArray:_dataArray];

    self.saveViewCellArr = [[NSMutableArray alloc] init];
    
    [self.tableView_m setTableViewHeaderViewAndFooterView:YES footerView:YES];
    [self.tableView_m setSetSeparatorColor:[UIColor clearColor]];
    self.tableView_m.frame = CGRectMake(self.tableView_m.frame.origin.x,
                                        self.tableView_m.frame.origin.y,
                                        self.view.frame.size.width,
                                        self.view.frame.size.height-self.bottonView_m.frame.size.height);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSArray *) sectionIndexTitlesForABELTableView:(BATableView *)tableView {
    return @[
             @"A",@"B",@"C",@"D",@"E",
             @"F",@"G",@"H",@"I",@"J",
             @"K",@"L",@"M",@"N",@"O",
             @"P",@"Q",@"R",@"S",@"T",
             @"U",@"V",@"W",@"X",@"Y",
             @"Z", @"#"
             ];
}

- (NSString *)titleString:(NSInteger)section
{
    return  [self.indexArray objectAtIndex:section];
}

#pragma PTableView
- (void)updateThread:(NSString *)returnKey{
    sleep(2);
    [self performSelectorOnMainThread:@selector(updateTableView) withObject:nil waitUntilDone:NO];
    
}

- (void)updateTableView{
    NSInteger much = 0;
    NSInteger dataMax = 0;
    if (much < dataMax) {
        //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [self.tableView_m.tableView reloadData:NO];
    } else {
        //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [self.tableView_m.tableView reloadData:YES];
    }
}

#pragma mark -
#pragma mark Scroll View Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView_m.tableView tableViewDidDragging];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSInteger returnKey = [self.tableView_m.tableView tableViewDidEndDragging];
    
    //  returnKey用来判断执行的拖动是下拉还是上拖，如果数据正在加载，则返回DO_NOTHING
    if (returnKey != k_RETURN_DO_NOTHING) {
        NSString * key = [NSString stringWithFormat:@"%ld", (long)returnKey];
        [NSThread detachNewThreadSelector:@selector(updateThread:) toTarget:self withObject:key];
    }
}

#pragma UITableView
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [self.indexArray objectAtIndex:section];
    return key;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.letterResultArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.letterResultArr objectAtIndex:section] count];
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = NO;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = cell.contentView.frame.size;
    if ((self.saveViewCellArr.count <= indexPath.section)) {
        
        MemberCell* newCell = [[[NSBundle mainBundle] loadNibNamed:@"MemberCell" owner:self options:nil] objectAtIndex:0];
        [newCell setFrame:CGRectMake(0, 0, size.width, size.height)];
        NSMutableArray* newArr = [[NSMutableArray alloc] initWithObjects:newCell, nil];
        [self.saveViewCellArr addObject:newArr];
        
        [cell.contentView addSubview:newCell];
    } else if ((([[self.letterResultArr objectAtIndex:indexPath.section] count] >= [[self.saveViewCellArr objectAtIndex:indexPath.section] count]))) {
        
        MemberCell* newCell = [[[NSBundle mainBundle] loadNibNamed:@"MemberCell" owner:self options:nil] objectAtIndex:0];
        [newCell setFrame:CGRectMake(0, 0, size.width, size.height)];
        if ([[self.saveViewCellArr objectAtIndex:indexPath.section] count]==0) {
            
            NSMutableArray* newArr = [[NSMutableArray alloc] initWithObjects:newCell, nil];
            [self.saveViewCellArr addObject:newArr];
            
        } else {
            
            NSMutableArray* oldArr = [self.saveViewCellArr objectAtIndex:indexPath.section];
            [oldArr addObject:newCell];
            
        }
        [cell.contentView addSubview:newCell];
    } else {
        
        NSMutableArray* oldArr = [self.saveViewCellArr objectAtIndex:indexPath.section];
        MemberCell* oldCell = [oldArr objectAtIndex:indexPath.row];
        [cell.contentView addSubview:oldCell];
        
    }
}

- (void) tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    for (UIView* object in cell.contentView.subviews) {
        [object removeFromSuperview];
    }
}


@end
