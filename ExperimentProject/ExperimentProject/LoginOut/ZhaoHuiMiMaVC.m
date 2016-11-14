//
//  ZhaoHuiMiMaVC.m
//  ExperimentProject
//
//  Created by YJM on 2016/11/14.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "ZhaoHuiMiMaVC.h"
#import "DefineTool.h"
@interface ZhaoHuiMiMaVC ()

@end

@implementation ZhaoHuiMiMaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ViewBorderRadius(self.bgView, 4, 0, [UIColor whiteColor]);
    self.title = NSLocalizedString(@"找回密码", nil);
    [self setUIString];
}

- (void)setUIString{
    self.souJiTextField.placeholder = NSLocalizedString(@"请输入手机号", nil);
    self.yanZhenCode.placeholder = NSLocalizedString(@"短信验证码", nil);
    [self.yanZhenBtn setTitle:NSLocalizedString(@"获取验证码", nil) forState:UIControlStateNormal];
    self.miMa1TextFiled.placeholder = NSLocalizedString(@"请输入密码", nil);
    self.miMa2TextField.placeholder = NSLocalizedString(@"请确认密码", nil);
    [self.tiJiaoBtn setTitle:NSLocalizedString(@"提交", nil) forState:UIControlStateNormal];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.yanZhenBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.yanZhenBtn setTitleColor:ColorWithRGB(0xFB8557) forState:UIControlStateNormal];
                self.yanZhenBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.yanZhenBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                
                [self.yanZhenBtn setTitleColor:ColorWithRGB(0x979797) forState:UIControlStateNormal];
                self.yanZhenBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}


- (IBAction)yanZhenBtnClick:(UIButton *)sender {
    [self openCountdown];
}

- (IBAction)tiJiaoBtnClick:(UIButton *)sender {
    if (![self.souJiTextField.text isEqualToString:@""]) {
        if([self valiMobile:self.souJiTextField.text]){
            
        }else{
            NSLog(@"请填写正确的电话号码!");
            return;
        }
    }else{
        NSLog(@"电话号码为空!");
        return;
    }
    
    if (![self.miMa1TextFiled.text isEqualToString:@""]) {
        
    }else{
        NSLog(@"密码为空!");
        return;
    }
    if (![self.miMa2TextField.text isEqualToString:@""]) {
        
    }else{
        NSLog(@"确认密码为空!");
        return;
    }
    
    if (![self.yanZhenCode.text isEqualToString:@""]) {
        
    }else{
        NSLog(@"验证码为空!");
        return;
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

@end
