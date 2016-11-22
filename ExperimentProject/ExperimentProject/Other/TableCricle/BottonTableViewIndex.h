//
//  BottonTableViewIndex.h
//  ExperimentProject
//
//  Created by yaolong on 16/11/21.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton(BTVI)

@property (nonatomic, weak) NSString* saveCharIndex;

- (void) setSaveCharIndex:(NSString *)saveCharIndex;

- (NSString*) saveCharIndex;

@end

@protocol BottonTableViewIndexDelegate;

@interface BottonTableViewIndex : UIView

@property (nonatomic, weak) id<BottonTableViewIndexDelegate>delegate_m;

- (id) initWithBottonTableView:(CGRect) frame;

- (void) addIndexTitle;

- (void) selectedIndex:(NSInteger) at charIndex:(NSString*) ci;

- (void) setDelegate_m:(id<BottonTableViewIndexDelegate>)delegate_m;

- (void) reloadBottonIndex;

@end


@protocol BottonTableViewIndexDelegate

@optional
- (void) BottonTableViewIndexChangeIndex:(BottonTableViewIndex*) object index:(NSInteger) at;
- (NSArray*) iCarouselBottonIndex:(BottonTableViewIndex*) object;

@end
