//
//  PHAssetCollectionImageCell.h
//  XGPhotoImagePicker
//
//  Created by vsKing on 2017/3/17.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@class PHAssetCollectionImageCell;

@protocol  PHAssetCollectionImageCellDelegate <NSObject>

- (void)PHAssetCollectionImageCell:(PHAssetCollectionImageCell *)cell selectImageCountOutMaxCount:(UIButton *)button;

- (void)PHAssetCollectionImageCell:(PHAssetCollectionImageCell *)cell DidClickSelectButton:(UIButton *)button;

@end



@interface PHAssetCollectionImageCell : UICollectionViewCell

@property (nonatomic, strong) PHAsset *asset;

@property (nonatomic, weak) id<PHAssetCollectionImageCellDelegate> delegate;

@end
