//
//  SecViewController.m
//  转场动画
//
//  Created by 赖天翔 on 16/3/24.
//  Copyright © 2016年 赖天翔. All rights reserved.
//

#import "SecViewController.h"
#import "TransitionFromSecondToFirst.h"
@interface SecViewController ()<UINavigationControllerDelegate>


@end

@implementation SecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.thing.image;
////    UIView * casd = [self.navigationController.navigationBar snapshotViewAfterScreenUpdates:NO];
////    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
//    casd.frame = CGRectMake(0, 200, 166, 166);
//    [self.view addSubview:casd];
    
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Set outself as the navigation controller's delegate so we're asked for a transitioning object
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Stop being the navigation controller's delegate
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    // Check if we're transitioning from this view controller to a DSLFirstViewController
   
        return [[TransitionFromSecondToFirst alloc] init];
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
