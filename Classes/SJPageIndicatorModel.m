//
//  SJPageIndicatorModel.m
//  SJCycleScrollView
//
//  Created by BlueDancer on 2017/11/27.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import "SJPageIndicatorModel.h"
#import <objc/message.h>

NSNotificationName const SJPageIndicatorSelectedNotification = @"SJPageIndicatorSelectedNotification";

@implementation SJPageIndicatorModel

+ (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    objc_setAssociatedObject(self, @selector(pageIndicatorTintColor), pageIndicatorTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)pageIndicatorTintColor {
    UIColor *color = objc_getAssociatedObject(self, _cmd);
    if ( color ) return color;
    return [UIColor grayColor];
}

+ (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    objc_setAssociatedObject(self, @selector(currentPageIndicatorTintColor), currentPageIndicatorTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)currentPageIndicatorTintColor {
    UIColor *color = objc_getAssociatedObject(self, _cmd);
    if ( color ) return color;
    return [UIColor whiteColor];
}

+ (void)setPageIndicatorImage:(UIImage *)pageIndicatorImage {
    objc_setAssociatedObject(self, @selector(pageIndicatorImage), pageIndicatorImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIImage *)pageIndicatorImage {
    return objc_getAssociatedObject(self, _cmd);
}

+ (void)setCurrentPageIndicatorImage:(UIImage *)currentPageIndicatorImage {
    objc_setAssociatedObject(self, @selector(currentPageIndicatorImage), currentPageIndicatorImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIImage *)currentPageIndicatorImage {
    return objc_getAssociatedObject(self, _cmd);
}

+ (void)setPageIndicatorSize:(CGSize)pageIndicatorSize {
    objc_setAssociatedObject(self, @selector(pageIndicatorSize), @(pageIndicatorSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (CGSize)pageIndicatorSize {
    return [objc_getAssociatedObject(self, _cmd) CGSizeValue];
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    [[NSNotificationCenter defaultCenter] postNotificationName:SJPageIndicatorSelectedNotification object:self];
}

- (void)setIsSelected:(BOOL)selected {
    [self setSelected:selected];
}

- (UIColor * __nonnull)pageIndicatorTintColor {
    return [[self class] pageIndicatorTintColor];
}
- (UIColor * __nonnull)currentPageIndicatorTintColor {
    return [[self class] currentPageIndicatorTintColor];
}
- (UIImage * __nullable)pageIndicatorImage {
    return [[self class] pageIndicatorImage];
}
- (UIImage * __nullable)currentPageIndicatorImage {
    return [[self class] currentPageIndicatorImage];
}
- (CGSize)pageIndicatorSize {
    return [[self class] pageIndicatorSize];
}

@end
