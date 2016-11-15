//
//  LocalFileSystem.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/14.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "LocalFileSystem.h"
#import "ToolFuncation.h"
#import "DocumentCell.h"



@interface LocalFileSystem ()

@property (nonatomic, weak) UIButton* saveBtn;
@property (nonatomic, assign) ListType selectedList;

@end

@implementation LocalFileSystem
@synthesize topChange_m;
@synthesize tableView_m;
@synthesize selectImg;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:NSLocalizedString(@"选择文件", nil)];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
//    UIButton* backIn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, self.navigationController.navigationBar.frame.size.height)];
//    
//    [backIn setTitle:NSLocalizedString(@"返回", nil) forState:UIControlStateNormal];
//    [backIn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [backIn setImage:[UIImage imageNamed:@"yl_back"] forState:UIControlStateNormal];
//    [backIn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [backIn setBackgroundColor:[UIColor redColor]];
//    
//    UIBarButtonItem* backOut = [[UIBarButtonItem alloc] initWithCustomView:backIn];
//    [self.navigationItem setLeftBarButtonItem:backOut];
    
    NSArray* titles = @[@"文件",@"图片",@"其他文件"];
    for (int a = 0; a < 3; a ++) {
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(a*[ToolFuncation screenSize].width/3,
                                                                   0,
                                                                   [ToolFuncation screenSize].width/3,
                                                                   44)];
        [btn setTitle:[titles objectAtIndex:a] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changeFilesSystem:) forControlEvents:UIControlEventTouchUpInside];
        [self.topChange_m addSubview:btn];
        [btn setTag:a];
        if (a == 0) {
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            self.saveBtn = btn;
        }
    }
    
    self.selectImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 42, [ToolFuncation screenSize].width/3, 2)];
    [self.selectImg setBackgroundColor:[UIColor blueColor]];
    [self.topChange_m addSubview:self.selectImg];
    
}

-(void) changeFilesSystem:(UIButton*) btn {

    if (self.saveBtn) {
        [self.saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.selectImg.frame = CGRectMake(btn.frame.origin.x,
                                                           self.selectImg.frame.origin.y,
                                                           self.selectImg.frame.size.width,
                                                           self.selectImg.frame.size.height);
                     }];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.saveBtn = btn;
    self.selectedList = (ListType)btn.tag;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString* cell_string = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cell_string];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_string];
    }
    
    return cell;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    DocumentCell* newCell = [[[NSBundle mainBundle] loadNibNamed:@"DocumentCell" owner:self options:nil] objectAtIndex:0];
    [newCell setFrame:CGRectMake(0, 0, self.tableView_m.frame.size.width, cell.frame.size.height)];
    [cell.contentView addSubview:newCell];
}

-(void) tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
