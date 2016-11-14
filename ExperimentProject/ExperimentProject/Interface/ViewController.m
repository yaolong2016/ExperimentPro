//
//  ViewController.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/4.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "ViewController.h"
#import "ToolFuncation.h"

///测试文件头
#import "LocalFileSystem.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize mainInterface_m;
@synthesize sets_m;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainInterface_m = nil;
    self.sets_m = nil;
    //首先判断用户使用app是不是停留在引导页的
    if (![ToolFuncation getGuideDidMark:nil]) {//进入引导页
        [self loadMainInterfaceController:APP_INTO_GUIDE];
    } else {//进入登录或者内容页
        if ([ToolFuncation isLogin:nil] == NO) {//进入登录页面
            [self loadMainInterfaceController:APP_INTO_LOGINOUT];
            
        } else {//进入选择页面
            [self loadMainInterfaceController:[ToolFuncation appInterfaceMark]];
            
        }
    }
    
    
    ///测试加载文件
//    LocalFileSystem* fs = [[[NSBundle mainBundle] loadNibNamed:@"LocalFileSystem" owner:self options:nil] objectAtIndex:0];
//    [self.navigationController pushViewController:fs animated:YES];
    
    
}

- (void) loadMainInterfaceController:(APPInterfaceChange) mark {
    switch (mark) {
        case APP_INTO_GUIDE:
            [self mainViewControllerInit:GUIDE_CLASS_NAME];
            break;
        case APP_INTO_LOGINOUT:
            [self mainViewControllerInit:LOGINOUT_CLASS_NAME];
            break;
        case APP_INTO_SETTINGS:
            [self loadSettingsController];
            break;
        case APP_INTO_UNIVERSAL:
            [self mainViewControllerInit:UNIVERSION_CLASS_NAME];
            break;
        case APP_INTO_MANAGER:
            [self mainViewControllerInit:MANAGER_CLASS_NAME];
            break;
        case APP_INTO_KYVERSION:
            [self mainViewControllerInit:KYVERSION_CLASS_NAME];
            break;
        default:
            break;
    }
}

- (id) mainViewControllerInit:(NSString*) cs {
    if (!self.mainInterface_m) {
        self.mainInterface_m = [[[NSBundle mainBundle] loadNibNamed:cs
                                                             owner:self
                                                           options:nil] objectAtIndex:0];
        [self.navigationController pushViewController:self.mainInterface_m
                                             animated:NO];
    }
    return self.mainInterface_m;
}

- (void) removeMainInterfaceViewController {
    if (self.mainInterface_m) {
        UIViewController* controller = (UIViewController*)self.mainInterface_m;
        for (UIViewController* viewC in [controller childViewControllers]) {
            [viewC.navigationController popViewControllerAnimated:NO];
            [viewC dismissViewControllerAnimated:NO completion:nil];
        }
        [((UIViewController*)self.mainInterface_m).navigationController popViewControllerAnimated:NO];
        [self.mainInterface_m dismissViewControllerAnimated:NO completion:nil];
        self.mainInterface_m = nil;
    }
}

- (void) loadSettingsController {
    if (!self.sets_m) {
        self.sets_m = [[[NSBundle mainBundle] loadNibNamed:SETTINGS_CLASS_NAME
                                                    owner:self
                                                  options:nil] objectAtIndex:0];
        [[UIApplication sharedApplication].keyWindow addSubview:self.sets_m.view];
    }
}

///---------------------------------------------------------------------------------------------









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"内存警告!!!");
}

@end
