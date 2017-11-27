//
//  SJCycleScrollView.h
//  SJCycleScrollView
//
//  Created by BlueDancer on 2017/11/27.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SJCycleCollectionCellModel;

@interface SJCycleScrollView : UIView

@property (nonatomic, strong, readonly) UIImageView *placeholderImageView;
@property (nonatomic, strong, readwrite) NSArray<SJCycleCollectionCellModel *> *models;

@end
