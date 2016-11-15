//
//  YCTuanDuiGuanLiVCViewController.m
//  ExperimentProject
//
//  Created by YJM on 2016/11/15.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "YCTuanDuiGuanLiVCViewController.h"

@interface YCTuanDuiGuanLiVCViewController ()

@end

@implementation YCTuanDuiGuanLiVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"团队管理", nil);
    
    UIBarButtonItem *addBarBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBarBtnClick)];
    self.navigationItem.rightBarButtonItem = addBarBtn;
    
    
}

- (void)addBarBtnClick{
    
}

- (void)setAddView{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
