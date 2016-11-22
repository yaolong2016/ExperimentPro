//
//  DaiChuLiModelView.m
//  ExperimentProject
//
//  Created by YJM on 2016/11/21.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "DaiChuLiViewModel.h"
#import "DefineTool.h"
@interface DaiChuLiViewModel()
{
    
    
    
}
@end

@implementation DaiChuLiViewModel

- (void)setTouXiangImg:(UIImage *)touXiangImg{
    _touXiangImg = touXiangImg;
    
    ViewBorderRadius(self.touXiangImageView, 30, 0, [UIColor whiteColor]);
    self.touXiangImageView.image = touXiangImg;
}

- (void)setDaiChuLiNameStr:(NSString *)daiChuLiNameStr{
    _daiChuLiNameStr = daiChuLiNameStr;
    self.daiChuLiNameLab.text = daiChuLiNameStr;
}

- (void)setTimeStr:(NSString *)timeStr{
    _timeStr = timeStr;
}

- (void)setViewType:(ViewType)viewType{
    _viewType = viewType;
    
    switch (viewType) {
        case 0:
        {
            self.xiangMuNameLeftLab.text = NSLocalizedString(@"项目名称", nil);
            self.shiXiangLeftLab.text = NSLocalizedString(@"申请事项", nil);
            self.leiRongLeftLab.text = NSLocalizedString(@"申请内容", nil);
            self.bottomBigBtn.hidden = YES;
            [self.bottomLeftBtn setTitle:NSLocalizedString(@"通过", nil) forState:UIControlStateNormal];
            [self.bottomRightBtn setTitle:NSLocalizedString(@"不通过", nil) forState:UIControlStateNormal];
            
        }
            break;
        case 1:
        {
            self.xiangMuNameLeftLab.text = NSLocalizedString(@"汇报项目", nil);
            self.shiXiangLeftLab.text = NSLocalizedString(@"汇报事项", nil);
            self.leiRongLeftLab.text = NSLocalizedString(@"汇报内容", nil);
            self.chaoSongLeftLab.hidden = YES;
            self.chaoSongLab.hidden = YES;
            [self.bottomBigBtn setTitle:NSLocalizedString(@"回复", nil) forState:UIControlStateNormal];
            self.bottomBtnBgView.hidden = YES;
        }
            break;
        case 2:
        {
            self.xiangMuNameLeftLab.text = NSLocalizedString(@"提示项目", nil);
            self.shiXiangLeftLab.text = NSLocalizedString(@"提示事项", nil);
            self.leiRongLeftLab.text = NSLocalizedString(@"提示内容", nil);
            self.chaoSongLeftLab.hidden = YES;
            self.chaoSongLab.hidden = YES;
            [self.bottomBigBtn setTitle:NSLocalizedString(@"回复", nil) forState:UIControlStateNormal];
            self.bottomBtnBgView.hidden = YES;
        }
            break;
        case 3:
        {
            self.xiangMuNameLeftLab.text = NSLocalizedString(@"提示项目", nil);
            self.shiXiangLeftLab.hidden = YES;
            self.leiRongLeftLab.hidden = YES;
            self.imageScrollView.hidden = YES;
            self.wenJianBtn.hidden = YES;
            self.chaoSongLeftLab.hidden = YES;
            self.bottomBigBtn.hidden = YES;
            self.chaoSongLab.hidden  = YES;
            self.shiXiangLab.hidden = YES;
            self.leiRongLab.hidden = YES;
            [self.bottomLeftBtn setTitle:NSLocalizedString(@"同意", nil) forState:UIControlStateNormal];
            [self.bottomRightBtn setTitle:NSLocalizedString(@"忽略", nil) forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
    [self updateConstraints];
    
}

- (void)updateConstraints{
    [super updateConstraints];
    
    switch (self.viewType) {
        case 0:
        {
            
            
        }
            break;
        case 1:case 2:
        {
            self.caoSongHeight.constant = 0.0;
            self.caoSongTop.constant = 0.0;
            self.bottomBgViewTop.constant = 370;
            
        }
            break;
        
        case 3:
        {
            //416 -300
            self.bottomBgViewTop.constant = 150;
            
            
            
        }
            break;
            
        default:
            break;
    }

    
    
}

- (void)setXiangMuNameStr:(NSString *)xiangMuNameStr{
    _xiangMuNameStr = xiangMuNameStr;
    self.xiangMuNameLab.text = xiangMuNameStr;
}

-(void)setShiXiangStr:(NSString *)shiXiangStr{
    _shiXiangStr = shiXiangStr;
    self.shiXiangLab.text = shiXiangStr;
}

- (void)setLeiRongStr:(NSString *)leiRongStr{
    _leiRongStr = leiRongStr;
    self.leiRongLab.text = leiRongStr;
}

- (void)setCaoSongStr:(NSString *)caoSongStr{
    _caoSongStr = caoSongStr;
    self.chaoSongLab.text = caoSongStr;
}

- (void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    self.imageScrollView.contentSize = CGSizeMake((2 + 100) * imageArr.count, 100);
    self.imageScrollView.pagingEnabled = YES;
    //颜色
    self.imageScrollView.backgroundColor = [UIColor redColor];
    
    int num = imageArr.count;
    for (int i = 0; i < num; i++) {
        UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom
                              ];
        imageBtn.frame = CGRectMake((100 + 2) * num, 0, 100, 100);
        //颜色
        imageBtn.backgroundColor = [UIColor greenColor];
        [imageBtn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.imageScrollView addSubview:imageBtn
         ];
        
    }
    
    
}

- (void)imageBtnClick:(UIButton *)btn{
    
}



//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        NSString *className = NSStringFromClass([self class]);
//        self.view = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
//        self.view.backgroundColor = [UIColor redColor];
//        [self addSubview:self.view];
//        return self;
//    }
//    return nil;
//}

- (void)drawRect:(CGRect)rect {
    ViewBorderRadius(self, 4, 0, [UIColor whiteColor]);
    
//    self.view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
//    [self addSubview:self.view];
    
    self.touXiangImageView.backgroundColor  = [UIColor greenColor];
    self.imageScrollView.backgroundColor = [UIColor blueColor];
    
    
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        //you init
    }
    return self;
}


+ (DaiChuLiViewModel *)instanceDaiChuLiViewModel
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"DaiChuLiViewModel" owner:nil options:nil];
    NSLog(@"找到的 nib == %@",nibView);
    return [nibView objectAtIndex:0];
}

- (IBAction)wenJianBtnClick:(UIButton *)sender {
}
- (IBAction)bottomBigBtnClick:(UIButton *)sender {
}
- (IBAction)bottomRightBtnClick:(UIButton *)sender {
}

- (IBAction)bottomLeftBtnClick:(UIButton *)sender {
}
@end
