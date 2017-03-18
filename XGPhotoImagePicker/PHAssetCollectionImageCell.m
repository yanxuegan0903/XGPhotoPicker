//
//  PHAssetCollectionImageCell.m
//  XGPhotoImagePicker
//
//  Created by vsKing on 2017/3/17.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "PHAssetCollectionImageCell.h"
#import "PHAssetsManager.h"



#define margin 1

#define ksize self.frame.size

#define buttonWidth 35


@interface PHAssetCollectionImageCell ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UIButton *selectButton;

@end




@implementation PHAssetCollectionImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView * imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.layer.masksToBounds = YES;
        self.imgView = imgView;
        
        
        
        
        UIButton * selectButton = [[UIButton alloc] init];
        [self.contentView addSubview:selectButton];
        self.selectButton = selectButton;
        [selectButton setImage:[UIImage imageNamed:@"icon_album_select"] forState:UIControlStateSelected];
        [selectButton setImage:[UIImage imageNamed:@"icon_album_un_select"] forState:UIControlStateNormal];
        [selectButton addTarget:self action:@selector(clickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        selectButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        selectButton.contentEdgeInsets = UIEdgeInsetsMake(15, 15, 3, 3);
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.contentView.frame = CGRectMake(0, 0, ksize.width-margin, ksize.height-1);
    
    self.imgView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
    self.selectButton.frame = CGRectMake(self.contentView.frame.size.width - buttonWidth, self.contentView.frame.size.height - buttonWidth, buttonWidth, buttonWidth);
    
    
}




- (void)setAsset:(PHAsset *)asset{
    _asset = asset;
    __weak typeof(self) weakself = self;
    [PHAssetsManager getImageFromAsset:asset original:NO complete:^(int count, NSString *title, UIImage *image) {
        __strong typeof(weakself) strongSelf = weakself;
        [strongSelf.imgView setImage:image];
        
    }];
    
    [self.selectButton setSelected:NO];
    [self.selectButton setHidden:asset.mediaType == PHAssetMediaTypeImage ? NO : YES];
    [self setUserInteractionEnabled:asset.mediaType == PHAssetMediaTypeImage ? YES : NO];
    
    for (PHAsset * set in [PHAssetsManager sharedInstance].selectAssets) {
        if ([set isEqual:asset]) {
            [self.selectButton setSelected:YES];
            break ;
        }
    }
    
    
    
    
}


- (void)clickSelectButton:(UIButton *)sender{
        
    if ([[PHAssetsManager sharedInstance].selectAssets count] >= [PHAssetsManager sharedInstance].maxCount  && !sender.isSelected) {
        
        if ([self.delegate respondsToSelector:@selector(PHAssetCollectionImageCell:selectImageCountOutMaxCount:)]) {
            [self.delegate PHAssetCollectionImageCell:self selectImageCountOutMaxCount:sender];
        }
        
        return ;
    }
    
    [sender setSelected:!sender.isSelected];
    
    if (sender.isSelected) {
        [[PHAssetsManager sharedInstance].selectAssets addObject:self.asset];
    }else{
        [[PHAssetsManager sharedInstance].selectAssets removeObject:self.asset];
    }
    
    if ([self.delegate respondsToSelector:@selector(PHAssetCollectionImageCell:DidClickSelectButton:)]) {
        [self.delegate PHAssetCollectionImageCell:self DidClickSelectButton:sender];
    }
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.selectButton.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.selectButton.transform = CGAffineTransformIdentity;
    }];
    
}

- (void)dealloc{
//    NSLog(@"------>>>> %@ delloc",NSStringFromClass([self class]));
}

@end
