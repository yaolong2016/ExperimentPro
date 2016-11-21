//
//  GraphicsDrawView.h
//  ExperimentProject
//
//  Created by yaolong on 16/11/21.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    ///圆
    Graphics_Cricle,
    ///方形
    Graphics_Square

}
///图形处理类型
GraphiceViewType;


@interface GraphicsDrawView : UIView

- (id) initWithGraphicsDrawView:(CGRect) frame drawType:(GraphiceViewType) type;

@end
