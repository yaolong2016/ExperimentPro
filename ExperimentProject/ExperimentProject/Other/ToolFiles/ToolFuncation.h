//
//  ToolFuncation.h
//  ExperimentProject
//
//  Created by yaolong on 16/11/11.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DefineTool.h"

@class AppDelegate;
@interface ToolFuncation : NSObject

///获取和设置导航完成标志：（当传递为nil的时后，表示获取标示；当传递其他值的时候表示设置）
+ (NSString*) getGuideDidMark:(NSString*) mark;

///控制导航条的显示和隐藏(YES:HIDE  NO:SHOW)
+ (void) controlNavigationHideShow:(BOOL) mark controller:(UIViewController*) cl;

///控制状态栏的显示(YES:HIDE  NO:SHOW)
+ (void) controlStatusShow:(BOOL) mark animation:(BOOL) an;

///获取用户是否登录：（当传递为nil的时后，表示获取标示；当传递其他值的时候表示设置必须是Login or Logout）
+ (BOOL) isLogin:(NSString*) mark;

///获取app的进入页面标示
+ (APPInterfaceChange) appInterfaceMark;

///设置app的进入页面
+ (void) setAppInterfaceChange:(APPInterfaceChange) mark;

///从导航当中获取 其中一个类对象
+ (id) getNavigationChildrensController:(Class) cname viewControllers:(UIViewController*) vc;

///获取appdelegate类中的参数
+ (AppDelegate*) getAppDelegateObject;

///获取设备的屏幕大小
+ (CGSize) screenSize;

///状态栏的高度
+ (CGFloat) statusHeight;

@end
