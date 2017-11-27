//
//  SJPageControl.h
//  SJCycleScrollView
//
//  Created by BlueDancer on 2017/11/27.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SJPageIndicatorModel;

@class SJPageIndicatorSetting;

@interface SJPageControl : UIView

/// page indicators.
@property (nonatomic, strong, readonly, nullable) NSArray<SJPageIndicatorModel *> *pageIndicators;

/// setting page indicator.
@property (nonatomic, strong, readonly) SJPageIndicatorSetting *setting;

/// default is no. hide the the indicator if there is only one page
@property (nonatomic) BOOL hidesForSinglePage;

/// default is 8.
@property (nonatomic) CGFloat pageIndicatorSpacing;

/// default is 0.
@property (nonatomic) NSInteger currentPage;

/// reload models.
- (void)refreshing;
- (void)refreshingAtIndex:(NSInteger)index;

/// add
- (void)addAnIndicator:(SJPageIndicatorModel *)indicator;
- (void)addIndicators:(NSArray<SJPageIndicatorModel *> *)indicators;

/// remove
- (void)removeIndicatorAtIndex:(NSInteger)index;
- (void)removeIndicatorsInRange:(NSRange)range;
- (void)clean;

@end

NS_ASSUME_NONNULL_END
