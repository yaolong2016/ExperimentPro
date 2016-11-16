//
//  YaoQingHaoYouViewController.m
//  ExperimentProject
//
//  Created by YJM on 2016/11/16.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "YaoQingHaoYouViewController.h"

@interface YaoQingHaoYouViewController ()

@end

@implementation YaoQingHaoYouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"邀请好友", nil);
    
    self.titleLab.text = NSLocalizedString(@"您可以通过短信、微信、QQ、等方式把APP的下载链接发送给好友，邀请好友使用实验宝。", nil);
    [self.duanXinBtn setTitle:NSLocalizedString(@"   短信邀请", nil) forState:UIControlStateNormal];
    [self.qqBtn setTitle:NSLocalizedString(@"   QQ邀请", nil) forState:UIControlStateNormal];
    [self.weiXinBtn setTitle:NSLocalizedString(@"   微信邀请", nil) forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)duanXinBtnClick:(UIButton *)sender {
}

- (IBAction)qqBtnClick:(UIButton *)sender {
}

- (IBAction)weiXinBtnClick:(UIButton *)sender {
}
@end
