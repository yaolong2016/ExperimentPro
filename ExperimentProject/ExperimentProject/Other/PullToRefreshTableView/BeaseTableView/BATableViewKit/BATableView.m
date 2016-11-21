//
//  ABELTableView.m
//  ABELTableViewDemo
//
//  Created by abel on 14-4-28.
//  Copyright (c) 2014年 abel. All rights reserved.
//

#import "BATableView.h"
#import "BATableViewIndex.h"
#import <objc/runtime.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface BATableView()<BATableViewIndexDelegate>
@property (nonatomic, strong) UILabel * flotageLabel;
@property (nonatomic, strong) BATableViewIndex * tableViewIndex;

@property (nonatomic, assign) BOOL header;
@property (nonatomic, assign) BOOL footer;

@end

@implementation BATableView
@synthesize setSeparatorColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.header = NO;
        self.footer = NO;
        [self initWithContent];
    }
    return self;
}

- (void) initWithContent {
    if (self.tableView == nil) {
        self.tableView = [[PullToRefreshTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [self.tableView setHeadAndFooter:self.header footerView:self.footer];
        self.tableView.separatorColor = self.setSeparatorColor;
        [self addSubview:self.tableView];
        
        self.tableViewIndex = [[BATableViewIndex alloc] initWithFrame:(CGRect){SCREEN_WIDTH-20,0,20,self.frame.size.height}];
        [self.tableViewIndex setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.tableViewIndex];
        self.flotageLabel = [[UILabel alloc] initWithFrame:(CGRect){(SCREEN_WIDTH- 64 ) / 2,(self.bounds.size.height - 64) / 2,64,64}];
        self.flotageLabel.backgroundColor = RGB(18, 29, 45, 0.9);
        self.flotageLabel.hidden = YES;
        self.flotageLabel.textAlignment = NSTextAlignmentCenter;
        self.flotageLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.flotageLabel];
        
        if ((self.tableView.delegate == nil)&&(_delegate)) {
            [self setDelegate:_delegate];
        }
        
    }
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self initWithContent];
    
}

- (void)setDelegate:(id<BATableViewDelegate>)delegate
{
    _delegate = delegate;
    if (self.tableView) {
        [self.tableView initHeaderAndFooter:self.frame.size];
        self.tableView.delegate = delegate;
        self.tableView.dataSource = delegate;
        if ([self.delegate respondsToSelector:@selector(sectionIndexTitlesForABELTableView:)]) {
            self.tableViewIndex.indexes = [self.delegate sectionIndexTitlesForABELTableView:self];
        }
        [self.tableViewIndex reloadLayout:self.tableView.contentInset];
        self.tableViewIndex.tableViewIndexDelegate = self;
    }
}

- (void)reloadData
{
    [self.tableView reloadData];
    if ([self.delegate respondsToSelector:@selector(sectionIndexTitlesForABELTableView:)]) {
        self.tableViewIndex.indexes = [self.delegate sectionIndexTitlesForABELTableView:self];
    }
    [self.tableViewIndex reloadLayout:self.tableView.contentInset];
    self.tableViewIndex.tableViewIndexDelegate = self;
}

- (void)hideFlotage
{
    self.flotageLabel.hidden = YES;
}

#pragma mark - BATableViewIndex
- (void)tableViewIndex:(BATableViewIndex *)tableViewIndex didSelectSectionAtIndex:(NSInteger)index withTitle:(NSString *)title
{
    
    if (index > -1){   // for safety, should always be YES
        for (NSInteger i = 0; i < [self.delegate numberOfSectionsInTableView:self]; i++) {
            if ([self.delegate respondsToSelector:@selector(titleString:)]) {
                if ([[self.delegate titleString:i] isEqualToString:title]) {
                    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]
                                          atScrollPosition:UITableViewScrollPositionTop
                                                  animated:NO];
                    break;
                }
            }
        }
        self.flotageLabel.text = title;
    }
}

- (void)tableViewIndexTouchesBegan:(BATableViewIndex *)tableViewIndex
{
    self.flotageLabel.hidden = NO;
}

- (void)tableViewIndexTouchesEnd:(BATableViewIndex *)tableViewIndex
{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [self.flotageLabel.layer addAnimation:animation forKey:nil];
    
    self.flotageLabel.hidden = YES;
}

- (NSArray *)tableViewIndexTitle:(BATableViewIndex *)tableViewIndex
{
    if ([self.delegate respondsToSelector:@selector(sectionIndexTitlesForABELTableView:)]) {
        return [self.delegate sectionIndexTitlesForABELTableView:self];
    }
    return nil;
}


//添加
-(void)beginUpdates{

    [self.tableView beginUpdates];

}

-(void)endUpdates{

    [self.tableView endUpdates];
}

- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{

    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];

}

- (void) setTableViewHeaderViewAndFooterView:(BOOL) heads footerView:(BOOL) Fview {
    self.header = heads;
    self.footer = Fview;
    
    [self.tableView setHeadAndFooter:self.header footerView:self.footer];
    
    
}

@end


///tableviewcell

@interface UITableView()

@property (nonatomic, weak) NSArray* rowActions;

- (void) setRowActions:(NSArray *)rowActions;

- (NSArray*) rowActions;

@end

static const char keyRow = 'b';

@implementation UITableView(Ex)

- (NSArray*) selfdefineTableViewCell:(NSArray*) titles
                              colors:(NSArray*) color
                              hander:(void (^)(UITableViewRowAction *action, NSIndexPath *indexPath))handler {
    NSMutableArray* array = nil;
    if (titles) {
        if (titles.count) {
            array = [NSMutableArray array];
        }
    }
    for (NSString* title in titles) {
        UITableViewRowAction* tablerow = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                            title:title
                                                                          handler:handler];
        [tablerow setAddIndex:[titles indexOfObject:title]];
        [tablerow setBackgroundColor:[color objectAtIndex:[titles indexOfObject:title]]];
        [array addObject:tablerow];
    }
    
    self.rowActions = array;
    
    return array;
}

- (void) selfdefineTableViewRowButtonColor:(NSArray*) colors {
    if (colors) {
        if (colors.count) {
            for (UITableViewRowAction* tvra in self.rowActions) {
                UIColor* color = [colors objectAtIndex:[self.rowActions indexOfObject:tvra]];
                [tvra setBackgroundColor:color];
            }
        }
    }
    
}

- (void) selfdefineTableViewRowButtonTitle:(NSArray*) titls {
    if (titls) {
        if (titls.count) {
            for (UITableViewRowAction* tvra in self.rowActions) {
                [tvra setTitle:[titls objectAtIndex:[self.rowActions indexOfObject:tvra]]];
            }
        }
    }
}

- (void) selfdefineTableViewRowButtonEffects:(NSArray*) effects {
    if (effects) {
        if (effects.count) {
            for (UITableViewRowAction* tvra in self.rowActions) {
                [tvra setBackgroundEffect:[effects objectAtIndex:[self.rowActions indexOfObject:tvra]]];
            }
        }
    }
}

- (void) setRowActions:(NSArray *)rowActions {
    objc_setAssociatedObject(self, &keyRow, rowActions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray*) rowActions {
    return objc_getAssociatedObject(self, &keyRow);
}

@end

static const char keyAddIndex = 'a';

@implementation UITableViewRowAction(EXTABLEROW)

@dynamic addIndex;

- (void) setAddIndex:(NSInteger) indexs {
    objc_setAssociatedObject(self, &keyAddIndex, [NSNumber numberWithInteger:indexs], OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger) addIndex {
    NSNumber* number = objc_getAssociatedObject(self, &keyAddIndex);
    if (number) {
        return [number integerValue];
    } else {
        return -1;
    }
}

@end

