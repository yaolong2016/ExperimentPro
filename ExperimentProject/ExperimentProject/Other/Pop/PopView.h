//
//  PopView.h
//  ExperimentProject
//
//  Created by yaolong on 16/11/21.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {

    POP_SIZE_15X15,
    POP_SIZE_20X20,
    POP_SIZE_25X25,
    POP_SIZE_30X30

}
///气泡大小
PopSize;

typedef enum {

    POP_LOCAL_LEFT,
    POP_LOCAL_RIGHT
    
}
///气泡位置
PopLocal;

@interface PopView : UIButton
///初始化气泡
- (instancetype) initWithPop:(PopLocal) local
           popSize:(PopSize) size
          fontSize:(CGFloat) font
            shadow:(BOOL) mark
            inView:(UIView*) object;
///设置消息数目
- (void) showPopNumber:(NSInteger) number;
///添加方法
- (void) addTagTouchInSide:(nonnull SEL) fun;

@end
