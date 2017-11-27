//
//  SJPageIndicator.h
//  SJCycleScrollView
//
//  Created by BlueDancer on 2017/11/27.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SJPageIndicatorModel;

@interface SJPageIndicator : UIButton

@property (nonatomic, strong, readwrite) SJPageIndicatorModel *model;

- (void)update;

@end

NS_ASSUME_NONNULL_END
