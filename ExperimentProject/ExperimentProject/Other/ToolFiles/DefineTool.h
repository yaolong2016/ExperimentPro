//
//  DefileTool.h
//  ExperimentProject
//
//  Created by yaolong on 16/11/11.
//  Copyright © 2016年 yaolong. All rights reserved.
//

///板块控制参数
typedef enum {

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

///模块的入口的类名
#define UNIVERSION_CLASS_NAME @"YCUniversalInterface"
#define MANAGER_CLASS_NAME    @"YCManagerInterface"
#define KYVERSION_CLASS_NAME  @"YCKYVersionInterface"
#define GUIDE_CLASS_NAME      @"YCGuideViewController"
#define SETTINGS_CLASS_NAME   @"YCSettingsViewController"
#define LOGINOUT_CLASS_NAME   @"YCLogin"


