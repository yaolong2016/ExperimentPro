//
//  LocalFileSystem.h
//  ExperimentProject
//
//  Created by yaolong on 16/11/14.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DocumentCell.h"
#import "PictureCellImg.h"
#import "PullToRefreshTableView.h"

#define BlueColor 0x106be6

typedef enum {
    ///文档
    Type_Document,
    //图片
    Type_Picture,
    //其他
    Type_Other
}ListType;

@class PullToRefreshTableView;

@interface LocalFileSystem : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,DocumentCellDelegate,PictureCellImgDelegate>

@property (nonatomic, strong) IBOutlet UIView* topChange_m;
@property (nonatomic, strong) IBOutlet PullToRefreshTableView* tableView_m;
@property (nonatomic, strong) IBOutlet UIImageView* selectImg;



@end
