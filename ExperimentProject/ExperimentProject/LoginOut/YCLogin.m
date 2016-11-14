//
//  YCLogin.m
//  ExperimentProject
//
//  Created by YJM on 2016/11/11.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "YCLogin.h"
#import "ToolFuncation.h"
#import "DefineTool.h"
#import "ZhuCeVC.h"
#import "ZhaoHuiMiMaVC.h"
#import "ViewController.h"
//typedef NS_OPTIONS(NSUInteger, ActionType) {
//    ActionTypeUp    = 1 << 0, // 1
//    ActionTypeDown  = 1 << 1, // 2
//    ActionTypeRight = 1 << 2, // 4
//    ActionTypeLeft  = 1 << 3, // 8
//};
@interface YCLogin ()
{
    /// 101为综合版,102为管理版,103为科研版
    NSInteger banBenValue;
}
@end

@implementation YCLogin

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor redColor];\\
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.zhongHeBtn setSelected:YES];
    banBenValue = 101;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [ToolFuncation controlNavigationHideShow:NO controller:self];
    [ToolFuncation controlStatusShow:NO animation:NO];
    ///隐藏返回按键
    self.navigationItem.hidesBackButton = YES;
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [ToolFuncation controlNavigationHideShow:NO controller:self];
}

/*
#pragma mark - Navigation

 In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     Get the new view controller using [segue destinationViewController].
     Pass the selected object to the new view controller.
}
*/

//键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = (self.miMaTextField.frame.origin.y+self.miMaTextField.frame.size.height ) - (self.view.frame.size.height - kbHeight);
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
//    if(offset > 0) {
        if(SCREENH_HEIGHT < 568) {
        [UIView animateWithDuration:duration animations:^{
           NSLog(@"进入这里");
//            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
//            self.view.frame = CGRectMake(0.0f, -100, self.view.frame.size.width, self.view.frame.size.height);
            self.viewCenter.constant = 50 -0;
            [self updateViewConstraints];
        }];
    }
//    [self updateViewConstraints];
}

- (void)updateViewConstraints{
    
    [super updateViewConstraints];
    
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    
    if (SCREENH_HEIGHT < 568){
        [UIView animateWithDuration:duration animations:^{
            //        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            self.viewCenter.constant = 50 + 0;
            [self updateViewConstraints];
        }];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (IBAction)banKuaiValueChanged:(UIButton *)sender {
   
    if(sender.selected){
    }else{
        [sender setSelected:YES];
        if(self.zhongHeBtn.tag == sender.tag){
            [self.guanLiBtn setSelected:NO];
            [self.keYanBtn setSelected:NO];
        }else if(self.guanLiBtn.tag == sender.tag){
            [self.zhongHeBtn setSelected:NO];
            [self.keYanBtn setSelected:NO];
        }else{
            [self.zhongHeBtn setSelected:NO];
            [self.guanLiBtn setSelected:NO];
        }
    }
    banBenValue = sender.tag;
    
}
- (IBAction)dengLuBtnClick:(UIButton *)sender {
#warning 这里模拟
    ViewController *VC;
    for (UIViewController *aVC in self.navigationController.viewControllers) {
        if ([aVC isKindOfClass:[ViewController class]]) {
            VC = (ViewController *)aVC;
        }
    }
    [VC removeMainInterfaceViewController];
    switch (banBenValue) {
        case 101:
            [VC loadMainInterfaceController:APP_INTO_UNIVERSAL];
            break;
        case 102:
            [VC loadMainInterfaceController:APP_INTO_MANAGER];
            break;
        case 103:
            [VC loadMainInterfaceController:APP_INTO_KYVERSION];
            break;
        default:
            break;
    }
    return;

    
    
//    APP_INTO_UNIVERSAL,
//    ///进入管理版本
//    APP_INTO_MANAGER,
//    ///进入科研版本
//    APP_INTO_KYVERSION,
    
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
    
    if (![self.miMaTextField.text isEqualToString:@""]) {
        
    }else{
        NSLog(@"电话号码为空!");
        return;
    }
    
    
    
    
}

- (IBAction)zhuCeBtnClick:(UIButton *)sender {
    ZhuCeVC *mZhuCeVC = [[ZhuCeVC alloc]init];
    [self.navigationController pushViewController:mZhuCeVC animated:YES];
    
}

- (IBAction)wangJiMiMaBtnClick:(UIButton *)sender {
    ZhaoHuiMiMaVC *mZhaoHuiMiMaVC = [[ZhaoHuiMiMaVC alloc]init];
    [self.navigationController pushViewController:mZhaoHuiMiMaVC animated:YES];
    
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
