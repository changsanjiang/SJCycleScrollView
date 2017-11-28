//
//  SJCycleCollectionCellModel.h
//  SJCycleScrollView
//
//  Created by BlueDancer on 2017/11/27.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJCycleCollectionCellModel : NSObject

// If nil, the cycleScrollView's contentMode will be used.
@property (nonatomic, strong) NSNumber *contentMode; // UIViewContentMode

// If nil, the cycleScrollView's placeholder will be used.
@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic, strong) NSString *URLStr;
- (instancetype)initWithURLStr:(NSString *)URLStr;
- (instancetype)initWithURLStr:(NSString *)URLStr placeholderImage:(UIImage * __nullable)placeholderImage contentMode:(NSNumber *__nullable)contentMode;


@property (nonatomic, strong) UIImage *image;
- (instancetype)initWithImage:(UIImage *)image contentMode:(NSNumber *__nullable)contentMode;

@end

NS_ASSUME_NONNULL_END
