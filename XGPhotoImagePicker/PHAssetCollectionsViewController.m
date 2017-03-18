//
//  PHAssetCollectionsViewController.m
//  XGPhotoImagePicker
//
//  Created by vsKing on 2017/3/17.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "PHAssetCollectionsViewController.h"
#import "PHAssetCollectionCell.h"
#import "PHAssetsManager.h"
#import "PHAssetCollectionViewController.h"


@interface PHAssetCollectionsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation PHAssetCollectionsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.dataSource = [PHAssetsManager getAllAssetCollections];
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"相册";

    UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.rightBarButtonItem = right;
    
    
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:tableView];
    [tableView registerClass:[PHAssetCollectionCell class] forCellReuseIdentifier:NSStringFromClass([PHAssetCollectionCell class])];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    self.tableView = tableView;

    
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PHAssetCollectionCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PHAssetCollectionCell class]) forIndexPath:indexPath];
    cell.assetCollection = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PHAssetCollectionCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    PHAssetCollectionViewController * vc = [PHAssetCollectionViewController new];
    vc.dataSource = [PHAssetsManager getAllAssetFromAssetCollection:cell.assetCollection] ;
    vc.title = cell.assetCollection.localizedTitle;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}



- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
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
