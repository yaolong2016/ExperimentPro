//
//  AddMember.h
//  ExperimentProject
//
//  Created by yaolong on 16/11/16.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BATableView.h"
#import "MemberCell.h"

@class BATableView;
@protocol AddMemberDelegate;

///团队成员的添加和修改
@interface AddMember : UIViewController<BATableViewDelegate,MemberCellDelegate>

@property (nonatomic, strong) IBOutlet BATableView* tableView_m;
@property (nonatomic, strong) IBOutlet UIView* bottonView_m;
@property (nonatomic, strong) IBOutlet UIView* topView_m;
@property (nonatomic, weak) id<AddMemberDelegate>delegate;

///YES:是现实一个
- (void) showOperationButtonTwoOrOne:(BOOL) one;

@end


@protocol AddMemberDelegate <NSObject>

///passData=nil 时表示取消修改  否则表示修改
- (void) addMemberOperation:(AddMember*) self data:(NSArray*) passData;

@end
