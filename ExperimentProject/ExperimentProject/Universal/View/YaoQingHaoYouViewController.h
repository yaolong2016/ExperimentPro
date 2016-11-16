//
//  YaoQingHaoYouViewController.h
//  ExperimentProject
//
//  Created by YJM on 2016/11/16.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YaoQingHaoYouViewController : UIViewController
- (IBAction)duanXinBtnClick:(UIButton *)sender;
- (IBAction)qqBtnClick:(UIButton *)sender;
- (IBAction)weiXinBtnClick:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UIButton *duanXinBtn;
@property (strong, nonatomic) IBOutlet UIButton *qqBtn;
@property (strong, nonatomic) IBOutlet UIButton *weiXinBtn;

@end
