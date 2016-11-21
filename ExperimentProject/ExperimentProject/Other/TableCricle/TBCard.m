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
    // Do any additional setup after loading the view from its nib.
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
//    _table = [[YCTopCardView alloc] initWithFrame:CGRectMake(0, 64, [ToolFuncation screenSize].width, 250)];
//    [self.view addSubview:_table];
    
    self->tableView_m = [[BATableView alloc] initWithFrame:CGRectMake(0, 64, [ToolFuncation screenSize].width, [ToolFuncation screenSize].height)];
    self->tableView_m.delegate = self;
    [self->tableView_m setTableViewHeaderViewAndFooterView:YES footerView:NO];
    [self->tableView_m.tableView initHeaderAndFooter:CGSizeMake(self->tableView_m.frame.size.width, self->tableView_m.frame.size.height)];
    [self->tableView_m.tableView tableViewDidDragging];
    [self.view addSubview:self->tableView_m];

    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* tablesss = @"st";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:tablesss];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tablesss];
    }
    return cell;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
