//
//  PictureCellImg.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/15.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "PictureCellImg.h"

@interface PictureCellImg()
///选择状态 默认为no
@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, strong) UIImageView* selectedImg;

@end

@implementation PictureCellImg
@synthesize delegate;

-(id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.isSelected = NO;
        self.userInteractionEnabled = YES;
        self.delegate = nil;
        
        UIImage* simg = [UIImage imageNamed:@"yl_gou"];
        self.selectedImg = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - simg.size.width)-5, 5, simg.size.width, simg.size.height)];
        [self addSubview:self.selectedImg];
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        
    }
    return self;
}

-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if (self.isSelected) {
        [self.selectedImg setImage:nil];
        self.isSelected = NO;
    } else {
        [self.selectedImg setImage:[UIImage imageNamed:@"yl_gou"]];
        self.isSelected = YES;
    }
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(pictureCellImgSelected:index:isSelected:)]) {
            [self.delegate pictureCellImgSelected:self index:self.tag isSelected:self.isSelected];
        }
    }
}

- (void) removeFromSuperview {
    [super removeFromSuperview];
    
    
}

@end
