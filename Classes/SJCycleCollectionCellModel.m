
//
//  SJCycleCollectionCellModel.m
//  SJCycleScrollView
//
//  Created by BlueDancer on 2017/11/27.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import "SJCycleCollectionCellModel.h"
#import "SJPageIndicatorModel.h"

@implementation SJCycleCollectionCellModel {
     SJPageIndicatorModel *_pageIndicatorModel;
}

- (SJPageIndicatorModel *)pageIndicatorModel {
    if ( _pageIndicatorModel ) return _pageIndicatorModel;
    _pageIndicatorModel = [SJPageIndicatorModel new];
    return _pageIndicatorModel;
}

@end
