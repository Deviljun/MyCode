//
//  AppDelegate.h
//  转场动画
//
//  Created by 赖天翔 on 16/3/24.
//  Copyright © 2016年 赖天翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong)UINavigationController * navi;
@property (nonatomic,strong)FirstViewController * firstVC;

@end

