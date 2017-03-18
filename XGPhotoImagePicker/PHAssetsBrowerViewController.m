//
//  PHAssetsBrowerViewController.m
//  XGPhotoImagePicker
//
//  Created by vsKing on 2017/3/17.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "PHAssetsBrowerViewController.h"
#import "PHAssetsBrowerView.h"
#import "PHAssetsManager.h"


@interface PHAssetsBrowerViewController ()<PHAssetsBrowerViewDelegate>

@end

@implementation PHAssetsBrowerViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];

    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    PHAssetsBrowerView * assetsBrowerView = [[PHAssetsBrowerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    assetsBrowerView.assets = self.assets;
    [assetsBrowerView.backButton addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    [assetsBrowerView.cancelButton addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
    assetsBrowerView.delegate = self;
    [assetsBrowerView setCountLabelText];

    if (_indexpath) {
        [assetsBrowerView.collectionView scrollToItemAtIndexPath:_indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [self.view addSubview:assetsBrowerView];
    
        
}




#pragma mark - buttonPress
- (void)clickBack:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickCancel:(UIButton *)sender{
    
    [[PHAssetsManager sharedInstance].selectAssets removeAllObjects];       //  如果屏蔽这句话 那么在选择图片完毕 再次进行选择时 可以实现 显示已经选择的图片
    [PHAssetsManager sharedInstance].imageAssets(1,nil);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - PHAssetsBrowerViewDelegate

- (void)PHAssetsBrowerView:(PHAssetsBrowerView *)phAssetsBrowerView selectImageCountOutMaxCount:(UIButton *)button{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"最多选择%d张图片",[PHAssetsManager sharedInstance].maxCount] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)PHAssetsBrowerView:(PHAssetsBrowerView *)phAssetsBrowerView ClickSend:(UIButton *)button{
    
    NSMutableArray * arr = [PHAssetsManager getImagesFromAssets:[PHAssetsManager sharedInstance].selectAssets];
    
    [[PHAssetsManager sharedInstance].selectAssets removeAllObjects];       //  如果屏蔽这句话 那么在选择图片完毕 再次进行选择时 可以实现 显示已经选择的图片
    [PHAssetsManager sharedInstance].imageAssets(0,arr);

    [self dismissViewControllerAnimated:YES completion:nil];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)dealloc{
//    NSLog(@"------>>>> %@ delloc",NSStringFromClass([self class]));
}
@end
