//
//  ToolFuncation.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/11.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "ToolFuncation.h"
#import "AppDelegate.h"

@implementation ToolFuncation


+ (NSString*) getGuideDidMark:(NSString*) mark {

    if (mark == nil) {//返回标示
        NSString* gd = [[NSUserDefaults standardUserDefaults] objectForKey:@"guide"];
        return gd;
    } else {//设置标示
        [[NSUserDefaults standardUserDefaults] setObject:mark forKey:@"guide"];
    }
    return mark;
}

+ (void) controlNavigationHideShow:(BOOL) mark controller:(UIViewController *)cl{
    cl.navigationController.navigationBarHidden = mark;
}

+ (void) controlStatusShow:(BOOL)mark animation:(BOOL)an{
    [[UIApplication sharedApplication] setStatusBarHidden:mark
                                                 animated:an];
}

+ (BOOL) isLogin:(NSString*) mark {
    NSString* gd = [[NSUserDefaults standardUserDefaults] objectForKey:@"login"];
    if (mark == nil) {
        if (!gd) {
            [[NSUserDefaults standardUserDefaults] setObject:Logout forKey:@"login"];
            return NO;
        } else if([Login isEqualToString:gd]) {
            return YES;
        } else if ([Logout isEqualToString:gd]) {
            return NO;
        } else {
            [[NSUserDefaults standardUserDefaults] setObject:Logout forKey:@"login"];
            return NO;
        }
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:mark forKey:@"login"];
        if([Login isEqualToString:mark]) {
            return YES;
        } else if ([Logout isEqualToString:mark]) {
            return NO;
        }
    }
    return NO;
}

+ (APPInterfaceChange) appInterfaceMark {
    NSNumber* mark = [[NSUserDefaults standardUserDefaults] objectForKey:@"app"];
    if (!mark) {
        return APP_DEFAULT;
    }
    NSInteger app = [mark integerValue];
    if (app == APP_INTO_GUIDE) {
        return APP_INTO_GUIDE;
    } else if (app == APP_INTO_LOGINOUT) {
        return APP_INTO_LOGINOUT;
    } else if (app == APP_INTO_SETTINGS) {
        return APP_INTO_SETTINGS;
    } else if (app == APP_INTO_UNIVERSAL) {
        return APP_INTO_UNIVERSAL;
    } else if (app == APP_INTO_MANAGER) {
        return APP_INTO_MANAGER;
    } else if (app == APP_INTO_KYVERSION) {
        return APP_INTO_KYVERSION;
    } else if (app == APP_DEFAULT) {
        return APP_DEFAULT;
    }
    
    
    
    return APP_DEFAULT;
}

+ (void) setAppInterfaceChange:(APPInterfaceChange) mark {
    [[NSUserDefaults standardUserDefaults] setInteger:mark forKey:@"app"];
}

+ (id) getNavigationChildrensController:(Class) cname viewControllers:(UIViewController*) vc{
    for (id object in vc.navigationController.childViewControllers) {
        if ([object isKindOfClass:cname]) {
            return object;
        }
    }
    return nil;
}

+ (AppDelegate*) getAppDelegateObject {
    AppDelegate* obj = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return obj;
}


+ (CGSize) screenSize {
    return [UIScreen mainScreen].bounds.size;
}

+ (CGFloat) statusHeight {
    CGFloat height = [[UIApplication sharedApplication] statusBarFrame].size.height;
    return height;
}









@end
