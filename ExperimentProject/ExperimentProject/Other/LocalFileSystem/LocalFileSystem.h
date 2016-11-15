//
//  LocalFileSystem.h
//  ExperimentProject
//
//  Created by yaolong on 16/11/14.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ///文档
    Type_Document,
    //图片
    Type_Picture,
    //其他
    Type_Other
}ListType;

@interface LocalFileSystem : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UIView* topChange_m;
@property (nonatomic, strong) IBOutlet UIView* tableView_m;
@property (nonatomic, strong) IBOutlet UIImageView* selectImg;



@end
