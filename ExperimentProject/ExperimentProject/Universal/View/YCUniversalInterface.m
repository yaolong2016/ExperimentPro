//
//  YCUniversalInterface.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/11.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "YCUniversalInterface.h"
#import "DefineTool.h"
@interface YCUniversalInterface ()<UIScrollViewDelegate>
{
    ///是否有实验 yes为有 no为没有
    BOOL isHaveShiYan;
    ///下部实验管理与实验工作的切换,yes为实验管理
    BOOL isShiyanGuanLi;
    UIView *bottonYellowView;
}
@end

@implementation YCUniversalInterface

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 40.0f)];//初始化图片视图控件
    imageView.contentMode = UIViewContentModeScaleAspectFit;//设置内容样式,通过保持长宽比缩放内容适应视图的大小,任何剩余的区域的视图的界限是透明的。
    UIImage *image = GetImage(@"labpoo");//初始化图像视图
    [imageView setImage:image];
    self.navigationItem.titleView = imageView;//设置导航栏的titleView为imageView
    ///默认实验管理
    isShiyanGuanLi = YES;
    
    [self setNavigationUI];
    [self setUI];
}

- (void)setNavigationUI{
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *erWeiMaBarItem = [[UIBarButtonItem alloc]initWithImage:GetImage(@"erweima") style:UIBarButtonItemStylePlain target:self action:@selector(erWeiMaBtnClick)];
    UIBarButtonItem *shouSuoBarBtn = [[UIBarButtonItem alloc]initWithImage:GetImage(@"搜索") style:UIBarButtonItemStylePlain target:self action:@selector(shouSuoBtnBtnClick)];
    if(isHaveShiYan){
        self.navigationItem.rightBarButtonItems = @[erWeiMaBarItem,shouSuoBarBtn];
    }else{
        self.navigationItem.rightBarButtonItems = @[erWeiMaBarItem];
    }
    UIBarButtonItem *geRenBarItem = [[UIBarButtonItem alloc]initWithImage:GetImage(@"grzx") style:UIBarButtonItemStylePlain target:self action:@selector(geRenBtnClick)];
    self.navigationItem.leftBarButtonItem = geRenBarItem;
}

- (void)setUI{
    [self.guanLiBtn setTitle:NSLocalizedString(@"实验管理", nil) forState:UIControlStateNormal];
    [self.shiYanBtn setTitle:NSLocalizedString(@"实验工作", nil) forState:UIControlStateNormal];
    [self.sheJiShiYanButton setTitle:NSLocalizedString(@"实验设计", nil) forState:UIControlStateNormal];
    
    bottonYellowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2.0, 2)];
    bottonYellowView.backgroundColor = ColorWithRGB(0xf9b52f);
    [self.btnBottomView addSubview:bottonYellowView];
    
    [self setJiuGongGeAnLiu];
}

///部署九宫格按键
- (void)setJiuGongGeAnLiu{
    
    self.jiuGongGeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, self.jiuGongGeScrollView.bounds.size.height);
    self.jiuGongGeScrollView.pagingEnabled = YES;
    self.jiuGongGeScrollView.delegate = self;
    UIView *contentView_GuanLi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.jiuGongGeScrollView.bounds.size.width, self.jiuGongGeScrollView.bounds.size.height)];
    [self.jiuGongGeScrollView addSubview:contentView_GuanLi];
    
    UIView *contentView_KeYan = [[UIView alloc]initWithFrame:CGRectMake(self.jiuGongGeScrollView.bounds.size.width, 0, self.jiuGongGeScrollView.bounds.size.width, self.jiuGongGeScrollView.bounds.size.height)];
    [self.jiuGongGeScrollView addSubview:contentView_KeYan];
    
    
    float width = 50;//格子的宽
    float height = 50;//格子的高
    
    NSArray *shiYanGuanLiTitleArr = @[@"经费管理",@"团队管理",@"流程管理",@"进度管理",@"待处理",@"指示"];
    NSArray *shiYanGongZuoTitleArr = @[@"日程",@"耗材",@"申请",@"汇报",@"资源",@"资料",@"消息"];
    
    
    if (isShiyanGuanLi) {
        for (int i = 0; i < 6; i ++) {
            float marginX = (SCREEN_WIDTH - 40*2 - 3*width)/2.0;//X间隙
            float marginY = 10;//Y间隙

            int row = i/3;
            int col = i%3;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(40+col*(width+marginX), 5+row*(height+marginY), width, height);
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"zonghe_guanli%d",i + 1]] forState:UIControlStateNormal];
            btn.tag = 200 + i;
            [btn addTarget:self action:@selector(jiuGongGeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [contentView_GuanLi addSubview:btn];
            
            UILabel *lab = [[UILabel alloc]init];
            lab.bounds = CGRectMake(0, 0, 100, 20);
            lab.center = CGPointMake(btn.center.x, btn.center.y + btn.bounds.size.width/2.0 + 4);
            lab.font = [UIFont systemFontOfSize:12];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.textColor = ColorWithRGB(0x515151);
            NSString *textStr = [NSString stringWithFormat:@"%@",shiYanGuanLiTitleArr[i]];
            lab.text = NSLocalizedString(textStr, nil);
            [contentView_GuanLi addSubview:lab];
        }
    }else{
        for (int i = 0; i < 7; i ++) {
            float marginX = (SCREEN_WIDTH - 20*2 - 4*width)/2.0;//X间隙
            float marginY = 10;//Y间隙
            
            int row = i/4;
            int col = i%4;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(40+col*(width+marginX), 5+row*(height+marginY), width, height);
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"zonghe_guanli%d",i + 1]] forState:UIControlStateNormal];
            btn.tag = 300 + i;
            [btn addTarget:self action:@selector(jiuGongGeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [contentView_KeYan addSubview:btn];
            
            UILabel *lab = [[UILabel alloc]init];
            lab.bounds = CGRectMake(0, 0, 100, 20);
            lab.center = CGPointMake(btn.center.x, btn.center.y + btn.bounds.size.width/2.0 + 4);
            lab.font = [UIFont systemFontOfSize:12];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.textColor = ColorWithRGB(0x515151);
            NSString *textStr = [NSString stringWithFormat:@"%@",shiYanGuanLiTitleArr[i]];
            lab.text = NSLocalizedString(textStr, nil);
            [contentView_KeYan addSubview:lab];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x / SCREEN_WIDTH == 1) {
        [self moveYellowBottomViewToRight:YES];
    }else if(scrollView.contentOffset.x / SCREEN_WIDTH == 0){
        [self moveYellowBottomViewToRight:NO];
    }
}

///九宫格按键点击事件btn的tag为:实验管理为200~205  实验工作为300~306
- (void)jiuGongGeBtnClick:(UIButton *)btn{
    NSLog(@"btn的tag")
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

- (void)erWeiMaBtnClick{
    
}

- (void)shouSuoBtnBtnClick{
    
}

- (void)geRenBtnClick{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sheJiShiYanBtnClick:(UIButton *)sender {
}
- (IBAction)shenQingBtnClick:(UIButton *)sender {
}

- (IBAction)cuanJianBtnClick:(UIButton *)sender {
}


- (IBAction)gaunLiBtnClick:(UIButton *)sender {
    if (sender.selected == NO) {
//        sender.selected = YES;
//        self.shiYanBtn.selected = NO;
        [self.jiuGongGeScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [self moveYellowBottomViewToRight:NO];
    }
}

- (IBAction)shiYanBtnClick:(UIButton *)sender {
    if (sender.selected == NO) {
//        sender.selected = YES;
//        self.guanLiBtn.selected = NO;
        [self.jiuGongGeScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
        [self moveYellowBottomViewToRight:YES];
    }
    
}
///移动黄颜色视图
- (void)moveYellowBottomViewToRight:(BOOL)isRight{
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:10 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (isRight) {
            self.guanLiBtn.selected = NO;
            self.shiYanBtn.selected = YES;
            bottonYellowView.frame = CGRectMake(SCREEN_WIDTH/2.0, 0, SCREEN_WIDTH/2.0, 2);
        }else{
            self.guanLiBtn.selected = YES;
            self.shiYanBtn.selected = NO;
            bottonYellowView.frame = CGRectMake(0, 0, SCREEN_WIDTH/2.0, 2);
        }
    } completion:nil];
}

@end
