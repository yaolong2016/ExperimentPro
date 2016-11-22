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
@synthesize type_m;
@synthesize delegate;

- (id) initWithYCCard:(CGRect)frame chagneType:(CardType)type {
    if (self = [super initWithFrame:frame]) {
        CGFloat radioHeight = (frame.size.height)/5;
        
        CGFloat headerHeight = radioHeight;
        CGFloat middleHeight = radioHeight*3-radioHeight/5;
        CGFloat bottonHeight = radioHeight+radioHeight/5;
        CGFloat secondHeight = radioHeight-radioHeight/5*2;
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.type_m = type;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 3;
        self.layer.shadowOpacity = 0.25;
        self.layer.shadowOffset = CGSizeMake(0, 5);
        self.layer.shadowColor = [UIColor blackColor].CGColor;
    
        self->changeType = type;
        
        self->cardHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, headerHeight)];
        [self->cardHeader setBackgroundColor:ColorWithRGB(BlueColor)];
        [self->cardHeader setTextColor:[UIColor whiteColor]];
        [self->cardHeader setTextAlignment:NSTextAlignmentCenter];
        [self->cardHeader setText:@"高效率荧光聚光"];
        [self addSubview:self->cardHeader];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self->cardHeader.bounds
                                                       byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                             cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self->cardHeader.bounds;
        maskLayer.path = maskPath.CGPath;
        self->cardHeader.layer.mask = maskLayer;
        self->cardHeader.layer.masksToBounds = YES;
        
        self->middleView = [[UIView alloc] initWithFrame:CGRectMake(0, headerHeight,
                                                                    frame.size.width,
                                                                    middleHeight)];
        [self addSubview:self->middleView];
        
        ///--------------------
        self->secondHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, secondHeight)];
        [self->middleView addSubview:self->secondHeader];
        
        UIImageView* topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                             secondHeight-1,
                                                                             self->secondHeader.frame.size.width,
                                                                             1)];
        [topLine setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [self->secondHeader addSubview:topLine];
        
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
        [self->project_persionincharge.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [self->project_persionincharge setAdjustsImageWhenDisabled:YES];
        
        UIImageView* bottonLine = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                             self->middleView.frame.size.height-0.5,
                                                                             self->secondHeader.frame.size.width,
                                                                             1)];
        [bottonLine setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [self->middleView addSubview:bottonLine];
        
        ///-----------------------
        self->bottonView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                    self->middleView.frame.size.height+self->middleView.frame.origin.y,
                                                                    frame.size.width,
                                                                    bottonHeight)];
        [self addSubview:self->bottonView];
        [self->bottonView setBackgroundColor:[UIColor clearColor]];
        
        if (type == Card_Admin) {
            [self initBottonButtonTitles:@[@"待处理",@"指示",@"成果",@"消息"]];
        } else if (type == Card_Helper) {
            [self initBottonButtonTitles:@[@"待处理",@"指示",@"成果",@"消息"]];
        } else if (type == Card_Continue) {
            [self notcontentShow:@"您尚未完成该项目试验设计"
                     buttonTitle:@"继续完成"
                     promptColor:[UIColor blackColor]];
        } else if (type == Card_PersionInCharge) {
            [self initBottonButtonTitles:@[@"待处理",@"成果",@"消息"]];
        } else if (type == Card_Adviser) {
            [self initBottonButtonTitles:@[@"待处理",@"消息"]];
        } else if (type == Card_WaittingReview) {
            [self notcontentShow:@"等待项目负责人审核"
                     buttonTitle:@"点击查看"
                     promptColor:[UIColor blackColor]];
        } else if (type == Card_Finance) {
            [self initBottonButtonTitles:@[@"抄送",@"指示",@"消息"]];
        } else if (type == Card_ScitifficSereach) {
            [self initBottonButtonTitles:@[@"指示",@"消息"]];
        }
        
    }
    return self;
}

- (void) initBottonButtonTitles:(NSArray*) tarray {
    CGFloat width = self.frame.size.width/tarray.count;
    CGFloat height = self->bottonView.frame.size.height;
    for (NSString* title in tarray) {
        NSInteger index = [tarray indexOfObject:title];
        CardBottonButton* btn = [[CardBottonButton alloc] initWithFrame:CGRectMake(width*index, 0, width, height)];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [self->bottonView addSubview:btn];
        btn.backgroundColor = [UIColor clearColor];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn setType:self.type_m];
        [btn addTarget:self
                action:@selector(clickCardBTN:)
      forControlEvents:UIControlEventTouchUpInside];
        
        PopView* pop = [[PopView alloc] initWithPop:POP_LOCAL_RIGHT
                                            popSize:POP_SIZE_20X20
                                           fontSize:10
                                             shadow:YES
                                             inView:btn];
        [btn addSubview:pop];
    }
    
    for (NSString* title in tarray) {
        NSInteger index = [tarray indexOfObject:title];
        if (index > 0 && index < tarray.count) {
            UIImageView* line = [[UIImageView alloc] initWithFrame:CGRectMake(width*index,
                                                                              0,
                                                                              1, height)];
            [line setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self->bottonView addSubview:line];
        }
    }
}

- (void) notcontentShow:(NSString*) title buttonTitle:(NSString*) btitle promptColor:(UIColor*) color{
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"card_bg"]]];
    self->secondHeader.hidden = YES;
    
    for (UIView* viewss in self->middleView.subviews) {
        [viewss setHidden:YES];
    }
    
    CGFloat promptHeight = self->middleView.frame.size.height/4;
    
    UILabel* titlePrompt = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                     promptHeight,
                                                                     self->middleView.frame.size.width,
                                                                     promptHeight)];
    [titlePrompt setFont:[UIFont systemFontOfSize:14]];
    [titlePrompt setText:title];
    [titlePrompt setTextAlignment:NSTextAlignmentCenter];
    [self->middleView addSubview:titlePrompt];
    [titlePrompt setTextColor:color];
    
    CardBottonButton* btn = [[CardBottonButton alloc] initWithFrame:CGRectMake((self->middleView.frame.size.width - self->middleView.frame.size.width/3)/2,
                                                                               titlePrompt.frame.size.height+titlePrompt.frame.origin.y,
                                                                               self->middleView.frame.size.width/3,
                                                                               promptHeight)];
    [btn setTitle:btitle forState:UIControlStateNormal];
    [btn setTitleColor:ColorWithRGB(BlueColor) forState:UIControlStateNormal];
    [self->middleView addSubview:btn];
    btn.backgroundColor = [UIColor clearColor];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn setType:self.type_m];
    [btn addTarget:self
            action:@selector(clickCardBTN:)
  forControlEvents:UIControlEventTouchUpInside];
    [btn.layer setCornerRadius:4];
    [btn.layer setBorderWidth:2];
    [btn.layer setMasksToBounds:YES];
    [btn.layer setBorderColor:ColorWithRGB(BlueColor).CGColor];

}

- (void) clickCardBTN:(CardBottonButton*) object {

    [self controlButtonPopNumber:3 button:object];
    
    if (self.delegate) {
        if ([self.delegate  respondsToSelector:@selector(cardClickButton:button:)]) {
            [self.delegate cardClickButton:self button:object];
        }
    }
}

- (void) controlButtonPopNumber:(NSInteger) number button:(CardBottonButton*) btn {
    if (btn == nil) {
        return;
    }
    for (id object in btn.subviews) {
        if ([object isKindOfClass:[PopView class]]) {
            [((PopView*)object) showPopNumber:number];
            break;
        }
    }
}


@end
