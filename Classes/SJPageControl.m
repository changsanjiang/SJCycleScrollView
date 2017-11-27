//
//  SJPageControl.m
//  SJCycleScrollView
//
//  Created by BlueDancer on 2017/11/27.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import "SJPageControl.h"
#import <Masonry/Masonry.h>
#import <objc/message.h>
#import "SJPageIndicator.h"
#import "SJPageIndicatorModel.h"

#pragma mark -
@interface SJPageControl ()

@property (nonatomic, strong, readonly) NSMutableArray<SJPageIndicatorModel *> *pageIndicatorModelsM;
@property (nonatomic, strong, readonly) NSMutableArray<SJPageIndicator *> *pageIndictorsM;

@property (nonatomic, strong, readonly) UIView *contentView;

@property (nonatomic, strong, readwrite) SJPageIndicatorModel *beforeSelectedModel;

@end

@implementation SJPageControl  {
    NSMutableArray<SJPageIndicatorModel *> *_pageIndicatorModelsM;
    NSMutableArray<SJPageIndicator *> *_pageIndictorsM;
    UIView *_contentView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( !self ) return nil;
    // set default values
    _pageIndicatorSpacing = 8;
    
    // setup views
    [self _pageControlSetupViews];
    
    // notifi
    [self _pageControlInstallNotifications];
    return self;
}

- (CGSize)intrinsicContentSize {
    __block CGFloat width = self.pageIndicatorSpacing;
    [_pageIndicatorModelsM enumerateObjectsUsingBlock:^(SJPageIndicatorModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        width += obj.pageIndicatorSize.width + _pageIndicatorSpacing;
    }];
    return CGSizeMake(width, 30);
}

- (void)dealloc {
    [self _removeNotifications];
}

#pragma mark -
- (void)_pageControlInstallNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pageIndicatorSelectedNotification:) name:SJPageIndicatorSelectedNotification object:nil];
}

- (void)_removeNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)pageIndicatorSelectedNotification:(NSNotification *)notifi {
    SJPageIndicatorModel *model = notifi.object;
    if ( [self.pageIndicatorModelsM containsObject:model] ) {
        [self.pageIndictorsM[[self.pageIndicatorModelsM indexOfObject:model]] update];
    }
    
    if ( self.beforeSelectedModel ) [self.pageIndictorsM[[self.pageIndicatorModelsM indexOfObject:self.beforeSelectedModel]] update];
    
    if ( model.isSelected ) self.beforeSelectedModel = model;
}

#pragma mark -
- (void)setCurrentPage:(NSInteger)currentPage {
    if ( currentPage >= self.pageIndictorsM.count ) return;
    _currentPage = currentPage;
    self.beforeSelectedModel.selected = NO;
    self.pageIndicatorModelsM[currentPage].selected = YES;
}

- (void)refreshing {
    
}

- (void)refreshingAtIndex:(NSInteger)index {
    
}

- (void)addAnIndicator:(SJPageIndicatorModel *)model {
    if ( !model ) return;
    if ( 0 == self.pageIndicatorModelsM.count ) model.selected = YES;
    
    // create page indicator
    SJPageIndicator *pageIndicator = [SJPageIndicator new];
    pageIndicator.model = model;
    [self.contentView addSubview:pageIndicator];
    [pageIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(pageIndicator.superview);
        make.leading.offset([self intrinsicContentSize].width);
        make.width.offset(model.pageIndicatorSize.width);
    }];
    
    // update containers
    [self.pageIndicatorModelsM addObject:model];
    [self.pageIndictorsM addObject:pageIndicator];
    [self invalidateIntrinsicContentSize];
}

- (void)addIndicators:(NSArray<SJPageIndicatorModel *> *)indicators {
    if ( 0 == indicators.count ) return;
    [self.pageIndicatorModelsM addObjectsFromArray:indicators];
#warning next...
}

- (void)removeIndicatorAtIndex:(NSInteger)index {
    if ( index > self.pageIndicatorModelsM.count ) return;
    [self.pageIndicatorModelsM removeObjectAtIndex:index];
#warning next...
}

- (void)removeIndicatorsInRange:(NSRange)range {
    if ( range.location + range.length > self.pageIndicatorModelsM.count ) return;
    [self.pageIndicatorModelsM removeObjectsInRange:range];
#warning next...
}

- (void)clean {
    [self.pageIndicatorModelsM removeAllObjects];
    [self refreshing];
}

#pragma mark
- (void)_pageControlSetupViews {
    [self addSubview:self.contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
}

- (UIView *)contentView {
    if ( _contentView ) return _contentView;
    _contentView = [UIView new];
    _contentView.backgroundColor = [UIColor clearColor];
    return _contentView;
}

#pragma mark
- (NSArray<SJPageIndicatorModel *> *)pageIndicators {
    return _pageIndicatorModelsM.copy;
}

- (NSMutableArray<SJPageIndicatorModel *> *)pageIndicatorModelsM {
    if ( _pageIndicatorModelsM ) return _pageIndicatorModelsM;
    _pageIndicatorModelsM = [NSMutableArray new];
    return _pageIndicatorModelsM;
}
- (NSMutableArray<SJPageIndicator *> *)pageIndictorsM {
    if ( _pageIndictorsM ) return _pageIndictorsM;
    _pageIndictorsM = [NSMutableArray array];
    return _pageIndictorsM;
}
@end
