//
//  CardBottonButton.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/22.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "CardBottonButton.h"

@implementation CardBottonButton
@synthesize type;

- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        type = Card_Default;
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        type = Card_Default;
    }
    return self;
}

- (id) init {
    if (self = [super init]) {
        type = Card_Default;
    }
    return self;
}

@end
