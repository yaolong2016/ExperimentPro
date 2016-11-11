//
//  YCGuideViewController.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/11.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "YCGuideViewController.h"
#import "ToolFuncation.h"

@interface YCGuideViewController ()

@end

@implementation YCGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [ToolFuncation controlNavigationHideShow:YES controller:self];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [ToolFuncation controlNavigationHideShow:NO controller:self];
}

@end
