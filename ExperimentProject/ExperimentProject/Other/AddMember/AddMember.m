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

@interface AddMember ()

@property (nonatomic, strong) NSMutableArray* dataArray;
@property(nonatomic,strong)NSMutableArray *indexArray;
@property(nonatomic,strong)NSMutableArray *letterResultArr;
@property(nonatomic,strong)NSMutableArray *stateArray;

@end

@implementation AddMember
@synthesize tableView_m;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _dataArray =[NSMutableArray arrayWithObjects:
//      @"￥hhh, .$",@" ￥Chin ese ",
//      @"开源中国 ",
//      @"www.oschina.net",
//      @"开源技术",@"社区",@"开发者",@"传播",
//      @"2014",@"a1",@"100",@"中国",@"暑假作业",
//      @"键盘", @"鼠标",@"hello",@"world",@"b1",
//      nil];
    
    _dataArray = [NSMutableArray arrayWithObjects:@{@"index":@"A"},@{@"index":@"B"},@{@"index":@"AD"}, nil];
    
//    NSArray *sortedKeys = [_dataArray keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        if ([obj1 integerValue] > [obj2 integerValue]) {
//            return (NSComparisonResult)NSOrderedAscending;
//        }
//        if ([obj1 integerValue] < [obj2 integerValue]) {
//            return (NSComparisonResult)NSOrderedDescending;
//        }
//        return (NSComparisonResult)NSOrderedSame;
//    }];
    
    NSDictionary *dic = @{@"Cell": @"MainCell",@"isAttached":@(NO)};
    self.indexArray = [ChineseString IndexArray:self.dataArray];
    
    self.letterResultArr = [ChineseString LetterSortArray:_dataArray];
    
    self.stateArray = [[NSMutableArray alloc]init];
    for (int i = 0; i< self.indexArray.count ; i++) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (int j = 0; j< [[self.letterResultArr objectAtIndex:i] count] ; j++) {
            
            [array addObject:dic];
        }
        
        [self.stateArray addObject:array];
        
    }

    
    self.tableView_m = [[BATableView alloc] initWithFrame:CGRectMake(0, 0, [ToolFuncation screenSize].width, [ToolFuncation screenSize].height)];
    self.tableView_m.delegate = self;
    [self.view addSubview:self.tableView_m];
    
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

#pragma UITableView
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [self.indexArray objectAtIndex:section];
    return key;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.stateArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    NSLog(@"%ld",[[self.stateArray objectAtIndex:section] count]);
    return [[self.stateArray objectAtIndex:section] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.stateArray[indexPath.section][indexPath.row] objectForKey:@"Cell"] isEqualToString:@"MainCell"])
    {
        
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.textLabel.text = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        return cell;
        
    }
    
    else if ([[self.stateArray[indexPath.section][indexPath.row] objectForKey:@"Cell"] isEqualToString:@"AttachedCell"])
    {
        
        static NSString *CellIdentifier2 = @"AttachedCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
            //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.textLabel.text = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        
    }
    
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}


@end
