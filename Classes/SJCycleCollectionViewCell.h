//
//  SJCycleCollectionViewCell.h
//  SJCycleScrollView
//
//  Created by BlueDancer on 2017/11/27.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SJCycleCollectionCellModel;

@interface SJCycleCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong, readwrite) SJCycleCollectionCellModel *model;
@property (nonatomic, strong, readonly) UIImageView *contentImageView;

@end
