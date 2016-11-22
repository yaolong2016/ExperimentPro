//
//  PopView.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/21.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "PopView.h"

@implementation PopView

- (id) initWithPop:(PopLocal) local popSize:(PopSize) size fontSize:(CGFloat) font shadow:(BOOL) mark inView:(UIView*) object{

    CGFloat localx = 0.0f;
    CGSize popsize = CGSizeZero;
    
    if (size == POP_SIZE_15X15) {
        popsize = CGSizeMake(15, 15);
    } else if (size == POP_SIZE_20X20) {
        popsize = CGSizeMake(20, 20);
    } else if (size == POP_SIZE_25X25) {
        popsize = CGSizeMake(25, 25);
    } else if (size == POP_SIZE_30X30) {
        popsize = CGSizeMake(30, 30);
    }
    
    
    if (local == POP_LOCAL_LEFT) {
        localx = 0;
    } else if (local == POP_LOCAL_RIGHT) {
        localx = object.frame.size.width - popsize.width;
    }
    
    if (self = [super initWithFrame:CGRectMake(localx, 0, popsize.width, popsize.height)]) {
        self.backgroundColor = [UIColor redColor];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:font]];
        
        [self.layer setCornerRadius:self.frame.size.height/2];
        [self.layer setMasksToBounds:YES];
        
        if (mark) {
            [self.layer setShadowColor:[UIColor blackColor].CGColor];
            [self.layer setShadowOffset:CGSizeMake(0, 0)];
            [self.layer setShadowRadius:0.5];
            [self.layer setShadowOpacity:0.5];
        }
        
        [object addSubview:self];
        return self;
    }
    return nil;
}

- (void) showPopNumber:(NSInteger) number {
    NSString* popnumber = @"";
    if (number<100) {
        popnumber = @"99+";
        self.hidden = NO;
    } else if (number > 0) {
        popnumber = [NSString stringWithFormat:@"%ld",(long)number];
        self.hidden = NO;
    } else {
        self.hidden = YES;
    }
    [self setTitle:popnumber forState:UIControlStateNormal];
}

@end
