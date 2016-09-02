//
//  SecViewController.h
//  转场动画
//
//  Created by 赖天翔 on 16/3/24.
//  Copyright © 2016年 赖天翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSLThing.h"
@interface SecViewController : UIViewController
@property (nonatomic,strong)DSLThing * thing;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
