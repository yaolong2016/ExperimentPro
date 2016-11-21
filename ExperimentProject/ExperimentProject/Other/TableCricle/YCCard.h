//
//  YCCard.h
//  ExperimentProject
//
//  Created by yaolong on 16/11/21.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    Card_Default,
    ///主管
    Card_Admin,
    ///助理
    Card_Helper,
    ///未完成
    Card_Continue,
    ///负责人
    Card_PersionInCharge,
    ///顾问
    Card_Adviser,
    ///待审核
    Card_WaittingReview,
    ///财务
    Card_Finance,
    ///科研元
    Card_ScitifficSereach,
    
}
///选项卡类型
CardType;

#define CardTopHeight 44.0f

#define CardSecondHeight 25.0f

#define CardSpaceWidth 8.0f

#define CardMiddleHeight 90.0f

@interface YCCard : UIView

- (id) initWithYCCard:(CGRect) frame chagneType:(CardType) type;

@end
