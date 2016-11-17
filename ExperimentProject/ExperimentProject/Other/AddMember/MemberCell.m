//
//  MemberCell.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/17.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "MemberCell.h"

@interface MemberCell()

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) IBOutlet UIImageView* selectedImg;
@property (nonatomic, strong) IBOutlet UIImageView* headerImg;
@property (nonatomic, strong) IBOutlet UILabel* title;

@end

@implementation MemberCell
@synthesize ID;
@synthesize indexPath;
@synthesize delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = NO;

}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if (self.isSelected) {
        [self.selectedImg setImage:[UIImage imageNamed:@"yl_empty"]];
        self.isSelected = NO;
    } else {
        [self.selectedImg setImage:[UIImage imageNamed:@"yl_gou"]];
        self.isSelected = YES;
    }
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(memberCellDidSelectRowAtIndexPath:object:)]) {
            [self.delegate memberCellDidSelectRowAtIndexPath:self.indexPath object:self];
        }
    }

}



@end
