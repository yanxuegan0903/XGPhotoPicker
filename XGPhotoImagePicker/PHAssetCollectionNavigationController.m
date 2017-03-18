//
//  PHAssetCollectionNavigationController.m
//  XGPhotoImagePicker
//
//  Created by vsKing on 2017/3/17.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "PHAssetCollectionNavigationController.h"
#import "PHAssetCollectionsViewController.h"




@interface PHAssetCollectionNavigationController ()

@end

@implementation PHAssetCollectionNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    PHAssetCollectionsViewController * vc = [PHAssetCollectionsViewController new];
    [self setViewControllers:@[vc]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
//    NSLog(@"------>>>> %@ delloc",NSStringFromClass([self class]));
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
