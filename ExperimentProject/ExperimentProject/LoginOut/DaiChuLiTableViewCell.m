//
//  DaiChuLiTableViewCell.m
//  ExperimentProject
//
//  Created by YJM on 2016/11/18.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "DaiChuLiTableViewCell.h"
#import "DefineTool.h"
@implementation DaiChuLiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBorderRadius(self.touXiangImageView, 18, 0, [UIColor whiteColor]);
//    self.touXiangImageView
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
