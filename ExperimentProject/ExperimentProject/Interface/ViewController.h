//
//  ViewController.h
//  ExperimentProject
//
//  Created by yaolong on 16/11/4.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCLogin.h"
#import "YCManagerInterface.h"
#import "YCKYVersionInterface.h"
#import "YCUniversalInterface.h"
#import "YCGuideViewController.h"
#import "YCSettingsViewController.h"
#import "DefineTool.h"

@interface ViewController : UIViewController

///入口类使用的时候需要转换成三大模块的viewcontroller对象
@property (strong, nonatomic) id mainInterface_m;

///加载app控制入口板块
- (void) loadMainInterfaceController:(APPInterfaceChange) mark;
///初始化controller
- (id) mainViewControllerInit:(NSString*) cs;
///移除主视图
- (void) removeMainInterfaceViewController;

@end

