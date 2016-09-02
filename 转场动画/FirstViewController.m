//
//  FirstViewController.m
//  转场动画
//
//  Created by 赖天翔 on 16/3/24.
//  Copyright © 2016年 赖天翔. All rights reserved.
//

#import "FirstViewController.h"
#import "SecViewController.h"
#import "DSLThing.h"
#import "CollectionViewCell.h"
#import "TransitionFromFirstToSecond.h"
#import "CollectionReusableView.h"
@interface FirstViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIView *smallView;

@property (nonatomic,strong)NSArray * things;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    self.things = [DSLThing exampleThings];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    __weak __typeof(self)weakSelf = self;
    

    
    self.collectionView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf.collectionView.mj_header endRefreshing];
    }];

    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    


    // Do any additional setup after loading the view from its nib.
}
#pragma mark UIViewController methods

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
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if(section == 1||section == 0)
    {
        return 0;
    }
    
    
    return self.things.count;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    DSLThing *thing = self.things[indexPath.row];
    cell.titleLabel.text = thing.title;
    cell.imageView.image = thing.image;
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.width/2);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DSLThing * thing = [self.things objectAtIndex:indexPath.row];
    SecViewController * secVC = [[SecViewController alloc]initWithNibName:@"SecViewController" bundle:nil];
    secVC.thing = thing;
    [self.navigationController pushViewController:secVC animated:true];
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    // Check if we're transitioning from this view controller to a DSLSecondViewController
    return [[TransitionFromFirstToSecond alloc]init];



}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
    
    
    
    
    return view;
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={320,95};
    return size;
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
