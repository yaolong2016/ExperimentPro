//
//  YCTopCardView.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/18.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "YCTopCardView.h"
#import "BottonTableViewIndex.h"
#import "YCCard.h"

@class YCCard;

@interface YCTopCardView()<BottonTableViewIndexDelegate,iCarouselDelegate,iCarouselDataSource> {

    BottonTableViewIndex* bottonIndexView;
    iCarousel* tableView_m;

}

@end

@implementation YCTopCardView

- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self->bottonIndexView = nil;
        
        self->bottonIndexView = [[BottonTableViewIndex alloc] initWithBottonTableView:CGRectMake(0, 30, self.frame.size.width, 30)];
        self->bottonIndexView.delegate_m = self;
        [self addSubview:self->bottonIndexView];
        
        self->tableView_m = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0,
                                                                       self.frame.size.width,
                                                                       self.frame.size.height-self->bottonIndexView.frame.size.height)];
        self->tableView_m.type = iCarouselTypeCoverFlow;
        [self->tableView_m setDelegate:self];
        [self->tableView_m setDataSource:self];
        [self addSubview:self->tableView_m];
        
        [self->bottonIndexView setFrame:CGRectMake(0, self->tableView_m.frame.size.height,
                                                   self->bottonIndexView.frame.size.width,
                                                   self->bottonIndexView.frame.size.height)];
     
        
        [self.layer setBorderWidth:1];
    }
    return self;
}

- (NSArray*) iCarouselBottonIndex:(BottonTableViewIndex *)object {
    return @[@"A",@"B",@"C",@"D"];
}

- (NSUInteger) numberOfItemsInCarousel:(iCarousel *)carousel {
    return 10;
}

- (NSUInteger) numberOfVisibleItemsInCarousel:(iCarousel *)carousel {
    return 3;
}

- (UIView*) carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view {
    YCCard* card = [[YCCard alloc] initWithYCCard:CGRectMake(30,
                                                            10,
                                                            self.frame.size.width-60,
                                                            self.frame.size.height-self->bottonIndexView.frame.size.height-20)
                                       chagneType:Card_Admin];
    card.layer.borderWidth = 1;
    card.layer.borderColor = [UIColor blackColor].CGColor;
    //[card setBackgroundColor: index%2 == 0 ? [UIColor grayColor]:[UIColor greenColor]];
    return card;
}

- (CGFloat) carouselItemWidth:(iCarousel *)carousel {
    return self.frame.size.width-60;
}

- (CGFloat) carousel:(iCarousel *)carousel valueForTransformOption:(iCarouselTranformOption)option withDefault:(CGFloat)value {
    if (option == iCarouselTranformOptionTilt) {
        return 0;
    } else if (option == iCarouselTranformOptionSpacing) {
        return 1.2;
    }
    return 0;
}


- (void) BottonTableViewIndexChangeIndex:(BottonTableViewIndex *)object index:(NSInteger)at {
    
}

@end
