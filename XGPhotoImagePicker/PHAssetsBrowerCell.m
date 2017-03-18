//
//  PHAssetsBrowerCell.m
//  XGPhotoImagePicker
//
//  Created by vsKing on 2017/3/17.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "PHAssetsBrowerCell.h"
#import "PHAssetsManager.h"


@interface PHAssetsBrowerCell ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UIScrollView *scrollView;

@end



@implementation PHAssetsBrowerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        
        UIScrollView * scrollView = [[UIScrollView alloc] init];
        [self.contentView addSubview:scrollView];
        scrollView.delegate = self;
        scrollView.minimumZoomScale = 1.0;
        scrollView.maximumZoomScale = 2.0;
        scrollView.layer.masksToBounds = YES;
        self.scrollView = scrollView;
        
        
        UIImageView * imgView = [[UIImageView alloc] init];
        [self.scrollView addSubview:imgView];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.layer.masksToBounds = YES;
        self.imgView = imgView;
        
        //  添加单击手势
        UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [scrollView addGestureRecognizer:singleTap];
        
        //  添加双击手势
        UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [scrollView addGestureRecognizer:doubleTap];
        
        [singleTap requireGestureRecognizerToFail:doubleTap];

    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    self.imgView.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    
    
}

//  设置初始值
- (void)setAsset:(PHAsset *)asset{
    
    _asset = asset;
    
    __weak typeof(self) weakself = self;
    [PHAssetsManager getImageFromAsset:asset original:NO complete:^(int count, NSString *title, UIImage *image) {
        __strong typeof(weakself) strongSelf = weakself;
        [strongSelf.imgView setImage:image];
        
    }];
    
}

//  展示原始图片
- (void)displayOriginImage{
    __weak typeof(self) weakself = self;
    [PHAssetsManager getImageFromAsset:self.asset original:YES complete:^(int count, NSString *title, UIImage *image) {
        __strong typeof(weakself) strongSelf = weakself;
        [strongSelf.imgView setImage:image];
        
    }];
    
}

//  将缩放比例回复至原始大小

- (void)setNormalScale{
    [self.scrollView setZoomScale:1.0f animated:NO];
}

#pragma mark - UIScrollVewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imgView;
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    [scrollView setZoomScale:scale animated:YES];
}

#pragma mark - 单双击手势
- (void)singleTap:(UITapGestureRecognizer *)ges{
    
    if ([self.delegate respondsToSelector:@selector(PHAssetsBrowerCell:singleTap:)]) {
        [self.delegate PHAssetsBrowerCell:self singleTap:ges];
    }
    
}

- (void)doubleTap:(UITapGestureRecognizer *)ges{
    
    
    if (self.scrollView.zoomScale != 1.0) {
        [self.scrollView setZoomScale:1.0f animated:YES];

    }else{
        CGFloat width = self.frame.size.width;
        
        CGFloat scale = width / 2.0;
        
        //获取当前的触摸点
        CGPoint point = [ges locationInView:self.imgView];
        
        //对点进行处理
        CGFloat originX = MAX(0, point.x - width / scale);
        CGFloat originY = MAX(0, point.y - width / scale);
        
        //进行位置的计算
        CGRect rect = CGRectMake(originX, originY, width / scale , width / scale);
        
        //进行缩放
        [self.scrollView zoomToRect:rect animated:true];
    }
    
    
    
}



- (void)dealloc{
//    NSLog(@"------>>>> %@ delloc",NSStringFromClass([self class]));
}
@end
