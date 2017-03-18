//
//  PHAssetCollectionViewController.h
//  XGPhotoImagePicker
//
//  Created by vsKing on 2017/3/17.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>


@interface PHAssetCollectionViewController : UIViewController

//@property (nonatomic, strong) PHAssetCollection *assetCollection;


@property (nonatomic, strong) NSMutableArray<PHAsset *> *dataSource;

@property (nonatomic, strong) NSString *title;

@end
