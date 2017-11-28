//
//  SJCycleScrollView.m
//  SJCycleScrollView
//
//  Created by BlueDancer on 2017/11/27.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import "SJCycleScrollView.h"
#import <Masonry/Masonry.h>
#import <SJPageControl/SJPageControlHeader.h>
#import <SJUIFactory/SJUIFactoryHeader.h>
#import "SJCycleCollectionCellModel.h"

@interface NSTimer (SJCycleAdd)

+ (instancetype)csj_scheduledTimerWithTimeInterval:(NSTimeInterval)ti exeBlock:(void(^)(NSTimer *timer))block repeats:(BOOL)yesOrNo;

@end

@implementation NSTimer (SJCycleAdd)

+ (instancetype)csj_scheduledTimerWithTimeInterval:(NSTimeInterval)ti exeBlock:(void(^)(NSTimer *timer))block repeats:(BOOL)yesOrNo {
    NSAssert(block, @"block 不可为空");
    return [self scheduledTimerWithTimeInterval:ti target:self selector:@selector(csj_exeTimerEvent:) userInfo:[block copy] repeats:yesOrNo];
}

+ (void)csj_exeTimerEvent:(NSTimer *)timer {
    void(^block)(NSTimer *timer) = timer.userInfo;
    if ( block ) block(timer);
}

@end


#pragma mark -

static NSString *const SJCycleCollectionViewCellID = @"SJCycleCollectionViewCell";

static NSString *const LWZCycleEmbedCollectionViewCellID = @"LWZCycleEmbedCollectionViewCell";

@interface SJCycleScrollView ()<UICollectionViewDelegate, UICollectionViewDataSource> {
    NSTimer *_autoScrollTimer;
}

@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, strong, readonly) UIImageView *placeholderImageView;

@end

@implementation SJCycleScrollView

@synthesize contentView = _contentView;
@synthesize placeholderImageView = _placeholderImageView;
@synthesize collectionView = _collectionView;
@synthesize pageControl = _pageControl;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( !self ) return nil;
    _autoScroll = YES;
    _scrollInterval = 4;
    _imageViewContentMode = UIViewContentModeScaleAspectFill;
    [self _cycleSetupView];
    return self;
}

- (void)dealloc {
    NSLog(@"%zd - %s", __LINE__, __func__);
    [self _clearAutoScrollTimer];
}

- (void)setModels:(NSArray<SJCycleCollectionCellModel *> *)models {
    _models = models;
    [self _clearAutoScrollTimer];
    if ( _autoScroll ) [self _startAutoScroll];
    self.placeholderImageView.hidden = 0 != models.count;
    
    [models enumerateObjectsUsingBlock:^(SJCycleCollectionCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ( !obj.contentMode ) obj.contentMode = @(_imageViewContentMode);
        if ( obj.URLStr && !obj.placeholderImage ) obj.placeholderImage = _placeholderImage;
    }];
    [_collectionView reloadData];
    _pageControl.numberOfPages = models.count;
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    if ( placeholderImage == _placeholderImage ) return;
    _placeholderImage = placeholderImage;
    _placeholderImageView.image = placeholderImage;
}

- (void)setAutoScroll:(BOOL)autoScroll {
    if ( autoScroll == _autoScroll ) return;
    _autoScroll = autoScroll;
    if ( _autoScroll ) [self _startAutoScroll];
    else [self _clearAutoScrollTimer];
}

- (void)setScrollInterval:(NSTimeInterval)scrollInterval {
    if ( scrollInterval == _scrollInterval ) return;
    _scrollInterval = scrollInterval;
    if ( _autoScroll ) [self _startAutoScroll];
}

- (void)setPageAlign:(SJCycleScrollPageAlignment)pageAlign {
    if ( pageAlign == _pageAlign ) return;
    _pageAlign = pageAlign;
    switch (pageAlign) {
        case SJCycleScrollPageAlignmentTrailing: {
            [_pageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.trailing.offset(0);
            }];
        }
            break;
        case SJCycleScrollPageAlignmentCenter: {
            [_pageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.bottom.offset(0);
            }];
        }
            break;
        case SJCycleScrollPageAlignmentLeading: {
            [_pageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.leading.bottom.offset(0);
            }];
        }
            break;
    }
}

#pragma mark - Setup Views
- (void)_cycleSetupView {
    [self addSubview:self.contentView];
    [_contentView addSubview:self.placeholderImageView];
    [_contentView addSubview:self.collectionView];
    [_contentView addSubview:self.pageControl];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [_placeholderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.trailing.offset(0);
    }];
}

- (UIImageView *)placeholderImageView {
    if ( _placeholderImageView ) return _placeholderImageView;
    _placeholderImageView = [SJUIFactory imageViewWithImageName:@"" viewMode:_imageViewContentMode];
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
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:NSClassFromString(SJCycleCollectionViewCellID) forCellWithReuseIdentifier:SJCycleCollectionViewCellID];
    [_collectionView registerClass:NSClassFromString(LWZCycleEmbedCollectionViewCellID) forCellWithReuseIdentifier:LWZCycleEmbedCollectionViewCellID];
    return _collectionView;
}

- (void)_startAutoScroll {
    __weak typeof(self) _self = self;
    _autoScrollTimer = [NSTimer csj_scheduledTimerWithTimeInterval:_scrollInterval exeBlock:^(NSTimer *timer) {
        __strong typeof(_self) self = _self;
        if ( !self ) return;
        [self.collectionView setContentOffset:CGPointMake(ceil(self.collectionView.contentOffset.x / self.collectionView.csj_w + 1) * self.collectionView.csj_w, 0) animated:YES];
    } repeats:YES];
    _autoScrollTimer.fireDate = [NSDate dateWithTimeIntervalSinceNow:_scrollInterval];
}

- (void)_clearAutoScrollTimer {
    [_autoScrollTimer invalidate];
    _autoScrollTimer = nil;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self _clearAutoScrollTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ( _autoScroll ) [self _startAutoScroll];
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
    
    _pageControl.currentPage = i_offset_x % _models.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _models.count * 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LWZCycleEmbedCollectionViewCellID forIndexPath:indexPath];
    [cell setValue:_models[indexPath.item % _models.count] forKey:@"model"];
    return cell;
}

#pragma mark
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.csj_size;
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

#pragma mark
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ( [self.delegate respondsToSelector:@selector(cycleScrollView:didSelectItemAtIndex:)] ) {
        [self.delegate cycleScrollView:self didSelectItemAtIndex:indexPath.item % _models.count];
    }
}
@end
