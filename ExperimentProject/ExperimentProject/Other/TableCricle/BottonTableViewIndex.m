//
//  BottonTableViewIndex.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/21.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "BottonTableViewIndex.h"
#import <objc/runtime.h>
#import "DefineTool.h"


@implementation UIButton(BTVI)
@dynamic saveCharIndex;

- (void) setSaveCharIndex:(NSString *)saveCharIndex {
    objc_setAssociatedObject(self, &bottonIndexChar, saveCharIndex, OBJC_ASSOCIATION_ASSIGN);
}

- (NSString*) saveCharIndex {
  return objc_getAssociatedObject(self, &bottonIndexChar);
}

@end

@interface BottonTableViewIndex() {

    UIScrollView* scrollView_m;
    CGFloat with_height;
    UIButton* saveSelectedBtn;
    
}


@end

@implementation BottonTableViewIndex
@synthesize delegate_m = _delegate_m;

- (id) initWithBottonTableView:(CGRect) frame {
    if (self = [super initWithFrame:frame]) {
        self->saveSelectedBtn = nil;
        self.delegate_m = nil;
        with_height = frame.size.height - 15;
        self->scrollView_m = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self->scrollView_m setPagingEnabled:YES];
        [self addSubview:self->scrollView_m];
        
    }
    return self;
}

- (void) setDelegate_m:(id<BottonTableViewIndexDelegate>)delegate_m {
    _delegate_m = delegate_m;
    [self addIndexTitle];

}

- (void) addIndexTitle {
    if (self.delegate_m==nil) {
        return;
    }
    NSArray* array = [self.delegate_m iCarouselBottonIndex:self];
    if (!array) {
        return;
    }
    CGFloat lenghtAll = with_height*array.count+(10*(array.count-1));
    CGFloat localX = (self.frame.size.width - lenghtAll)/2;
    
    for (NSString* title in array) {
        NSInteger index = [array indexOfObject:title];
        UIButton* indexBtn = [[UIButton alloc] initWithFrame:CGRectMake(localX+index*with_height+10*index, 7.5, with_height, with_height)];
        [indexBtn setTitle:title forState:UIControlStateNormal];
        [indexBtn.layer setCornerRadius:indexBtn.frame.size.height/2];
        indexBtn.tag = index;
        [indexBtn setSaveCharIndex:title];
        [self buttonPertry:indexBtn];
        [indexBtn addTarget:self action:@selector(selectedIndexBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self->scrollView_m addSubview:indexBtn];
    }

}

- (void) buttonPertry:(UIButton*) btn {
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn.layer setShadowColor:[UIColor blackColor].CGColor];
    [btn.layer setShadowOffset:CGSizeMake(0, 0)];
    [btn.layer setShadowRadius:1.5];
    [btn.layer setShadowOpacity:1];
    [btn.layer setAffineTransform:CGAffineTransformMakeScale(1.0, 1.0)];
}

- (void) buttonScalePertry:(UIButton*) btn {
    [UIView animateWithDuration:0.25
                     animations:^{
                         if (self->saveSelectedBtn) {
                             [self buttonPertry:self->saveSelectedBtn];
                         }
                         
                         [btn setBackgroundColor:[UIColor redColor]];
                         [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                         [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                         [btn.layer setShadowColor:[UIColor blackColor].CGColor];
                         [btn.layer setShadowOffset:CGSizeMake(0, 0)];
                         [btn.layer setShadowRadius:1.5];
                         [btn.layer setShadowOpacity:1.5];
                         [btn.layer setAffineTransform:CGAffineTransformMakeScale(1.25, 1.25)];
                     }];
}

- (void) selectedIndexBtn:(UIButton*) btn {

    [self buttonScalePertry:btn];

    self->saveSelectedBtn = btn;
    if (self.delegate_m) {
        [self.delegate_m BottonTableViewIndexChangeIndex:self index:btn.tag];
    }
}

- (void) selectedIndex:(NSInteger)at charIndex:(NSString *)ci {

    if (at != -1) {
        UIButton* btn = [self->scrollView_m.subviews objectAtIndex:at];
        [self selectedIndexBtn:btn];
    } else {
        for (UIButton* btn in self->scrollView_m.subviews) {
            if ([btn.saveCharIndex isEqualToString:ci]) {
                [self buttonScalePertry:btn];
                self->saveSelectedBtn = btn;
                
                break;
            }
        }
    }

}

- (void) reloadBottonIndex {
    for (UIView* object in self->scrollView_m.subviews) {
        [object removeFromSuperview];
    }
    self->saveSelectedBtn = nil;
    
    [self addIndexTitle];
}

@end
