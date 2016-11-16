//
//  LocalFileSystem.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/14.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "LocalFileSystem.h"
#import "ToolFuncation.h"


@interface LocalFileSystem ()

@property (nonatomic, weak) UIButton* saveBtn;
@property (nonatomic, assign) ListType selectedList;
///保存图片cell数据
@property (nonatomic, strong) NSMutableArray* saveImgArray;
///保存文件cell数据
@property (nonatomic, strong) NSMutableArray* saveDocumentArray;
///保存其他cell数据
@property (nonatomic, strong) NSMutableArray* saveOtherArray;
///保存选择数据
@property (nonatomic, strong) NSMutableSet* saveSelected;
///保存表的头提示
@property (nonatomic, strong) NSMutableArray* saveTitle;

@end

@implementation LocalFileSystem
@synthesize topChange_m;
@synthesize tableView_m;
@synthesize selectImg;
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:NSLocalizedString(@"选择文件", nil)];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.saveImgArray = [[NSMutableArray alloc] init];
    self.selectedList = Type_Document;
    self.tableView_m.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.tableView_m initHeaderAndFooter:[ToolFuncation screenSize]];
    self.saveDocumentArray = [[NSMutableArray alloc] init];
    self.saveOtherArray = [[NSMutableArray alloc] init];
    self.saveSelected = [[NSMutableSet alloc] init];
    self.saveTitle = [[NSMutableArray alloc] init];
    self.delegate = nil;
    
    NSArray* titles = @[NSLocalizedString(@"文件",nil),NSLocalizedString(@"图片",nil),NSLocalizedString(@"其他",nil)];
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
            [btn setTitleColor:ColorWithRGB(BlueColor) forState:UIControlStateNormal];
            self.saveBtn = btn;
            [self saveTableViewFooterText:a proTag:-1];
        }
    }
    
    self.selectImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 42, [ToolFuncation screenSize].width/3, 2)];
    [self.selectImg setBackgroundColor:ColorWithRGB(BlueColor)];
    [self.topChange_m addSubview:self.selectImg];
    ;
    [NSThread detachNewThreadSelector:@selector(updateThread:)
                             toTarget:self
                           withObject:@{@"key":[NSString stringWithFormat:@"%d",k_RETURN_REFRESH],@"index":[NSString stringWithFormat:@"%d",-1]}];
}

#pragma DocumentCellDelegate
-(void) documentCellSelected:(DocumentCell *)object index:(NSInteger)at isSelected:(BOOL)selected {
    if (object.mark == CELL_TYPE_DOCUMENT) {
        if (selected) {
            [self.saveSelected addObject:[self.saveDocumentArray objectAtIndex:at]];
        } else {
            [self.saveSelected removeObject:[self.saveDocumentArray objectAtIndex:at]];
        }
    }else if (object.mark == CELL_TYPE_OTHER) {
        if (selected) {
            [self.saveSelected addObject:[self.saveOtherArray objectAtIndex:at]];
        } else {
            [self.saveSelected removeObject:[self.saveOtherArray objectAtIndex:at]];
        }
    }
}

#pragma PTableView
- (void)updateThread:(NSDictionary *)returnKey{
 sleep(2);
    [self performSelectorOnMainThread:@selector(updateTableView:) withObject:returnKey waitUntilDone:NO];

}

- (void)updateTableView:(NSDictionary*) info{
    NSInteger much = 0;
    NSInteger dataMax = 0;
    if (self.selectedList == Type_Document) {
        much = self.saveDocumentArray.count;
        dataMax = 5;
    } else if (self.selectedList == Type_Picture) {
        much = self.saveImgArray.count;
        dataMax = 21;
    } else if (self.selectedList == Type_Other) {
        much = self.saveOtherArray.count;
        dataMax = 5;
    }
    if (much < dataMax) {
        //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [self.tableView_m reloadData:NO];
    } else {
        //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [self.tableView_m reloadData:YES];
    }
    
    [self saveTableViewFooterText:self.saveBtn.tag proTag:-1];
}

#pragma mark -
#pragma mark Scroll View Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView_m tableViewDidDragging];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSInteger returnKey = [self.tableView_m tableViewDidEndDragging];
    
    //  returnKey用来判断执行的拖动是下拉还是上拖，如果数据正在加载，则返回DO_NOTHING
    if (returnKey != k_RETURN_DO_NOTHING) {
        NSString * key = [NSString stringWithFormat:@"%ld", (long)returnKey];
        [NSThread detachNewThreadSelector:@selector(updateThread:) toTarget:self withObject:@{@"key":key,@"index":[NSString stringWithFormat:@"%d",-1]}];
    }
}

#pragma PictureCellDelegate
-(void) pictureCellImgSelected:(PictureCellImg *)object index:(NSInteger)at isSelected:(BOOL)selected {
    if (selected) {
        [self.saveSelected addObject:[self.saveImgArray objectAtIndex:at]];
    } else {
        [self.saveSelected removeObject:[self.saveImgArray objectAtIndex:at]];
    }
}

-(void) changeFilesSystem:(UIButton*) btn {
    NSInteger ptag = self.saveBtn.tag;
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
    [btn setTitleColor:ColorWithRGB(BlueColor) forState:UIControlStateNormal];
    self.saveBtn = btn;
    self.selectedList = (ListType)btn.tag;

    [self.tableView_m reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    if ([self listHaveData:btn.tag]) {
        [self saveTableViewFooterText:btn.tag proTag:ptag];
    } else {
        [self.tableView_m resetFooterPrompt:NSLocalizedString(@"加载中...", nil)];
        [self saveTableViewFooterText:btn.tag proTag:ptag];
        
        [NSThread detachNewThreadSelector:@selector(updateThread:)
                                 toTarget:self
                               withObject:@{@"key":[NSString stringWithFormat:@"%d",k_RETURN_REFRESH],@"index":[NSString stringWithFormat:@"%d",-1]}];
    }
}
///点击和刷新后都屌用
-(void) saveTableViewFooterText:(NSInteger) tag proTag:(NSInteger) ptag{
    if (self.saveTitle.count == 0) {
        [self.saveTitle addObject:@{@"index":[NSString stringWithFormat:@"%ld",(long)tag],@"prompt":[self.tableView_m headerAndFooterText:NO]}];
    } else {
        BOOL mark = NO;
        for (NSDictionary* info in self.saveTitle) {
            if ([[info objectForKey:@"index"] isEqualToString:[NSString stringWithFormat:@"%ld",(long)tag]]) {
                NSString* currentTitle = [info objectForKey:@"prompt"];
                NSDictionary* dic = @{@"index":[NSString stringWithFormat:@"%ld",(long)tag],@"prompt":(ptag >= 0) ? currentTitle:[self.tableView_m headerAndFooterText:NO]};
                [self.saveTitle removeObject:info];
                [self.saveTitle addObject:dic];
                mark = YES;
                [self.tableView_m resetFooterPrompt:(ptag >= 0) ? currentTitle:[self.tableView_m headerAndFooterText:NO]];
                break;
            }
        }
        
        if (mark==NO) {
            [self.saveTitle addObject:@{@"index":[NSString stringWithFormat:@"%ld",(long)tag],@"prompt":[self.tableView_m headerAndFooterText:NO]}];
        }
        
        if (ptag >= 0) {
            for (NSDictionary* info in self.saveTitle) {
                if ([[info objectForKey:@"index"] isEqualToString:[NSString stringWithFormat:@"%ld",(long)ptag]]) {
                    NSString* prTitle = [info objectForKey:@"prompt"];
                    NSDictionary* dic = @{@"index":[NSString stringWithFormat:@"%ld",(long)ptag],@"prompt":prTitle};
                    [self.saveTitle removeObject:info];
                    [self.saveTitle addObject:dic];
                    break;
                }
            }
        }
        
    }
}

///判断某个列表是否有数据
- (BOOL) listHaveData:(NSInteger) tag {
    for (NSDictionary* info in self.saveTitle) {
        if ([[info objectForKey:@"index"] isEqualToString:[NSString stringWithFormat:@"%ld",(long)tag]]) {
            return YES;
        }
    }
    return NO;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger much = 0;
    if (self.selectedList == Type_Document) {
        much = 5;
    } else if (self.selectedList == Type_Picture) {
        much = 5;
    } else if (self.selectedList == Type_Other) {
       much = 5;
    }
    
    if (much == 0) {
        //  本方法是为了在数据未空时，让“下拉刷新”视图可直接显示，比较直观
        self.tableView_m.contentInset = UIEdgeInsetsMake(k_STATE_VIEW_HEIGHT, 0, 0, 0);
    }
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
            newCell.tag = indexPath.row;
            newCell.mark = CELL_TYPE_DOCUMENT;
            newCell.delegate = self;
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
                img.tag = a;
                img.delegate = self;
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
        DocumentCell* newCell = nil;
        if (self.saveOtherArray.count <= indexPath.row) {
            newCell = [[[NSBundle mainBundle] loadNibNamed:@"DocumentCell" owner:self options:nil] objectAtIndex:0];
            newCell.tag = indexPath.row;
            newCell.mark = CELL_TYPE_OTHER;
            newCell.delegate = self;
            [self.saveOtherArray addObject:newCell];
        } else {
            newCell = [self.saveOtherArray objectAtIndex:indexPath.row];
        }
        [cell.contentView addSubview:newCell];
        if (indexPath.row == 0) {
            [newCell setFrame:CGRectMake(0, 10, self.tableView_m.frame.size.width, cell.frame.size.height-10)];
        } else {
            [newCell setFrame:CGRectMake(0, 0, self.tableView_m.frame.size.width, cell.frame.size.height)];
        }
    }
}

-(void) tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    for (UIView* object in cell.contentView.subviews) {
        [object removeFromSuperview];
    }
}


- (IBAction) confiromSelected:(id) btn {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(confiromLocalFileSystemSelected:data:)]) {
            [self.delegate confiromLocalFileSystemSelected:self data:self.saveSelected];
        }
    }
    [self removeAllData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) removeAllData {
    if (self.saveSelected)
    [self.saveSelected removeAllObjects];
    if (self.saveTitle)
    [self.saveTitle removeAllObjects];
    if (self.saveImgArray)
    [self.saveImgArray removeAllObjects];
    if (self.saveOtherArray)
    [self.saveOtherArray removeAllObjects];
    if (self.saveDocumentArray)
    [self.saveDocumentArray removeAllObjects];
    self.selectImg = nil;
    self.saveSelected = nil;
    self.saveTitle = nil;
    self.saveImgArray = nil;
    self.saveOtherArray = nil;
    self.saveDocumentArray = nil;
    self.topChange_m = nil;
    self.delegate = nil;
}

-(void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self removeAllData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
