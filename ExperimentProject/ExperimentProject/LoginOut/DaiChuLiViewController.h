//
//  DaiChuLiViewController.h
//  ExperimentProject
//
//  Created by YJM on 2016/11/18.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonWithRedPoint.h"
@interface DaiChuLiViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UIView *bgViewOfBtn;
@property (weak, nonatomic) IBOutlet ButtonWithRedPoint *shenQingBtn;
@property (weak, nonatomic) IBOutlet ButtonWithRedPoint *huiBaoBtn;
@property (weak, nonatomic) IBOutlet ButtonWithRedPoint *zhiShiBtn;
@property (weak, nonatomic) IBOutlet ButtonWithRedPoint *qiTaBtn;
- (IBAction)topBtnClick:(ButtonWithRedPoint *)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView;


@end
