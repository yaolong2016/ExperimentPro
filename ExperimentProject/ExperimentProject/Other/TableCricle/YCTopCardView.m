//
//  YCTopCardView.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/18.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "YCTopCardView.h"

@implementation YCTopCardView

- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.tableView_m = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.tableView_m.type = iCarouselTypeCoverFlow;
        [self.tableView_m setDelegate:self];
        [self.tableView_m setDataSource:self];
        [self addSubview:self.tableView_m];
     
        
        [self.layer setBorderWidth:1];
    }
    return self;
}

- (NSUInteger) numberOfItemsInCarousel:(iCarousel *)carousel {
    return 10;
}

- (NSUInteger) numberOfVisibleItemsInCarousel:(iCarousel *)carousel {
    return 3;
}

- (UIView*) carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view {
    UIView* card = [[UIView alloc] initWithFrame:CGRectMake(15,
                                                            15,
                                                            self.frame.size.width-30,
                                                            self.frame.size.height-30)];
    card.layer.borderWidth = 1;
    card.layer.borderColor = [UIColor blackColor].CGColor;
    [card setBackgroundColor: index%2 == 0 ? [UIColor grayColor]:[UIColor greenColor]];
    card.layer.cornerRadius = 8;
    card.layer.masksToBounds = YES;
    return card;
}

- (CGFloat) carouselItemWidth:(iCarousel *)carousel {
    return self.frame.size.width-20;
}


@end
