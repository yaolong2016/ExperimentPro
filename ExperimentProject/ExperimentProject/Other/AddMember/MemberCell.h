//
//  MemberCell.h
//  ExperimentProject
//
//  Created by yaolong on 16/11/17.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MemberCellDelegate;

@interface MemberCell : UITableViewCell

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, weak) NSIndexPath* indexPath;
@property (nonatomic, weak) id<MemberCellDelegate>delegate;

@end


@protocol MemberCellDelegate <NSObject>

- (void) memberCellDidSelectRowAtIndexPath:(NSIndexPath*) indexPaths object:(MemberCell*) tagObject;

@end
