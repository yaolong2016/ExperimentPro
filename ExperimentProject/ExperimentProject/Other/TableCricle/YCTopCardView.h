//
//  YCTopCardView.h
//  ExperimentProject
//
//  Created by yaolong on 16/11/18.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface YCTopCardView : UIView<iCarouselDelegate,iCarouselDataSource>

@property (strong) iCarousel* tableView_m;

@end
