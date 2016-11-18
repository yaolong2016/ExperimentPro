//
//  YCGeRenTableViewController.m
//  ExperimentProject
//
//  Created by YJM on 2016/11/17.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "YCGeRenTableViewController.h"
#import "DefineTool.h"
#import "ToolFuncation.h"
#import "GeRenTableViewCell.h"
#import "LocalFileSystem.h"


@interface YCGeRenTableViewController ()
{
    UIImageView *touXiangImageView;
    UILabel *nameLab;
    UILabel *IDLab;
    
    UILabel *shouJiNumLab;
}
@end

@implementation YCGeRenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
//    self.tableView.backgroundColor = [UIColor yellowColor];
//    self.tableView.frame = CGRectMake(, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
//    self.tableView.bounces = NO;
    [self setHeaderView];
    [self setFooterViewForTableView];
    
}

- (void)setHeaderView{
    UIView *bgViewOfHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT / 3.0)];
//    bgViewOfHeader.backgroundColor = [UIColor grayColor];
    self.tableView.tableHeaderView = bgViewOfHeader;
    
    ///背景图
    UIImageView *bgImageViewOfHeader = [[UIImageView alloc]initWithImage:GetImage(@"lxrxq-lan-bg")];
    bgImageViewOfHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT / 3.0 );
    [bgViewOfHeader addSubview:bgImageViewOfHeader];
    
    ///头像设置
    touXiangImageView = [[UIImageView alloc]initWithImage:GetImage(@"lxrxq-tx-mr")];
//    touXiangImageView.backgroundColor = [UIColor redColor];
    touXiangImageView.bounds = CGRectMake(0, 0, SCREENH_HEIGHT / 8.0, SCREENH_HEIGHT / 8.0);
    touXiangImageView.center = CGPointMake(SCREEN_WIDTH / 2.0, SCREENH_HEIGHT / 6.0 );
    ViewBorderRadius(touXiangImageView, SCREENH_HEIGHT / 16.0, 2, RGBA(255, 255, 255, 0.7));
    [bgViewOfHeader addSubview:touXiangImageView];
    
    ///姓名的Lab
    nameLab = [[UILabel alloc]init];
    nameLab.bounds= CGRectMake(0, 0, SCREEN_WIDTH - 40, 25);
    nameLab.center = CGPointMake(SCREEN_WIDTH / 2.0, touXiangImageView.frame.origin.y + touXiangImageView.bounds.size.height + 15);
    nameLab.font = [UIFont systemFontOfSize:14];
    nameLab.text = @"杨杨杨杨杨杨杨杨杨杨杨杨杨杨杨";
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.textColor = [UIColor whiteColor];
    [bgViewOfHeader addSubview:nameLab];
    
    ///IDLab 的text 要拼接@"ID:"
    IDLab = [[UILabel alloc]init];
    IDLab.bounds =CGRectMake(0, 0, SCREEN_WIDTH - 40, 20);
    IDLab.center = CGPointMake(SCREEN_WIDTH / 2.0, nameLab.center.y + 15);
    IDLab.textAlignment = NSTextAlignmentCenter;
    IDLab.font = [UIFont systemFontOfSize:10];
    IDLab.textColor = [UIColor whiteColor];
    IDLab.text = @"ID:2222222222222";
    [bgViewOfHeader addSubview:IDLab];
    
//    ///设置返回按键
//    UIButton *rightBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBackBtn setTitle:@"返回" forState:UIControlStateNormal];
//    [rightBackBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    rightBackBtn.frame = CGRectMake(0, 0, 60, 40);
//    [rightBackBtn addTarget:self action:@selector(rightBackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    rightBackBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//    [bgViewOfHeader addSubview:rightBackBtn];

}

- (void)setFooterViewForTableView{
    UIView *bgViewOfFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    bgViewOfFooter.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = bgViewOfFooter;
    
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.bounds = CGRectMake(0, 0, SCREEN_WIDTH - 60, 44);
    bottomBtn.center = CGPointMake(SCREEN_WIDTH / 2.0, 22);
    [bottomBtn setBackgroundColor:[UIColor redColor]];
    [bottomBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgViewOfFooter addSubview:bottomBtn];
    
}

- (void)bottomBtnClick:(UIButton *)btn{
    NSLog(@"底部按键点击");
}

//- (void)rightBackBtnClick:(UIButton *)btn{
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger num;
    if (section == 0) {
        num = 4;
    }else{
        num = 2;
    }
    return num;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerViewInSection = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    headerViewInSection.backgroundColor = [UIColor clearColor];
    
    UIView *bgView= [[UIView alloc]initWithFrame:CGRectMake(0, 6, SCREEN_WIDTH, 44)];
    bgView.backgroundColor = [UIColor whiteColor];
    [headerViewInSection addSubview:bgView];
    
    if (section == 0) {
        UILabel *shouJiLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 44)];
        shouJiLab.font = [UIFont systemFontOfSize:14];
        shouJiLab.text = @"手机号";
        shouJiLab.textColor = [UIColor blackColor];
        [bgView addSubview:shouJiLab];
        
        shouJiNumLab = [[UILabel alloc]initWithFrame:CGRectMake(130, 0, SCREEN_WIDTH - 15 - 130, 44)];
        shouJiNumLab.font = [UIFont systemFontOfSize:14];
        shouJiNumLab.text = @"12345678901";
        shouJiNumLab.textAlignment = NSTextAlignmentRight;
        shouJiNumLab.textColor = [UIColor blackColor];
        [bgView addSubview:shouJiNumLab];
    }else{
        UILabel *shouJiLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 44)];
        shouJiLab.font = [UIFont systemFontOfSize:14];
        shouJiLab.text = @"参与项目";
        shouJiLab.textColor = [UIColor blackColor];
        [bgView addSubview:shouJiLab];
    }
    
    return headerViewInSection;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat height_m = 0.0;
    if (section == 1) {
        height_m = 12;
    }
    return height_m;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerViewInSection;
    if (section == 1) {
        footerViewInSection = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 6)];
        footerViewInSection.backgroundColor = [UIColor clearColor];
    }
    return footerViewInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *cellIdentifier1 = @"geRenCell1";
//    static NSString *cellIdentifier2 = @"geRenCell2";
//    static NSString *cellIdentifier3 = @"geRenCell3";
    
    GeRenTableViewCell *cell;
    if (indexPath.section == 0) {
        
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GeRenTableViewCell" owner:self options:nil] firstObject];
        cell.lab.text = [NSString stringWithFormat:@"%d",indexPath.row];
        
    }else{
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GeRenTableViewCell" owner:self options:nil] objectAtIndex:1];
//        cell.touXiangImageView.backgroundColor = [UIColor redColor];
//        cell.jueSeImageView.backgroundColor = [UIColor blueColor];
    }
    
    
    
    return cell;
}





// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"one-px"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    [ToolFuncation controlNavigationHideShow:YES controller:self];
//    [ToolFuncation controlStatusShow:YES animation:NO];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = ColorWithRGB(BlueColor);

//    [ToolFuncation controlNavigationHideShow:NO controller:self];
}

@end
