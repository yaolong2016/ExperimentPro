//
//  YCSettingsViewController.m
//  ExperimentProject
//
//  Created by yaolong on 16/11/11.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "YCSettingsViewController.h"
#import "ViewController.h"
#import "ToolFuncation.h"
#import "AppDelegate.h"

@interface YCSettingsViewController ()

@end

@implementation YCSettingsViewController
@synthesize tableView_m;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(-self.view.frame.size.width,
                                 0, self.view.frame.size.width,
                                 self.view.frame.size.height);
    [self.view setBackgroundColor:[UIColor clearColor]];
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [UIView animateWithDuration:0.25
                                              animations:^{
                                                  [self.view setBackgroundColor:[UIColor colorWithRed:0
                                                                                                green:0
                                                                                                 blue:0
                                                                                                alpha:0.5]];
                                              }
                                              completion:^(BOOL finished) {
                                                  
                                              }];
                         }
                     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         [self.view setBackgroundColor:[UIColor colorWithRed:0
                                                                       green:0
                                                                        blue:0
                                                                       alpha:0]];
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [UIView animateWithDuration:0.25
                                              animations:^{
                                                  self.view.frame = CGRectMake(-self.view.frame.size.width,
                                                                               0,
                                                                               self.view.frame.size.width,
                                                                               self.view.frame.size.height);
                                              }
                                              completion:^(BOOL finished) {
                                                  ViewController* vc = [ToolFuncation getNavigationChildrensController:[ViewController class]
                                                                                                       viewControllers:[ToolFuncation getAppDelegateObject].viewcontroller_m];
                                                  [vc.sets_m.view removeFromSuperview];
                                                  [vc.sets_m removeFromParentViewController];
                                                  vc.sets_m = nil;
                                              }];
                         }
                     }];
    
}

@end
