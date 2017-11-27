//
//  SJPageIndicatorSetting.h
//  SJCycleScrollView
//
//  Created by BlueDancer on 2017/11/27.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSNotificationName const SJPageIndicatorSelectedNotification;

@interface SJPageIndicatorSetting : NSObject

/// default is gray.
@property (nonatomic, strong, nullable) UIColor *pageIndicatorTintColor;

/// default is white.
@property (nonatomic, strong, nullable) UIColor *currentPageIndicatorTintColor;

/// default is nil.
@property (nonatomic, strong, nullable) UIImage *pageIndicatorImage;

/// default is nil.
@property (nonatomic, strong, nullable) UIImage *currentPageIndicatorImage;

/// default is [5, 5]
@property (nonatomic) CGSize pageIndicatorSize;

#pragma mark -
//@property (nonatomic, assign, getter=isSelected) BOOL selected;
//- (void)setIsSelected:(BOOL)selected;

- (UIColor * __nonnull)pageIndicatorTintColor;
- (UIColor * __nonnull)currentPageIndicatorTintColor;
- (UIImage * __nullable)pageIndicatorImage;
- (UIImage * __nullable)currentPageIndicatorImage;
- (CGSize)pageIndicatorSize;

@end

NS_ASSUME_NONNULL_END