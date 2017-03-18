//
//  PHAssetCollectionCell.m
//  XGPhotoImagePicker
//
//  Created by vsKing on 2017/3/17.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "PHAssetCollectionCell.h"
#import "PHAssetsManager.h"


#define margin 10

#define ksize self.frame.size


@interface PHAssetCollectionCell ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *nameLabel;

@end




@implementation PHAssetCollectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        UIImageView * imgView = [[UIImageView alloc] init];
        [self addSubview:imgView];
        self.imgView = imgView;
        
        UILabel * nameLabel = [[UILabel alloc] init];
        [self addSubview:nameLabel];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel = nameLabel;
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imgView.frame = CGRectMake(margin, margin, ksize.height - (margin*2), ksize.height - (margin*2));
    
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + margin, 0, ksize.width - (CGRectGetMaxX(self.imgView.frame) + margin), ksize.height);
    
}


- (void)setAssetCollection:(PHAssetCollection *)assetCollection{
    _assetCollection = assetCollection;
    
    [PHAssetsManager getInfoFromAssetCollection:assetCollection complete:^(int count, NSString *title, UIImage *image) {
        self.nameLabel.text = [NSString stringWithFormat:@"%@ (%d)",title,count];
        if (image) {
            [self.imgView setImage:image];
        }
    }];
    
    
    
}


- (void)dealloc{
//    NSLog(@"------>>>> %@ delloc",NSStringFromClass([self class]));
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
