//
//  LocalFileSystem.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/14.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "LocalFileSystem.h"
#import "ToolFuncation.h"

@interface LocalFileSystem ()

@end

@implementation LocalFileSystem

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:NSLocalizedString(@"选择文件", nil)];
    
    UIButton* backIn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, self.navigationController.navigationBar.frame.size.height)];
    
    [backIn setTitle:NSLocalizedString(@"返回", nil) forState:UIControlStateNormal];
    [backIn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [backIn setImage:[UIImage imageNamed:@"yl_back"] forState:UIControlStateNormal];
    [backIn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [backIn setBackgroundColor:[UIColor redColor]];
    
    UIBarButtonItem* backOut = [[UIBarButtonItem alloc] initWithCustomView:backIn];
    [self.navigationItem setLeftBarButtonItem:backOut];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
