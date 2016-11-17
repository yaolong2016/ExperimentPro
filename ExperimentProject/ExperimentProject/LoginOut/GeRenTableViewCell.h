//
//  GeRenTableViewCell.h
//  ExperimentProject
//
//  Created by YJM on 2016/11/17.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeRenTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lab;

@property (weak, nonatomic) IBOutlet UIImageView *touXiangImageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;
@property (weak, nonatomic) IBOutlet UIImageView *jueSeImageView;

@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;
- (IBAction)bottomBtnClick:(UIButton *)sender;


@end

