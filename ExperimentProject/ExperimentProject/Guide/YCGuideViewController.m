//
//  YCGuideViewController.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/11.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "YCGuideViewController.h"
#import "ToolFuncation.h"
#import "DefineTool.h"
#import "ViewController.h"

@interface YCGuideViewController ()<UIScrollViewDelegate>
{
    UIPageControl *pageControl;
}
@end

@implementation YCGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initGuide];
}

- (void)initGuide{
        
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 4, SCREENH_HEIGHT);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    
    for(int i=0;i<4;i++){
        UIImageView *imageView= [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"引导页_%d",i+1]]];
        imageView.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREENH_HEIGHT);
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
    }
    [self.view addSubview:scrollView];
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 0.4 * SCREEN_WIDTH) / 2.0,SCREENH_HEIGHT -  SCREENH_HEIGHT * 0.2, 0.4 * SCREEN_WIDTH, 50)];
    pageControl.numberOfPages = 4;
    pageControl.pageIndicatorTintColor = RGB(29, 129, 227);
    [self.view addSubview:pageControl];
    
    UIButton *aBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [aBtn setTitle:NSLocalizedString(@"跳过", nil) forState:UIControlStateNormal];
    [aBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    aBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    aBtn.frame = CGRectMake(SCREEN_WIDTH - 70, 25, 44, 44);
    aBtn.backgroundColor = RGBA(158, 183, 205, 0.85);
    ViewBorderRadius(aBtn, 22, 1, [UIColor whiteColor]);
    [aBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aBtn];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    pageControl.currentPage = (NSInteger )(scrollView.contentOffset.x / SCREEN_WIDTH);
}

- (void)btnClick{
    ViewController *VC;
    for (UIViewController *aVC in self.navigationController.viewControllers) {
        if ([aVC isKindOfClass:[ViewController class]]) {
            VC = (ViewController *)aVC;
        }
    }
    [VC removeMainInterfaceViewController];
    [VC loadMainInterfaceController:APP_INTO_LOGINOUT];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [ToolFuncation controlNavigationHideShow:YES controller:self];
    [ToolFuncation controlStatusShow:YES animation:NO];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [ToolFuncation controlNavigationHideShow:YES controller:self];
}

@end
