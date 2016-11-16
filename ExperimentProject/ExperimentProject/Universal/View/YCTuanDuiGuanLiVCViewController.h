//
//  YCTuanDuiGuanLiVCViewController.h
//  ExperimentProject
//
//  Created by YJM on 2016/11/15.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCTuanDuiGuanLiVCViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *bgTabView;


@property (strong, nonatomic) IBOutlet UIView *zheZhaoView;

@property (strong, nonatomic) IBOutlet UIView *addPersonView;
- (IBAction)bottomCloseBtn:(UIButton *)sender;


@end
