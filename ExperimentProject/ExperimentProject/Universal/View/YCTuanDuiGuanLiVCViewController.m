//
//  YCTuanDuiGuanLiVCViewController.m
//  ExperimentProject
//
//  Created by YJM on 2016/11/15.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "YCTuanDuiGuanLiVCViewController.h"
#import "DefineTool.h"
#import "YaoQingHaoYouViewController.h"

@interface YCTuanDuiGuanLiVCViewController ()

@end

@implementation YCTuanDuiGuanLiVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"团队管理", nil);
    self.zheZhaoView.hidden = YES;
    self.bgTabView.delegate = self;
    self.bgTabView.dataSource = self;
    
    UIBarButtonItem *addBarBtn = [[UIBarButtonItem alloc]initWithImage:GetImage(@"addpersonopen") style:UIBarButtonItemStylePlain target:self action:@selector(addBarBtnClick:)];
    [addBarBtn setTintColor:[UIColor blackColor]];
    
    
    
    self.navigationItem.rightBarButtonItem = addBarBtn;
    
    [self setAddPersonViewBtnUI];
}
///按键的tag 为400~403
- (void)setAddPersonViewBtnUI{
    float marginY = 20; //Y间隙
    float width = 50;//格子的宽
    float height = 50;//格子的高
    float labAndBtn = 8; //文字与按键的间隙
    NSArray *btnsTitleArr = @[@"扫一扫",@"通讯录添加",@"ID号添加",@"邀请好友"];
    for (int i = 0; i < 4; i ++) {
        float marginX = (SCREEN_WIDTH - 40*2 - 3*width)/2.0;//X间隙
        
        int row = i/3;
        int col = i%3;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(40+col*(width+marginX), marginY/2.0+row*(height+marginY), width, height);
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"addperson%d",i + 1]] forState:UIControlStateNormal];
        btn.tag = 400 + i;
        [btn addTarget:self action:@selector(jiuGongGeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.addPersonView addSubview:btn];
        
        UILabel *lab = [[UILabel alloc]init];
        lab.bounds = CGRectMake(0, 0, 100, 20);
        lab.center = CGPointMake(btn.center.x, btn.center.y + btn.bounds.size.width/2.0 + labAndBtn);
        lab.font = [UIFont systemFontOfSize:12];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = ColorWithRGB(0x515151);
        NSString *textStr = [NSString stringWithFormat:@"%@",btnsTitleArr[i]];
        lab.text = NSLocalizedString(textStr, nil);
        [self.addPersonView addSubview:lab];
    }

}
///按键的tag 为400~403
- (void)jiuGongGeBtnClick:(UIButton *)btn{
    NSLog(@"按键的tag == %d",btn.tag);
    switch (btn.tag) {
        case 400:
        {
            
        }
            break;
        case 401:
        {
            
        }
            break;
        case 402:
        {
            
        }
            break;
        case 403:
        {
            YaoQingHaoYouViewController *yaoQingHaoYouVC_m = [[YaoQingHaoYouViewController alloc]init];
            [self.navigationController pushViewController:yaoQingHaoYouVC_m animated:YES];
        }
            break;
            
        default:
            break;
    }
    
    
}

- (void)addBarBtnClick:(UIBarButtonItem *)btn{
    self.zheZhaoView.hidden = !self.zheZhaoView.hidden;
    if (self.zheZhaoView.hidden) {
        [btn setImage:GetImage(@"addpersonopen")];
    }else{
        [btn setImage:GetImage(@"addpersonclose")];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tuanDuiGuanLiPersonCellIdentifier = @"TuanDuiGuanLiPersonCell";
//
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tuanDuiGuanLiPersonCellIdentifier];
//
    if (cell == nil) {
//
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"YCTuanDuiGuanLiVCViewController" owner:self options:nil];
//        for (NSObject *obj in nib) {
//            if ([obj isKindOfClass:[TuanDuiGuanLiPersonCell class]]) {
//                cell = (TuanDuiGuanLiPersonCell *)obj;
//            }
////            NSLog(@"数组内容 == %@",obj);
//        }
////        cell = [nib objectAtIndex:0];
//        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tuanDuiGuanLiPersonCellIdentifier];
    }
//
//    cell.leftImageView.backgroundColor = [UIColor redColor];
//    cell.rightLab.text = [NSString stringWithFormat:@"%d",indexPath.row];
//    
    return cell;
//    return nil;
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

- (IBAction)bottomCloseBtn:(UIButton *)sender {
    self.zheZhaoView.hidden = YES;
}
@end
