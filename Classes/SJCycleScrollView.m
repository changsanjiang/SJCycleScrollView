//
//  SJCycleScrollView.m
//  SJCycleScrollView
//
//  Created by BlueDancer on 2017/11/27.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import "SJCycleScrollView.h"
#import <Masonry/Masonry.h>
#import "SJPageControl.h"
#import <SJUIFactory/SJUIFactoryHeader.h>
#import "SJCycleCollectionCellModel.h"

static NSString *const SJCycleCollectionViewCellID = @"SJCycleCollectionViewCell";

@interface SJCycleScrollView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, strong, readonly) SJPageControl *pageControl;

@end

@implementation SJCycleScrollView

@synthesize contentView = _contentView;
@synthesize placeholderImageView = _placeholderImageView;
@synthesize collectionView = _collectionView;
@synthesize pageControl = _pageControl;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( !self ) return nil;
    [self _cycleSetupView];
    return self;
}

- (void)setModels:(NSArray<SJCycleCollectionCellModel *> *)models {
    _models = models;
    [_collectionView reloadData];
    [_pageControl clean];
    [models enumerateObjectsUsingBlock:^(SJCycleCollectionCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_pageControl addAnIndicator:obj.pageIndicatorModel];
    }];
}

#pragma mark - Setup Views
- (void)_cycleSetupView {
    [self addSubview:self.contentView];
    [_contentView addSubview:self.placeholderImageView];
    [_contentView addSubview:self.collectionView];
    [_contentView addSubview:self.pageControl];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_contentView.superview);
    }];
    
    [_placeholderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_placeholderImageView.superview);
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_collectionView.superview);
    }];
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.trailing.offset(0);
    }];
}

- (UIImageView *)placeholderImageView {
    if ( _placeholderImageView ) return _placeholderImageView;
    _placeholderImageView = [SJUIFactory imageViewWithImageName:@"" viewMode:UIViewContentModeScaleAspectFill];
    return _placeholderImageView;
}

- (SJPageControl *)pageControl {
    if ( _pageControl ) return _pageControl;
    _pageControl = [SJPageControl new];
    return _pageControl;
}

- (UIView *)contentView {
    if ( _contentView ) return _contentView;
    _contentView = [SJUIFactory viewWithBackgroundColor:nil];
    return _contentView;
}

//- (void)_shadowWithView:(UIView *)view {
//    view.layer.shadowOffset = CGSizeMake(0, 1);
//    view.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.1].CGColor;
//    view.layer.shadowOpacity = 1;
//}

#pragma mark
- (UICollectionView *)collectionView {
    if ( _collectionView ) return _collectionView;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.pagingEnabled = YES;
    [_collectionView registerClass:NSClassFromString(SJCycleCollectionViewCellID) forCellWithReuseIdentifier:SJCycleCollectionViewCellID];
    return _collectionView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ( 0 == _models.count ) return;
    NSInteger i_offset_x = _collectionView.contentOffset.x / _collectionView.csj_w;
    NSInteger items = [_collectionView numberOfItemsInSection:0];

    if ( i_offset_x == 0 ) {
        if ( _collectionView.contentOffset.x > 0 ) return;
        i_offset_x = ( (items / _models.count / 2) * _models.count ) * _collectionView.csj_w;
        _collectionView.contentOffset = CGPointMake(i_offset_x, 0);
    }
    else if ( i_offset_x == items - 1 ) {
        _collectionView.contentOffset = CGPointMake(((items / _models.count / 2) * _models.count - 1) * _collectionView.csj_w, 0);
    }
    
    _pageControl.currentPage = (NSInteger)(_collectionView.contentOffset.x / _collectionView.csj_w) % _models.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _models.count * 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SJCycleCollectionViewCellID forIndexPath:indexPath];
    [cell setValue:_models[indexPath.row % _models.count] forKey:@"model"];
    return cell;
}

#pragma mark
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.csj_w, self.csj_w * 9.0f / 16.0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

@end
