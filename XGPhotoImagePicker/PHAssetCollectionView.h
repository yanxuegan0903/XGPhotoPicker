//
//  PHAssetCollectionView.h
//  XGPhotoImagePicker
//
//  Created by vsKing on 2017/3/17.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@class PHAssetCollectionView;

@protocol PHAssetCollectionViewDelegate <NSObject>

- (void)PHAssetCollectionView:(PHAssetCollectionView *)phAssetCollectionView SelectImageCountOutMaxCount:(UIButton *)button;

- (void)PHAssetCollectionView:(PHAssetCollectionView *)phAssetCollectionView ClickSend:(UIButton *)button;

- (void)PHAssetCollectionView:(PHAssetCollectionView *)phAssetCollectionView ClickPreView:(UIButton *)button;

@end



@interface PHAssetCollectionView : UIView


@property (nonatomic, strong) UICollectionView *collectionView;

//@property (nonatomic, strong) PHAssetCollection *assetCollection;

@property (nonatomic, weak) id<PHAssetCollectionViewDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *dataSource;


- (void)setCountLabelText;



@end
