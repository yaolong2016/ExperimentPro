//
//  DocumentCell.h
//  ExperimentProject
//
//  Created by yaolong on 16/11/15.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CELL_TYPE_DEFAULT,
    ///文件类型
    CELL_TYPE_DOCUMENT,
    ///其他文件类型
    CELL_TYPE_OTHER
}
///定义cell的类型
FileSystemCellType;


@protocol DocumentCellDelegate;

///文档处理
@interface DocumentCell : UITableViewCell
///设置cell标示
@property (nonatomic, assign) FileSystemCellType mark;
///选择标示
@property (nonatomic, strong) IBOutlet UIImageView* selectedImg;

@property (nonatomic, weak) id<DocumentCellDelegate>delegate;

@end


@protocol DocumentCellDelegate

///选择状态改变
- (void) documentCellSelected:(DocumentCell*) object index:(NSInteger) at isSelected:(BOOL) selected;

@end



