//
//  DefileTool.h
//  ExperimentProject
//
//  Created by yaolong on 16/11/11.
//  Copyright © 2016年 yaolong. All rights reserved.
//

///板块控制参数
typedef enum {
    ///默认参数
    APP_DEFAULT,
    ///进入整合版本
    APP_INTO_UNIVERSAL,
    ///进入管理版本
    APP_INTO_MANAGER,
    ///进入科研版本
    APP_INTO_KYVERSION,
    ///进入引导页面
    APP_INTO_GUIDE,
    ///进入登录注册页面
    APP_INTO_LOGINOUT,
    ///进入设置页面
    APP_INTO_SETTINGS
    
}APPInterfaceChange;

static char bottonIndexChar = 'd';

///模块的入口的类名
#define UNIVERSION_CLASS_NAME @"YCUniversalInterface"
#define MANAGER_CLASS_NAME    @"YCManagerInterface"
#define KYVERSION_CLASS_NAME  @"YCKYVersionInterface"
#define GUIDE_CLASS_NAME      @"YCGuideViewController"
#define SETTINGS_CLASS_NAME   @"YCSettingsViewController"
#define LOGINOUT_CLASS_NAME   @"YCLogin"

///登录标示
#define Login  @"1"
#define Logout @"0"

///获取mainScreen的宽度
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
///获取mainScreen的高度
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

///有判断环境的NSLog
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

///获取weakSelf
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

///设置颜色,默认透明度为1
#define RGB(a,b,c) [UIColor colorWithRed:(a/255.0) green:(b/255.0) blue:(c/255.0) alpha:1.0]
///设置颜色,没有默认透明度
#define RGBA(a,b,c,d) [UIColor colorWithRed:(a/255.0) green:(b/255.0) blue:(c/255.0) alpha:d]
///设置随机颜色
#define RandomColor UIColor.init(red: CGFloat(arc4random() % 256)/255.0, green: CGFloat(arc4random() % 256)/255.0, blue: CGFloat(arc4random() % 256)/255.0, alpha: 1)
///设置颜色,以十六进制 以0x开头
#define ColorWithRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

///设置圆角(makeToBounds)
#define ViewBorderRadius(View, Radius, Width, Color)\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

///设置图片,以图片名字
#define GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

///获取时间戳
#define GetCurentTime [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]]
///判断机型
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )480) < DBL_EPSILON )
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON )
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )667) < DBL_EPSILON )
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )736) < DBL_EPSILON )
//960
