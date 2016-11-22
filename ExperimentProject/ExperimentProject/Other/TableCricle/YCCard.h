//
//  YCCard.h
//  ExperimentProject
//
//  Created by yaolong on 16/11/21.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardBottonButton.h"


#define CardSpaceWidth 8.0f

@protocol YCCardDelegate;

@interface YCCard : UIView
///卡片的类型
@property (nonatomic, assign) CardType type_m;

@property (nonatomic, weak) id<YCCardDelegate>delegate;

- (id) initWithYCCard:(CGRect) frame chagneType:(CardType) type;

- (void) controlButtonPopNumber:(NSInteger) number button:(CardBottonButton*) btn;

- (void) notcontentShow:(NSString*) title buttonTitle:(NSString*) btitle promptColor:(UIColor*) color;

@end


@protocol YCCardDelegate <NSObject>

@optional
- (void) cardClickButton:(YCCard*) object button:(CardBottonButton*) btn;

@end
