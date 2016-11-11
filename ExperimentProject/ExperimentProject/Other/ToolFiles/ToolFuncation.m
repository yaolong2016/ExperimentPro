//
//  ToolFuncation.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/11.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "ToolFuncation.h"

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


@end
