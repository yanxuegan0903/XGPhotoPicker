//
//  PHAssetsManager.h
//  XGPhotoImagePicker
//
//  Created by vsKing on 2017/3/17.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

typedef void(^complete)(int count , NSString * title,UIImage * image);

typedef void(^ImageAssets)(int error_code, NSMutableArray<UIImage *> *imageAssets);

@interface PHAssetsManager : NSObject

+(PHAssetsManager *)sharedInstance;

//  已经选中的图片
@property (nonatomic, strong) NSMutableArray<PHAsset *> *selectAssets;

//  是否原图
@property(nonatomic,assign)BOOL normalImage;

@property(nonatomic,assign)int maxCount;

@property(nonatomic,assign)ImageAssets imageAssets;


//  获取所有相簿
+ (void)getInfoFromAssetCollection:(PHAssetCollection *)assetCollection complete:(complete)complete;

//  获取相册信息   数量 名字  第一张图片
+ (NSMutableArray<PHAssetCollection *> *)getAllAssetCollections;

//  获取一个相册中所有 图片信息
+ (NSMutableArray<PHAsset *> *)getAllAssetFromAssetCollection:(PHAssetCollection *)assetCollection;

//  根据 PHAsset 获取一张图片
+ (void)getImageFromAsset:(PHAsset *)asset original:(BOOL)original complete:(complete)complete;

//  获取一个集合内的所有照片
+ (NSMutableArray<UIImage *> * )getImagesFromAssets:(NSMutableArray <PHAsset *> *)assets;


@end
