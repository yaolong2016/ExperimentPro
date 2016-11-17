//
//  MemberHeadImage.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/17.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "MemberHeadImage.h"

@implementation MemberHeadImage
@synthesize ID;

- (id) init {
    if (self = [super init]) {
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = self.frame.size.height/2;
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = self.frame.size.height/2;
    }
    return self;
}

@end
