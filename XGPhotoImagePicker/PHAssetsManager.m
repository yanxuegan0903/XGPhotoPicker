//
//  PHAssetsManager.m
//  XGPhotoImagePicker
//
//  Created by vsKing on 2017/3/17.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "PHAssetsManager.h"

@implementation PHAssetsManager

+(PHAssetsManager *)sharedInstance{
    static PHAssetsManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [PHAssetsManager new];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectAssets = [NSMutableArray array];
        self.normalImage = NO;
        self.maxCount = 9;
    }
    return self;
}

//  获取所有相簿
+ (NSMutableArray<PHAssetCollection *> *)getAllAssetCollections{
    
    
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    
    NSMutableArray<PHAssetCollection *> * collections = [NSMutableArray array];
    
    for (PHAssetCollection * assetCollection in assetCollections) {
        [collections addObject:assetCollection];
    }
    
    [collections addObject:cameraRoll];
    
    return collections;
}

//  获取相册信息   数量 名字  第一张图片
+ (void)getInfoFromAssetCollection:(PHAssetCollection *)assetCollection complete:(complete)complete{

    //  获取相册名字
    NSString * title = assetCollection.localizedTitle;
    
    //  获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    
    int count = assets.count;
    
    if (count == 0) {
        complete(0,title,nil);
    }
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    PHAsset *asset = assets.firstObject;
    
//    CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
    
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeZero contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        complete(count,title,result);
    }];
    
    
    
}

//  获取一个相册中所有 图片信息
+ (NSMutableArray<PHAsset *> *)getAllAssetFromAssetCollection:(PHAssetCollection *)assetCollection{
    NSMutableArray<PHAsset *> * assetArray = [NSMutableArray array];
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset * asset in assets) {
        if (asset.mediaType == PHAssetMediaTypeImage) {
            [assetArray addObject:asset];
        }
    }
    return assetArray;
}

//  根据 PHAsset 获取一张图片
+ (void)getImageFromAsset:(PHAsset *)asset original:(BOOL)original complete:(complete)complete{
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        complete(0,nil,result);
        
    }];
    
    
}


//  获取一个集合内的所有照片
+ (NSMutableArray<UIImage *> * )getImagesFromAssets:(NSMutableArray <PHAsset *> *)assets{

    __block NSMutableArray * assetsArray = [NSMutableArray array];
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    for (PHAsset * asset in assets) {
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight) contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            [assetsArray addObject:result];
        }];
    }
    
    return assetsArray;
}

@end
