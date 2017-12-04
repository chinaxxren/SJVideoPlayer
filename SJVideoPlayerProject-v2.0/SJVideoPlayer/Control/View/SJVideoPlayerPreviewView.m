//
//  SJVideoPlayerPreviewView.m
//  SJVideoPlayerProject
//
//  Created by BlueDancer on 2017/12/4.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import "SJVideoPlayerPreviewView.h"
#import <SJUIFactory/SJUIFactory.h>
#import "SJVideoPlayerResources.h"
#import <Masonry/Masonry.h>

static NSString *SJVideoPlayerPreviewCollectionViewCellID = @"SJVideoPlayerPreviewCollectionViewCell";

@interface SJVideoPlayerPreviewView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation SJVideoPlayerPreviewView
@synthesize collectionView = _collectionView;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( !self ) return nil;
    [self _previewSetupView];
    return self;
}

- (void)setPreviewImages:(NSArray<SJVideoPreviewModel *> *)previewImages {
    _previewImages = previewImages;
    [_collectionView reloadData];
}

#pragma mark

- (void)_previewSetupView {
    [self.containerView addSubview:self.collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

- (UICollectionView *)collectionView {
    if ( _collectionView ) return _collectionView;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:NSClassFromString(SJVideoPlayerPreviewCollectionViewCellID) forCellWithReuseIdentifier:SJVideoPlayerPreviewCollectionViewCellID];
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _previewImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SJVideoPlayerPreviewCollectionViewCellID forIndexPath:indexPath];
    [cell setValue:_previewImages[indexPath.row] forKey:@"model"];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize imageSize = _previewImages.firstObject.image.size;
    CGFloat rate = imageSize.width / imageSize.height;
    CGFloat height = _collectionView.frame.size.height - 16;
    CGFloat width = rate * height;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(8, 8, 8, 8);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

@end
