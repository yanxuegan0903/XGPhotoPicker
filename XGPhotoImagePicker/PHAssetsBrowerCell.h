//
//  PHAssetsBrowerCell.h
//  XGPhotoImagePicker
//
//  Created by vsKing on 2017/3/17.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@class PHAssetsBrowerCell;

@protocol PHAssetsBrowerCellDelegate <NSObject>

- (void)PHAssetsBrowerCell:(PHAssetsBrowerCell *)cell singleTap:(UITapGestureRecognizer *)ges;

@end


@interface PHAssetsBrowerCell : UICollectionViewCell

@property (nonatomic, strong) PHAsset *asset;

- (void)displayOriginImage;

- (void)setNormalScale;

@property (nonatomic, weak) id<PHAssetsBrowerCellDelegate> delegate;

@end
