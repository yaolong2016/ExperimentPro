//
//  PictureCellImg.h
//  ExperimentProject
//
//  Created by yaolong on 16/11/15.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PictureCellImgDelegate;


///图片处理
@interface PictureCellImg : UIImageView


@property (nonatomic, weak) id<PictureCellImgDelegate>delegate;


@end

@protocol PictureCellImgDelegate <NSObject>

///图片cell选择代理
- (void) pictureCellImgSelected:(PictureCellImg*) object index:(NSInteger) at isSelected:(BOOL) selected;

@end
