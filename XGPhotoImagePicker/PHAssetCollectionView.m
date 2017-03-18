//
//  PHAssetCollectionView.m
//  XGPhotoImagePicker
//
//  Created by vsKing on 2017/3/17.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "PHAssetCollectionView.h"
#import "PHAssetsManager.h"
#import "PHAssetCollectionImageCell.h"


#define bottomBarHeight 44



@interface PHAssetCollectionView ()<UICollectionViewDataSource,PHAssetCollectionImageCellDelegate>


@property (nonatomic, strong) UIView *bottomBar;

@property (nonatomic, strong) UIButton *preViewButton;

@property (nonatomic, strong) UIButton *sendButton;

@property (nonatomic, strong) UILabel *countLabel;



@end


@implementation PHAssetCollectionView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dataSource = [NSMutableArray array];

        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(self.frame.size.width/4,self.frame.size.width/4);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 1;
        
        UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:collectionView];
        [collectionView registerClass:[PHAssetCollectionImageCell class] forCellWithReuseIdentifier:NSStringFromClass([PHAssetCollectionImageCell class])];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        self.collectionView = collectionView;
        
        
        UIView * bottomBar = [UIView new];
        [self addSubview:bottomBar];
        bottomBar.backgroundColor = [UIColor blackColor];
        bottomBar.alpha = 0.5;
        self.bottomBar = bottomBar;
        
        
        UIButton * preViewButton = [[UIButton alloc] init];
        [self addSubview:preViewButton];
        [preViewButton setTitle:@"预览" forState:UIControlStateNormal];
        [preViewButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [preViewButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [preViewButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        preViewButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [preViewButton addTarget:self action:@selector(clickPreView:) forControlEvents:UIControlEventTouchUpInside];
        self.preViewButton = preViewButton;
        
        
        UIButton * sendButton = [[UIButton alloc] init];
        [self addSubview:sendButton];
        [sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [sendButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        sendButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [sendButton addTarget:self action:@selector(clickSend:) forControlEvents:UIControlEventTouchUpInside];
        self.sendButton = sendButton;
        
        UILabel * countLabel = [UILabel new];
        [self addSubview:countLabel];
        countLabel.textAlignment = NSTextAlignmentCenter;
        countLabel.font = [UIFont systemFontOfSize:15];
        [countLabel sizeToFit];
        countLabel.backgroundColor = [UIColor greenColor];
        countLabel.layer.masksToBounds = YES;
        countLabel.layer.cornerRadius = bottomBarHeight/4;
        self.countLabel = countLabel;
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    self.bottomBar.frame = CGRectMake(0, self.frame.size.height - bottomBarHeight, self.frame.size.width, bottomBarHeight);
    
    self.preViewButton.frame = CGRectMake(0, CGRectGetMinY(self.bottomBar.frame), bottomBarHeight*2.0, bottomBarHeight);
    
    self.countLabel.frame = CGRectMake(self.frame.size.width - bottomBarHeight/2.0 - 5, CGRectGetMinY(self.bottomBar.frame) + bottomBarHeight/4, bottomBarHeight/2.0, bottomBarHeight/2.0);
    
    self.sendButton.frame = CGRectMake(CGRectGetMinX(self.countLabel.frame) - bottomBarHeight - 5, CGRectGetMinY(self.bottomBar.frame), bottomBarHeight, bottomBarHeight);
    
}


#pragma - mark setAssetCollection

- (void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
    
}

//- (void)setAssetCollection:(PHAssetCollection *)assetCollection{
//    _assetCollection = assetCollection;
//    
//    self.dataSource = [PHAssetsManager getAllAssetFromAssetCollection:assetCollection];
//
//    [self.collectionView reloadData];
//}





#pragma - mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataSource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PHAssetCollectionImageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PHAssetCollectionImageCell class]) forIndexPath:indexPath];
    cell.asset = [self.dataSource objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
}


#pragma mark - PHAssetCollectionImageCellDelegate

- (void)PHAssetCollectionImageCell:(PHAssetCollectionImageCell *)cell DidClickSelectButton:(UIButton *)button{
    [self setCountLabelText];
}

- (void)PHAssetCollectionImageCell:(PHAssetCollectionImageCell *)cell selectImageCountOutMaxCount:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(PHAssetCollectionView:SelectImageCountOutMaxCount:)]) {
        [self.delegate PHAssetCollectionView:self SelectImageCountOutMaxCount:button];
    }
}


#pragma mark - 点击发送
- (void)clickSend:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(PHAssetCollectionView:ClickSend:)]) {
        [self.delegate PHAssetCollectionView:self ClickSend:sender];
    }
}

- (void)clickPreView:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(PHAssetCollectionView:ClickPreView:)] && [[PHAssetsManager sharedInstance].selectAssets count] > 0) {
        [self.delegate PHAssetCollectionView:self ClickPreView:sender];
    }
}


- (void)setCountLabelText{
    self.countLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)[[PHAssetsManager sharedInstance].selectAssets count]];

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.countLabel.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.countLabel.transform = CGAffineTransformIdentity;
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
