//
//  PHAssetsBrowerView.h
//  XGPhotoImagePicker
//
//  Created by vsKing on 2017/3/17.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>


@class PHAssetsBrowerView;

@protocol  PHAssetsBrowerViewDelegate <NSObject>

- (void)PHAssetsBrowerView:(PHAssetsBrowerView *)phAssetsBrowerView selectImageCountOutMaxCount:(UIButton *)button;

- (void)PHAssetsBrowerView:(PHAssetsBrowerView *)phAssetsBrowerView ClickSend:(UIButton *)button;

@end



@interface PHAssetsBrowerView : UIView


@property (nonatomic, strong) NSMutableArray<PHAsset *> *assets;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIButton *backButton;         //  返回按钮

@property (nonatomic, strong) UIButton *cancelButton;       //  取消按钮

@property (nonatomic, weak) id<PHAssetsBrowerViewDelegate> delegate;

- (void)setCountLabelText;

@end
