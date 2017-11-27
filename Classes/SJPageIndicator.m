//
//  SJPageIndicator.m
//  SJCycleScrollView
//
//  Created by BlueDancer on 2017/11/27.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import "SJPageIndicator.h"
#import <Masonry/Masonry.h>
#import "SJPageIndicatorModel.h"

@interface SJPageIndicator ()
@property (nonatomic, strong, readonly) UIImageView *sjImageView;
@end

@implementation SJPageIndicator {
    UIImageView *_sjImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( !self ) return nil;
    [self _buttonSetupView];
    return self;
}

- (void)setModel:(SJPageIndicatorModel *)model {
    
    if ( !CGSizeEqualToSize(model.pageIndicatorSize, _model.pageIndicatorSize) ) {
        CGFloat min = MIN(model.pageIndicatorSize.width, model.pageIndicatorSize.height) * .5f;
        [_sjImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(model.pageIndicatorSize);
        }];
        
        if ( model.currentPageIndicatorImage || model.pageIndicatorImage ) {
            _sjImageView.layer.cornerRadius = 0;
        }
        else {
            _sjImageView.layer.cornerRadius = min;
        }
    }
    
    _model = model;
    
    if ( model.isSelected ) {
        if ( model.currentPageIndicatorImage ) {
            _sjImageView.layer.cornerRadius = 0;
            _sjImageView.image = model.currentPageIndicatorImage;
        }
        else if ( model.currentPageIndicatorTintColor ) {
            _sjImageView.backgroundColor = model.currentPageIndicatorTintColor;
        }
        else {
            _sjImageView.backgroundColor = [[model class] currentPageIndicatorTintColor];
        }
    }
    else {
        if ( model.pageIndicatorImage ) {
            _sjImageView.layer.cornerRadius = 0;
            _sjImageView.image = model.currentPageIndicatorImage;
        }
        else if ( model.pageIndicatorTintColor ) {
            _sjImageView.backgroundColor = model.pageIndicatorTintColor;
        }
        else {
            _sjImageView.backgroundColor = [[model class] pageIndicatorTintColor];
        }
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)update {
    self.model = self.model;
}

#pragma mark
- (void)_buttonSetupView {
    [self addSubview:self.sjImageView];
    [_sjImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
}

- (UIImageView *)sjImageView {
    if ( _sjImageView ) return _sjImageView;
    _sjImageView = [UIImageView new];
    _sjImageView.contentMode = UIViewContentModeScaleAspectFit;
    _sjImageView.clipsToBounds = YES;
    return _sjImageView;
}
@end

