//
//  PHAssetsBrowerView.m
//  XGPhotoImagePicker
//
//  Created by vsKing on 2017/3/17.
//  Copyright © 2017年 vsKing. All rights reserved.
//

#import "PHAssetsBrowerView.h"
#import "PHAssetsBrowerCell.h"
#import "PHAssetsManager.h"

#define ktopBarHeight 60


@interface PHAssetsBrowerView ()<UICollectionViewDataSource,UICollectionViewDelegate,PHAssetsBrowerCellDelegate>
{
    NSIndexPath *_indexP ;      //  当前正在展示的cell
}
@property (nonatomic, strong) UIView *topBar;

@property (nonatomic, strong) UIView *topHalfAlphaView;         //  topBar半透明

@property (nonatomic, strong) UIView *bottomBar;

@property (nonatomic, strong) UIView *bottomHalfAlphaView;      //  bottom半透明

@property (nonatomic, strong) UIButton *selectButton;           //  选中按钮

@property (nonatomic, strong) UILabel *countLabel;              //  数量label

@property (nonatomic, strong) UIButton *sendButton;             //  发送按钮

@end



@implementation PHAssetsBrowerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(self.frame.size.width,self.frame.size.height);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        [self addSubview:collectionView];
        [collectionView registerClass:[PHAssetsBrowerCell class] forCellWithReuseIdentifier:NSStringFromClass([PHAssetsBrowerCell class])];
        collectionView.backgroundColor = [UIColor blackColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.pagingEnabled = YES;
        self.collectionView = collectionView;
        

        //  topBar
        UIView * topBar = [UIView new];
        [self addSubview:topBar];
        topBar.backgroundColor = [UIColor clearColor];
        self.topBar = topBar;
        
        //  halfAlphaView
        UIView * topHalfAlphaView = [UIView new];
        [self.topBar addSubview:topHalfAlphaView];
        topHalfAlphaView.alpha = 0.5;
        topHalfAlphaView.backgroundColor = [UIColor blackColor];
        self.topHalfAlphaView = topHalfAlphaView;
        
        
        UIButton * backButton = [UIButton new];
        [topBar addSubview:backButton];
        [backButton setImage:[UIImage imageNamed:@"lcPlayer_backBtn"] forState:UIControlStateNormal];
        backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
        self.backButton = backButton;
        
        UIButton * cancelButton = [UIButton new];
        [topBar addSubview:cancelButton];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.cancelButton = cancelButton;
        
        
        //  topBar
        UIView * bottomBar = [UIView new];
        [self addSubview:bottomBar];
        bottomBar.backgroundColor = [UIColor clearColor];
        self.bottomBar = bottomBar;
        
        //  halfAlphaView
        UIView * bottomHalfAlphaView = [UIView new];
        [self.bottomBar addSubview:bottomHalfAlphaView];
        bottomHalfAlphaView.alpha = 0.5;
        bottomHalfAlphaView.backgroundColor = [UIColor blackColor];
        self.bottomHalfAlphaView = bottomHalfAlphaView;
        
        
        UIButton * selectButton = [UIButton new];
        [self.bottomBar addSubview:selectButton];
        [selectButton setImage:[UIImage imageNamed:@"icon_album_select"] forState:UIControlStateSelected];
        [selectButton setImage:[UIImage imageNamed:@"icon_album_un_select"] forState:UIControlStateNormal];
        selectButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        selectButton.contentEdgeInsets = UIEdgeInsetsMake(15, 25, 15, 10);
        [selectButton addTarget:self action:@selector(clickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        self.selectButton = selectButton;
        
        UILabel * countLabel = [UILabel new];
        [self.bottomBar addSubview:countLabel];
        countLabel.textAlignment = NSTextAlignmentCenter;
        countLabel.backgroundColor = [UIColor greenColor];
        countLabel.layer.masksToBounds = YES;
        countLabel.layer.cornerRadius = ktopBarHeight/5;
        self.countLabel = countLabel;
        
        UIButton * sendButton = [UIButton new];
        [self.bottomBar addSubview:sendButton];
        [sendButton setTitle:@"发送" forState:UIControlStateNormal];
        sendButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [sendButton addTarget:self action:@selector(clickSend:) forControlEvents:UIControlEventTouchUpInside];
        self.sendButton = sendButton;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    self.topBar.frame = CGRectMake(0, 0, self.frame.size.width, ktopBarHeight);
    
    self.topHalfAlphaView.frame = CGRectMake(0, 0, self.topBar.frame.size.width, self.topBar.frame.size.height);
    
    self.backButton.frame = CGRectMake(0, 0, ktopBarHeight, ktopBarHeight);
    
    self.cancelButton.frame = CGRectMake(self.topBar.frame.size.width - ktopBarHeight, 0, ktopBarHeight, ktopBarHeight);
    
    self.bottomBar.frame = CGRectMake(0, self.frame.size.height - ktopBarHeight, self.frame.size.width, ktopBarHeight);
    
    self.bottomHalfAlphaView.frame = CGRectMake(0, 0, self.bottomBar.frame.size.width, self.bottomBar.frame.size.height);
    
    self.selectButton.frame = CGRectMake(0, 0, ktopBarHeight, ktopBarHeight);
    
    self.countLabel.frame = CGRectMake(self.frame.size.width - ktopBarHeight/2.5 - 5, ktopBarHeight*0.3, ktopBarHeight/2.5, ktopBarHeight/2.5);
    
    self.sendButton.frame = CGRectMake(CGRectGetMinX(self.countLabel.frame) - ktopBarHeight - 5, 0, ktopBarHeight, ktopBarHeight);
}


- (void)setAssets:(NSMutableArray<PHAsset *> *)assets{
    _assets = assets;
    
    [self.collectionView reloadData];

}



#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.assets count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PHAssetsBrowerCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PHAssetsBrowerCell class]) forIndexPath:indexPath];
    cell.asset = [self.assets objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [((PHAssetsBrowerCell *)cell) setNormalScale];
    [((PHAssetsBrowerCell *)cell) displayOriginImage];

}


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    _indexP = [NSIndexPath indexPathForRow:(scrollView.contentOffset.x/self.frame.size.width) inSection:0];
    PHAssetsBrowerCell *cell = (PHAssetsBrowerCell *)[self.collectionView cellForItemAtIndexPath:_indexP];
    
    [self.selectButton setSelected:NO];
    for (PHAsset * set in [PHAssetsManager sharedInstance].selectAssets) {
        if ([set isEqual:cell.asset]) {
            [self.selectButton setSelected:YES];
            break ;
        }
    }
    
    
    
    
}


#pragma mark - PHAssetsBrowerCellDelegate
- (void)PHAssetsBrowerCell:(PHAssetsBrowerCell *)cell singleTap:(UITapGestureRecognizer *)ges{
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.2f animations:^{
        __strong typeof(weakself) strongSelf = weakself;
        [strongSelf.topBar setAlpha:strongSelf.topBar.alpha == 0.0f ? 1.0 : 0.0];
        [strongSelf.bottomBar setAlpha:strongSelf.bottomBar.alpha == 0.0f ? 1.0 : 0.0];
    }];
}



#pragma mark - clickSelect
- (void)clickSelectButton:(UIButton *)sender{
    
    if ([[PHAssetsManager sharedInstance].selectAssets count] >= [PHAssetsManager sharedInstance].maxCount  && !sender.isSelected) {
        
        if ([self.delegate respondsToSelector:@selector(PHAssetsBrowerView:selectImageCountOutMaxCount:)]) {
            [self.delegate PHAssetsBrowerView:self selectImageCountOutMaxCount:sender];
        }
        
        return ;
    }
    
    
    [sender setSelected:!sender.isSelected];
    
    
    if (sender.isSelected) {
        [[PHAssetsManager sharedInstance].selectAssets addObject:[self.assets objectAtIndex:_indexP.row]];
    }else{
        [[PHAssetsManager sharedInstance].selectAssets removeObject:[self.assets objectAtIndex:_indexP.row]];
    }
    
    [self setCountLabelText];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.selectButton.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.selectButton.transform = CGAffineTransformIdentity;
    }];
    
}


#pragma mark - clickSend
- (void)clickSend:(UIButton *)sender{
    
    if ([[PHAssetsManager sharedInstance].selectAssets count] > 0) {
        if ([self.delegate respondsToSelector:@selector(PHAssetsBrowerView:ClickSend:)]) {
            [self.delegate PHAssetsBrowerView:self ClickSend:sender];
        }
    }
    
    
}




- (void)setCountLabelText{
    self.countLabel.text = [NSString stringWithFormat:@"%d",[[PHAssetsManager sharedInstance].selectAssets count]];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.countLabel.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.countLabel.transform = CGAffineTransformIdentity;
    }];
    
}


@end
