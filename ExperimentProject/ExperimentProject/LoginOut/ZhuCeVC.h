//
//  ZhuCeVC.h
//  ExperimentProject
//
//  Created by YJM on 2016/11/14.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhuCeVC : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *souJiTextField;
@property (strong, nonatomic) IBOutlet UITextField *yanZhenCode;
@property (strong, nonatomic) IBOutlet UIButton *yanZhenBtn;
@property (strong, nonatomic) IBOutlet UITextField *miMa1TextFiled;
@property (strong, nonatomic) IBOutlet UITextField *miMa2TextField;
- (IBAction)yanZhenBtnClick:(UIButton *)sender;
- (IBAction)tiJiaoBtnClick:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIView *bgView;

@property (strong, nonatomic) IBOutlet UIButton *tiJiaoBtn;


@end
