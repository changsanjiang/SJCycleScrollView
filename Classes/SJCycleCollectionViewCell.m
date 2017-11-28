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
@property (nonatomic, strong) YYAnimatedImageView *contentImageView;
@end

@implementation SJCycleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( !self ) return nil;
    return self;
}

- (void)setModel:(SJCycleCollectionCellModel *)model {
    _model = model;
    if ( model.image ) {
        self.contentImageView.image = model.image;
    }
    else {
        [self.contentImageView setImageWithURL:[NSURL URLWithString:model.URLStr] placeholder:model.placeholderImage options:YYWebImageOptionShowNetworkActivity | YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation completion:nil];
    }

    self.contentImageView.contentMode = [model.contentMode integerValue];
}

- (YYAnimatedImageView *)contentImageView {
    if ( _contentImageView ) return _contentImageView;
    _contentImageView = [YYAnimatedImageView new];
    _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    _contentImageView.clipsToBounds = YES;
    [self.contentView insertSubview:_contentImageView atIndex:0];
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_contentImageView.superview);
    }];
    return _contentImageView;
}

@end
