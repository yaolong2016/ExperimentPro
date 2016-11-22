//
//  DaiChuLiModelView.h
//  ExperimentProject
//
//  Created by YJM on 2016/11/21.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSUInteger, ViewType) {
    ViewTypeShenQing    =  0,
    ViewTypeHuiBao  =  1,
    ViewTypeZhiShi = 2,
    ViewTypeQiTa  = 3
};
@interface DaiChuLiViewModel : UIView

+ (DaiChuLiViewModel *)instanceDaiChuLiViewModel;

@property (nonatomic, assign)ViewType viewType;

@property (nonatomic, strong)UIImage *touXiangImg;

@property (nonatomic, strong)NSString *daiChuLiNameStr;

@property (nonatomic, strong)NSString *xiangMuNameStr;

@property (nonatomic, strong)NSString *shiXiangStr;

@property (nonatomic, strong)NSString *leiRongStr;

@property (nonatomic, strong)NSString *caoSongStr;

@property (nonatomic, strong)NSArray *imageArr;

@property (nonatomic, strong)NSString *timeStr;

@property (nonatomic, strong)NSString *wenJianNameStr;

@property (weak, nonatomic) IBOutlet UIImageView *touXiangImageView;

@property (weak, nonatomic) IBOutlet UILabel *daiChuLiNameLab;

@property (weak, nonatomic) IBOutlet UILabel *timelab;

@property (weak, nonatomic) IBOutlet UILabel *resultLab;

@property (weak, nonatomic) IBOutlet UILabel *xiangMuNameLeftLab;
@property (weak, nonatomic) IBOutlet UILabel *xiangMuNameLab;

@property (weak, nonatomic) IBOutlet UILabel *shiXiangLeftLab;
@property (weak, nonatomic) IBOutlet UILabel *shiXiangLab;

@property (weak, nonatomic) IBOutlet UILabel *leiRongLeftLab;
@property (weak, nonatomic) IBOutlet UILabel *leiRongLab;

@property (weak, nonatomic) IBOutlet UILabel *chaoSongLeftLab;
@property (weak, nonatomic) IBOutlet UILabel *chaoSongLab;

@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;

@property (weak, nonatomic) IBOutlet UIButton *wenJianBtn;
- (IBAction)wenJianBtnClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *bottomBigBtn;
- (IBAction)bottomBigBtnClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *bottomBtnBgView;
@property (weak, nonatomic) IBOutlet UIButton *bottomRightBtn;
@property (weak, nonatomic) IBOutlet UIButton *bottomLeftBtn;

- (IBAction)bottomRightBtnClick:(UIButton *)sender;
- (IBAction)bottomLeftBtnClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *caoSongTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *caoSongHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgeScrollHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgeScrollTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomBgViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shiXiangTop;

@end
