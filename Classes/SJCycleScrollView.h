//
//  SJCycleScrollView.h
//  SJCycleScrollView
//
//  Created by BlueDancer on 2017/11/27.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SJCycleCollectionCellModel, SJPageControl;

@protocol SJCycleScrollViewDelegate;

typedef NS_ENUM(NSUInteger, SJCycleScrollPageAlignment) {
    SJCycleScrollPageAlignmentTrailing,
    SJCycleScrollPageAlignmentCenter,
    SJCycleScrollPageAlignmentLeading,
};

#pragma mark
@interface SJCycleScrollView : UIView

@property (nonatomic, weak) id<SJCycleScrollViewDelegate>delegate;
@property (nonatomic, strong, readwrite) NSArray<SJCycleCollectionCellModel *> *models;
/// default is UIViewContentModeScaleAspectFill;
@property (nonatomic) UIViewContentMode imageViewContentMode;
@property (nonatomic, strong) UIImage *placeholderImage;
/// default is YES.
@property (nonatomic) BOOL autoScroll;
/// default is 4.
@property (nonatomic) NSTimeInterval scrollInterval;
@property (nonatomic, strong, readonly) SJPageControl *pageControl;
@property (nonatomic) SJCycleScrollPageAlignment pageAlign;

@end

#pragma mark
@protocol SJCycleScrollViewDelegate <NSObject>

@optional
- (void)cycleScrollView:(SJCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
