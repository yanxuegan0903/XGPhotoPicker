//
//  PHAssetsBrowerViewController.h
//  XGPhotoImagePicker
//
//  Created by vsKing on 2017/3/17.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>


@interface PHAssetsBrowerViewController : UIViewController

@property (nonatomic, strong) NSMutableArray<PHAsset *> *assets;

@property (nonatomic, strong) NSIndexPath *indexpath;

@end
