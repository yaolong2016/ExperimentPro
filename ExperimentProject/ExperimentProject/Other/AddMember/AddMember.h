//
//  AddMember.h
//  ExperimentProject
//
//  Created by yaolong on 16/11/16.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BATableView.h"

@class BATableView;

///团队成员的添加和修改
@interface AddMember : UIViewController<BATableViewDelegate>

@property (nonatomic, strong) IBOutlet BATableView* tableView_m;
@property (nonatomic, strong) IBOutlet UIView* bottonView_m;

@end
