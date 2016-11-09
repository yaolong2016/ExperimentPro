//
//  YunCaiAPI.h
//  ExperimentProject
//
//  Created by YJM on 2016/11/7.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <Foundation/Foundation.h>
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

///设置圆角(makeToBounds)
#define ViewBorderRadius(View, Radius, Width, Color)\\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

///设置图片,以图片名字
#define GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

///获取时间戳
#define GetCurentTime [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]]

@interface YunCaiAPI : NSObject

@end
