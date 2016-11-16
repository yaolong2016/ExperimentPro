//
//  AddMember.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/16.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "AddMember.h"
#import "ToolFuncation.h"

@interface AddMember ()

@end

@implementation AddMember
@synthesize tableView_m;

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    return  @"A";
}

#pragma UITableView
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* str = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
//        cell = [UITableViewCell ];
    }
    
    return cell;
}


@end
