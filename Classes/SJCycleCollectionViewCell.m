//
//  SJCycleCollectionViewCell.m
//  SJCycleScrollView
//
//  Created by BlueDancer on 2017/11/27.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import "SJCycleCollectionViewCell.h"
#import <SJUIFactory/SJUIFactoryHeader.h>
#import <Masonry/Masonry.h>
#import <UIImageView+YYWebImage.h>
#import "SJCycleCollectionCellModel.h"
#import <YYAnimatedImageView.h>

@interface SJCycleCollectionViewCell ()

@property (nonatomic, strong, readonly) YYAnimatedImageView *contentImageView;

@end

@implementation SJCycleCollectionViewCell
@synthesize contentImageView = _contentImageView;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( !self ) return nil;
    [self _cycleCollectionCellSetupView];
    return self;
}

- (void)setModel:(SJCycleCollectionCellModel *)model {
    _model = model;
    if ( model.image ) {
        _contentImageView.image = model.image;
    }
    else {
        [_contentImageView setImageWithURL:[NSURL URLWithString:model.URLStr] placeholder:model.placeholderImage options:YYWebImageOptionShowNetworkActivity | YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation completion:nil];
    }
}

- (void)_cycleCollectionCellSetupView {
    [self.contentView addSubview:self.contentImageView];
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_contentImageView.superview);
    }];
}

- (YYAnimatedImageView *)contentImageView {
    if ( _contentImageView ) return _contentImageView;
    _contentImageView = [YYAnimatedImageView new];
    _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    return _contentImageView;
}

@end
