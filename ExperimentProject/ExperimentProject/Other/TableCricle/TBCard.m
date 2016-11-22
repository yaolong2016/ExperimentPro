//
//  TBCard.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/18.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "TBCard.h"
#import "ToolFuncation.h"
#import "BATableView.h"

@interface TBCard ()<BATableViewDelegate>{

    BATableView* tableView_m;

}

@end

@implementation TBCard

- (void)viewDidLoad {
    [super viewDidLoad];
    // ／／  [self setAutomaticallyAdjustsScrollViewInsets:NO];
    _table = [[YCTopCardView alloc] initWithFrame:CGRectMake(0, 64, [ToolFuncation screenSize].width, 250)];
    [self.view addSubview:_table];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
