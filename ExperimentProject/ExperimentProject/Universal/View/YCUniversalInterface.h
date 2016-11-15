//
//  YCUniversalInterface.h
//  ExperimentProject
//
//  Created by yaolong on 16/11/11.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

///整合版本入口
@interface YCUniversalInterface : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *bgTabView;

@property (strong, nonatomic) IBOutlet UIView *headerView;

- (IBAction)sheJiShiYanBtnClick:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIView *topBgView;
@property (strong, nonatomic) IBOutlet UIView *bottomBgView;

@property (strong, nonatomic) IBOutlet UIImageView *topBgImageView;

- (IBAction)shenQingBtnClick:(UIButton *)sender;
- (IBAction)cuanJianBtnClick:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIButton *guanLiBtn;
@property (strong, nonatomic) IBOutlet UIButton *shiYanBtn;
- (IBAction)gaunLiBtnClick:(UIButton *)sender;

- (IBAction)shiYanBtnClick:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIView *btnBottomView;



@property (strong, nonatomic) IBOutlet UIScrollView *jiuGongGeScrollView;


@property (strong, nonatomic) IBOutlet UIButton *sheJiShiYanButton;


@end
