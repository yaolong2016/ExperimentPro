//
//  ToolFuncation.h
//  ExperimentProject
//
//  Created by yaolong on 16/11/11.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ToolFuncation : NSObject

///获取和设置导航完成标志：（当传递为nil的时后，表示获取标示；当传递其他值的时候表示设置）
+ (NSString*) getGuideDidMark:(NSString*) mark;

///控制导航条的显示和隐藏(YES:HIDE  NO:SHOW)
+ (void) controlNavigationHideShow:(BOOL) mark controller:(UIViewController*) cl;

///控制状态栏的显示(YES:HIDE  NO:SHOW)
+ (void) controlStatusShow:(BOOL) mark animation:(BOOL) an;
@end
