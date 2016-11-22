//
//  YCCard.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/21.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "YCCard.h"
#import "DefineTool.h"
#import "ToolFuncation.h"
#import "LocalFileSystem.h"
#import "GraphicsDrawView.h"
#import "PopView.h"

@interface YCCard() {
    ///保存选择类型
    CardType changeType;
    
    UILabel* cardHeader;
    
    UILabel* secondHeader;
    UILabel* project_time;
    UIButton* project_persionincharge;
    
    UIView* middleView;
    
    UIView* bottonView;

}

@end

@implementation YCCard

- (id) initWithYCCard:(CGRect)frame chagneType:(CardType)type {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        
        self->changeType = type;
        
        self->cardHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, CardTopHeight)];
        [self->cardHeader setBackgroundColor:ColorWithRGB(BlueColor)];
        [self->cardHeader setTextColor:[UIColor whiteColor]];
        [self->cardHeader setTextAlignment:NSTextAlignmentCenter];
        [self->cardHeader setText:@"高效率荧光聚光"];
        [self addSubview:self->cardHeader];
        
        self->secondHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, self->cardHeader.frame.size.height, frame.size.width, CardSecondHeight)];
        [self addSubview:self->secondHeader];
        
        self->project_time = [[UILabel alloc] initWithFrame:CGRectMake(CardSpaceWidth,
                                                                       0,
                                                                       self->secondHeader.frame.size.width/3*2-CardSpaceWidth,
                                                                       self->secondHeader.frame.size.height)];
        [self->project_time setFont:[UIFont systemFontOfSize:10]];
        [self->project_time setTextAlignment:NSTextAlignmentLeft];
        [self->project_time setAdjustsFontSizeToFitWidth:YES];
        [self->project_time setText:@"项目时间：2016.10.20 至 2016.10.20"];
        
        self->project_persionincharge = [[UIButton alloc] initWithFrame:CGRectMake(self->project_time.frame.size.width,
                                                                                  0,
                                                                                  self->secondHeader.frame.size.width/3*1,
                                                                                  self->secondHeader.frame.size.height)];
        [self->project_persionincharge.titleLabel setFont:[UIFont systemFontOfSize:12]];
        
        [self->secondHeader addSubview:self->project_time];
        [self->secondHeader addSubview:self->project_persionincharge];
        [self->project_persionincharge setImage:[UIImage imageNamed:@"yl_back"] forState:UIControlStateNormal];
        [self->project_persionincharge setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [self->project_persionincharge setTitle:@" 习总" forState:UIControlStateNormal];
        
        UIImageView* topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                             self->secondHeader.frame.size.height-0.5,
                                                                             self->secondHeader.frame.size.width,
                                                                             1)];
        [topLine setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [self->secondHeader addSubview:topLine];
        
        self->middleView = [[UIView alloc] initWithFrame:CGRectMake(0, CardTopHeight+CardSecondHeight,
                                                                    frame.size.width,
                                                                    CardMiddleHeight)];
        [self addSubview:self->middleView];
        
        UIImageView* bottonLine = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                             self->middleView.frame.size.height-0.5,
                                                                             self->secondHeader.frame.size.width,
                                                                             1)];
        [bottonLine setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [self->middleView addSubview:bottonLine];
        
        
        self->bottonView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                    self->middleView.frame.size.height+self->middleView.frame.origin.y,
                                                                    frame.size.width,
                                                                    (frame.size.height - CardMiddleHeight - CardTopHeight))];
        [self addSubview:self->bottonView];
        [self->bottonView setBackgroundColor:[UIColor grayColor]];
        
        
        
    }
    return self;
}

@end
