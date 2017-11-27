//
//  SJCycleCollectionCellModel.h
//  SJCycleScrollView
//
//  Created by BlueDancer on 2017/11/27.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SJPageIndicatorModel;

@interface SJCycleCollectionCellModel : NSObject

@property (nonatomic, strong) NSString *URLStr;
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong, readonly) SJPageIndicatorModel *pageIndicatorModel;

@end
