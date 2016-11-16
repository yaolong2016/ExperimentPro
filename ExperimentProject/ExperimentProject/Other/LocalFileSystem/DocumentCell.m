//
//  DocumentCell.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/15.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "DocumentCell.h"

@interface DocumentCell()
///判断cell是否被选中  默认没有选中
@property (nonatomic, assign) BOOL isSelected;

@end

@implementation DocumentCell
@synthesize mark;
@synthesize selectedImg;
@synthesize delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    self.isSelected = NO;
    self.delegate = nil;
    
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
        [self.delegate documentCellSelected:self index:self.tag isSelected:self.isSelected];
       
    }
}

@end
