//
//  LWZCycleEmbedCollectionViewCell.m
//  dancebaby
//
//  Created by BlueDancer on 2017/11/28.
//  Copyright © 2017年 hunter. All rights reserved.
//

#import "LWZCycleEmbedCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import <SJUIFactory/SJUIFactoryHeader.h>

@interface LWZCycleEmbedCollectionViewCell ()

@property (nonatomic, strong, readonly) UIView *frameShadowView;

@end

@implementation LWZCycleEmbedCollectionViewCell
@synthesize frameShadowView = _frameShadowView;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( !self ) return nil;
    [self _cycleEmbedSetupView];
    return self;
}

- (void)_cycleEmbedSetupView {
    [self.contentImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(12);
        make.bottom.offset(-4);
        make.centerX.offset(0);
        make.width.equalTo(self.contentImageView.mas_height).multipliedBy(self.csj_w / self.csj_h);
    }];
    [self.contentView insertSubview:self.frameShadowView atIndex:0];
    [_frameShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentImageView);
    }];
    
    [SJUIFactory regulate:self.contentImageView cornerRadius:8];
    [SJUIFactory regulate:_frameShadowView cornerRadius:8];
    _frameShadowView.layer.masksToBounds = NO;
}

- (UIView *)frameShadowView {
    if ( _frameShadowView ) return _frameShadowView;
    _frameShadowView = [UIView new];
    _frameShadowView.backgroundColor = [UIColor whiteColor];
    _frameShadowView.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
    _frameShadowView.layer.shadowOffset = CGSizeMake(0, 1);
    _frameShadowView.layer.shadowOpacity = 1;
    return _frameShadowView;
}

@end
