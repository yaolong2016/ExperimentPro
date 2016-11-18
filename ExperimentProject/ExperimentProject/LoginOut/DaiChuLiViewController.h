//
//  DaiChuLiViewController.h
//  ExperimentProject
//
//  Created by YJM on 2016/11/18.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaiChuLiViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UIView *bgViewOfBtn;
@property (weak, nonatomic) IBOutlet UIButton *shenQingBtn;
@property (weak, nonatomic) IBOutlet UIButton *huiBaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhiShiBtn;
@property (weak, nonatomic) IBOutlet UIButton *qiTaBtn;
- (IBAction)topBtnClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView;


@end
