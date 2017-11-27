//
//  SJPageIndicatorSetting.m
//  SJCycleScrollView
//
//  Created by BlueDancer on 2017/11/27.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import "SJPageIndicatorSetting.h"

@implementation SJPageIndicatorSetting

//- (void)setSelected:(BOOL)selected {
//    _selected = selected;
//    [[NSNotificationCenter defaultCenter] postNotificationName:SJPageIndicatorSelectedNotification object:self];
//}
//
//- (void)setIsSelected:(BOOL)selected {
//    [self setSelected:selected];
//}

- (UIColor * __nonnull)pageIndicatorTintColor {
    if ( _pageIndicatorTintColor ) return _pageIndicatorTintColor;
    return [UIColor grayColor];
}
- (UIColor * __nonnull)currentPageIndicatorTintColor {
    if ( _currentPageIndicatorTintColor ) return _currentPageIndicatorTintColor;
    return [UIColor whiteColor];
}

@end
