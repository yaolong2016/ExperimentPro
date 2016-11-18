//
//  DaiChuLiViewController.m
//  ExperimentProject
//
//  Created by YJM on 2016/11/18.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "DaiChuLiViewController.h"
#import "DefineTool.h"
#import "LocalFileSystem.h"
#import "DaiChuLiTableViewCell.h"
@interface DaiChuLiViewController ()
{
    NSInteger topBtnIndex;
    UIView *btnBlueView;
    
    UITableView *tabView_0;
    UITableView *tabView_1;
    UITableView *tabView_2;
    UITableView *tabView_3;
}
@end

@implementation DaiChuLiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBtnBlueViewWithIndex:0];
    topBtnIndex = 0;
    self.shenQingBtn.selected = YES;
    [self setLocalText];
    [self setBottomScrollViewAndTableView];
    
    
}
///设置国际化汉字
- (void)setLocalText{
    self.title = NSLocalizedString(@"待处理", nil);
    self.searchBar.placeholder = NSLocalizedString(@"搜索", nil);
    [self.shenQingBtn setTitle:NSLocalizedString(@"申请", nil) forState:UIControlStateNormal];
    [self.huiBaoBtn setTitle:NSLocalizedString(@"汇报", nil) forState:UIControlStateNormal];
    [self.zhiShiBtn setTitle:NSLocalizedString(@"指示", nil) forState:UIControlStateNormal];
    [self.qiTaBtn setTitle:NSLocalizedString(@"其它", nil) forState:UIControlStateNormal];
    
}

///设置scrollview
- (void)setBottomScrollViewAndTableView{
    self.bottomScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 4, SCREENH_HEIGHT - 64 - 44 - 44 - 5);
    self.bottomScrollView.showsHorizontalScrollIndicator = NO;
    self.bottomScrollView.pagingEnabled = YES;
    self.bottomScrollView.delegate = self;
    
    tabView_0 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT- 64 - 44 - 44 - 5) style:UITableViewStylePlain];
    tabView_0.delegate = self;
    tabView_0.dataSource = self;
    [self.bottomScrollView addSubview:tabView_0];
    
    tabView_1 = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREENH_HEIGHT- 64 - 44 - 44 - 5) style:UITableViewStylePlain];
    tabView_1.delegate = self;
    tabView_1.dataSource = self;
    [self.bottomScrollView addSubview:tabView_1];
    
    tabView_2 = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, SCREENH_HEIGHT- 64 - 44 - 44 - 5) style:UITableViewStylePlain];
    tabView_2.delegate = self;
    tabView_2.dataSource = self;
    [self.bottomScrollView addSubview:tabView_2];
    
    tabView_3 = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 3, 0, SCREEN_WIDTH, SCREENH_HEIGHT- 64 - 44 - 44 - 5) style:UITableViewStylePlain];
    tabView_3.delegate = self;
    tabView_3.dataSource = self;
    [self.bottomScrollView addSubview:tabView_3];
    
    
    
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"DaiChuLiCell";
    DaiChuLiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DaiChuLiTableViewCell" owner:self options:nil] firstObject];
    }
    
    if ([tableView isEqual:tabView_0]) {
        cell.titleLab.text = @"加入申请";
        cell.touXiangImageView.backgroundColor = [UIColor blueColor];
        cell.detailLab.text = @"你收到申请申请阿打算打算打打打";
    }else if([tableView isEqual:tabView_1]){
        cell.titleLab.text = @"汇报";
        cell.touXiangImageView.backgroundColor = [UIColor redColor];
        cell.detailLab.text = @"你收到申请申请阿打算打算打打打";
    }else if([tableView isEqual:tabView_2]){
        cell.titleLab.text = @"指示";
        cell.touXiangImageView.backgroundColor = [UIColor yellowColor];
        cell.detailLab.text = @"你收到申请申请阿打算打算打打打";
    }else if([tableView isEqual:tabView_3]){
        cell.titleLab.text = @"其它";
        cell.touXiangImageView.backgroundColor = [UIColor grayColor];
        cell.detailLab.text = @"你收到申请申请阿打算打算打打打";
    }
    
    return cell;
}

- (void)setBtnBlueViewWithIndex:(NSInteger )index{
    btnBlueView = [[UIView alloc]initWithFrame:CGRectMake(index * SCREEN_WIDTH / 4.0, 42, SCREEN_WIDTH / 4.0, 2)];
    btnBlueView.backgroundColor = ColorWithRGB(BlueColor);
    [self.bgViewOfBtn addSubview:btnBlueView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

///按键tag 为 500~503
- (IBAction)topBtnClick:(UIButton *)sender {
    topBtnIndex = sender.tag - 500;
    [self.bottomScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * topBtnIndex, 0) animated:YES];
//    [self moveBtnBottomViewWithIndex:topBtnIndex];
    
}
///移动指示条
- (void)moveBtnBottomViewWithIndex:(NSInteger )index{
    
    for(int i = 500; i < 504; i ++){
        UIButton *btn = (UIButton *)[self.view viewWithTag:i];
        if (i == index + 500) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:10 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseOut animations:^{
        btnBlueView.frame = CGRectMake(index * SCREEN_WIDTH / 4.0, 42, SCREEN_WIDTH / 4.0, 2);
    } completion:nil];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self moveBtnBottomViewWithIndex:scrollView.contentOffset.x / SCREEN_WIDTH];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchBar endEditing:YES];
}
@end
