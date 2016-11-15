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
#import "PictureCellImg.h"


@interface LocalFileSystem ()

@property (nonatomic, weak) UIButton* saveBtn;
@property (nonatomic, assign) ListType selectedList;
///保存图片cell数据
@property (nonatomic, strong) NSMutableArray* saveImgArray;
///保存文件cell数据
@property (nonatomic, strong) NSMutableArray* saveDocumentArray;
///保存其他cell数据
@property (nonatomic, strong) NSMutableArray* saveOtherArray;

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
    self.saveImgArray = [[NSMutableArray alloc] init];
    self.selectedList = Type_Document;
    self.tableView_m.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.saveDocumentArray = [[NSMutableArray alloc] init];
    self.saveOtherArray = [[NSMutableArray alloc] init];
    
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
    
    NSArray* titles = @[@"文件",@"图片",@"其他"];
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

    [self.tableView_m reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedList == Type_Document) {
        if (indexPath.row == 0) {
            return 50+10;
        } else {
            return 50;
        }
    } else if (self.selectedList == Type_Picture) {
        if (indexPath.row == 0) {
            return ([ToolFuncation screenSize].width-10)/4+5;
        } else {
            return ([ToolFuncation screenSize].width-10)/4;
        }
    } else if (self.selectedList == Type_Other) {
        if (indexPath.row == 0) {
            return 50+10;
        } else {
            return 50;
        }
    }
    return 0;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString* cell_string = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cell_string];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_string];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = NO;
    }
    
    return cell;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.selectedList == Type_Document) {
        DocumentCell* newCell = nil;
        if (self.saveDocumentArray.count <= indexPath.row) {
            newCell = [[[NSBundle mainBundle] loadNibNamed:@"DocumentCell" owner:self options:nil] objectAtIndex:0];
            [self.saveDocumentArray addObject:newCell];
        } else {
            newCell = [self.saveDocumentArray objectAtIndex:indexPath.row];
        }
        [cell.contentView addSubview:newCell];
        if (indexPath.row == 0) {
            [newCell setFrame:CGRectMake(0, 10, self.tableView_m.frame.size.width, cell.frame.size.height-10)];
        } else {
            [newCell setFrame:CGRectMake(0, 0, self.tableView_m.frame.size.width, cell.frame.size.height)];
        }
    } else if (self.selectedList == Type_Picture) {
        PictureCellImg* img = nil;
        for (NSInteger a = indexPath.row*4; a < indexPath.row*4+4; a ++) {
            if (self.saveImgArray.count <= a) {
                img = [[PictureCellImg alloc] initWithFrame:CGRectMake(0, 0, ([ToolFuncation screenSize].width-10)/4, ([ToolFuncation screenSize].width-10)/4)];
                [self.saveImgArray addObject:img];
            } else {
                img = [self.saveImgArray objectAtIndex:a];
            }
            [cell.contentView addSubview:img];
            if (indexPath.row == 0) {
                [img setFrame:CGRectMake((img.frame.size.width)*(a%4)+5, 5, img.frame.size.width, img.frame.size.height)];
            } else {
                [img setFrame:CGRectMake((img.frame.size.width)*(a%4)+5, 0, img.frame.size.width, img.frame.size.height)];
            }
        }
    } else if (self.selectedList == Type_Other) {
    
    }
}

-(void) tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    for (UIView* object in cell.contentView.subviews) {
        [object removeFromSuperview];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
