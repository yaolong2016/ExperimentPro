//
//  PictureCellImg.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/15.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "PictureCellImg.h"

@implementation PictureCellImg

-(id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        
    }
    return self;
}

@end
