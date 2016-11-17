//
//  WanShanZiLiaoViewController.h
//  ExperimentProject
//
//  Created by YJM on 2016/11/16.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WanShanZiLiaoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *touXiangBtn;
- (IBAction)touXiangBtnClick:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextField *xingMingTextField;

@property (strong, nonatomic) IBOutlet UIButton *nanBtn;
- (IBAction)nanBtnClick:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIButton *nvBtn;
- (IBAction)nvBtnClick:(UIButton *)sender;

- (IBAction)zhiJieJinRuBtnClick:(UIButton *)sender;
- (IBAction)queDingBtnClick:(UIButton *)sender;
@end
