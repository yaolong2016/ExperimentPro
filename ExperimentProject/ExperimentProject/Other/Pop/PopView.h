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

PopSize;

typedef enum {

    POP_LOCAL_LEFT,
    POP_LOCAL_RIGHT
    
}

PopLocal;

@interface PopView : UIButton

- (id) initWithPop:(PopLocal) local popSize:(PopSize) size fontSize:(CGFloat) font shadow:(BOOL) mark inView:(UIView*) object;

- (void) showPopNumber:(NSInteger) number;

@end
