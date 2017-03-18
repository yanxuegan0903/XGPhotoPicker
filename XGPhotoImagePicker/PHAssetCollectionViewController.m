//
//  PHAssetCollectionViewController.m
//  XGPhotoImagePicker
//
//  Created by vsKing on 2017/3/17.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "PHAssetCollectionViewController.h"
#import "PHAssetsManager.h"
#import "PHAssetCollectionImageCell.h"
#import "PHAssetCollectionView.h"
#import "PHAssetsBrowerViewController.h"

@interface PHAssetCollectionViewController ()<UICollectionViewDelegate,PHAssetCollectionViewDelegate>

@property (nonatomic, strong) PHAssetCollectionView * assetCollectionView;

@end

@implementation PHAssetCollectionViewController



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = self.title;
    [self.assetCollectionView.collectionView reloadData];
    [self.assetCollectionView setCountLabelText];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.rightBarButtonItem = right;
    
    
    PHAssetCollectionView * assetCollectionView = [[PHAssetCollectionView alloc] initWithFrame:self.view.frame];
    assetCollectionView.dataSource = self.dataSource;
    assetCollectionView.collectionView.delegate = self;
    assetCollectionView.delegate = self;
    [self.view addSubview:assetCollectionView];
    self.assetCollectionView = assetCollectionView;
    
    
    
    
}




#pragma - mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PHAssetsBrowerViewController * vc = [[PHAssetsBrowerViewController alloc] init];
    vc.assets = self.dataSource;
    vc.indexpath = indexPath;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - PHAssetCollectionViewDelegate
- (void)PHAssetCollectionView:(PHAssetCollectionView *)phAssetCollectionView SelectImageCountOutMaxCount:(UIButton *)button{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"最多选择%d张图片",[PHAssetsManager sharedInstance].maxCount] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)PHAssetCollectionView:(PHAssetCollectionView *)phAssetCollectionView ClickSend:(UIButton *)button{
    
    NSMutableArray * arr = [PHAssetsManager getImagesFromAssets:[PHAssetsManager sharedInstance].selectAssets];
    [[PHAssetsManager sharedInstance].selectAssets removeAllObjects];       //  如果屏蔽这句话 那么在选择图片完毕 再次进行选择时 可以实现 显示已经选择的图片
    [PHAssetsManager sharedInstance].imageAssets(0,arr);
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
}


- (void)PHAssetCollectionView:(PHAssetCollectionView *)phAssetCollectionView ClickPreView:(UIButton *)button{
    PHAssetsBrowerViewController * vc = [[PHAssetsBrowerViewController alloc] init];
    NSMutableArray * imageAsset = [NSMutableArray arrayWithArray:[PHAssetsManager sharedInstance].selectAssets];
    vc.assets = imageAsset;
    vc.indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - dismissViewController
- (void)dismiss{
    [[PHAssetsManager sharedInstance].selectAssets removeAllObjects];       //  如果屏蔽这句话 那么在选择图片完毕 再次进行选择时 可以实现 显示已经选择的图片
    [PHAssetsManager sharedInstance].imageAssets(1,nil);
    [self dismissViewControllerAnimated:YES completion:nil];
}





- (void)dealloc{
//    NSLog(@"------>>>> %@ delloc",NSStringFromClass([self class]));
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

@end
