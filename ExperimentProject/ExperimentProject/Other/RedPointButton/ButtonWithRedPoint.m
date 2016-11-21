//
//  ButtonWithRedPoint.m
//  ExperimentProject
//
//  Created by YJM on 2016/11/18.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "ButtonWithRedPoint.h"

@interface ButtonWithRedPoint()
{
    UIView *redPoint;
}
@end

@implementation ButtonWithRedPoint

- (void)setIsOnOfRedPoint:(BOOL)isOnOfRedPoint{
    NSLog(@"设置圆点");
    _isOnOfRedPoint = isOnOfRedPoint;
    
    redPoint = [[UIView alloc]init];
    redPoint.backgroundColor = [UIColor colorWithRed:254/255.0 green:101/255.0 blue:85/255.0 alpha:1.0];
    //红点设置在按键同等长度的右下角
    redPoint.frame = CGRectMake(self.bounds.size.width - 8, 0, 8, 8);
    redPoint.clipsToBounds = YES;
    redPoint.layer.cornerRadius = 4.0;
    //    redPoint.hidden = YES;
    [self addSubview:redPoint];
    
    //    self.isOnOfRedPoint = NO;

    
    
    if (self.isOnOfRedPoint == YES) {
        redPoint.hidden = NO;
    }else{
        redPoint.hidden = YES;
    }
}
- (void)drawRect:(CGRect)rect {
    
    }


@end
