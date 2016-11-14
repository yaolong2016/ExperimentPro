//
//  YCLogin.h
//  ExperimentProject
//
//  Created by YJM on 2016/11/11.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCLogin : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *souJiTextField;
@property (strong, nonatomic) IBOutlet UITextField *miMaTextField;

@property (strong, nonatomic) IBOutlet UIButton *zhongHeBtn;
@property (strong, nonatomic) IBOutlet UIButton *guanLiBtn;
@property (strong, nonatomic) IBOutlet UIButton *keYanBtn;

@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *zuCheBtn;
@property (strong, nonatomic) IBOutlet UIButton *wangJiMiMabtn;

- (IBAction)banKuaiValueChanged:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewCenter;
- (IBAction)dengLuBtnClick:(UIButton *)sender;
- (IBAction)zhuCeBtnClick:(UIButton *)sender;
- (IBAction)wangJiMiMaBtnClick:(UIButton *)sender;
@end
