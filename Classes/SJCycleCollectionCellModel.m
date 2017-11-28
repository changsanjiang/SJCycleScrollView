
//
//  SJCycleCollectionCellModel.m
//  SJCycleScrollView
//
//  Created by BlueDancer on 2017/11/27.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import "SJCycleCollectionCellModel.h"

@implementation SJCycleCollectionCellModel

- (instancetype)initWithURLStr:(NSString *)URLStr {
    return [self initWithURLStr:URLStr placeholderImage:nil contentMode:nil];
}

- (instancetype)initWithURLStr:(NSString *)URLStr placeholderImage:(UIImage * __nullable)placeholderImage contentMode:(NSNumber *)contentMode {
    self = [super init];
    if ( !self ) return nil;
    _URLStr = URLStr;
    _placeholderImage = placeholderImage;
    _contentMode = contentMode;
    return self;
}

- (instancetype)initWithImage:(UIImage *)image contentMode:(NSNumber *__nullable)contentMode {
    self = [super init];
    if ( !self ) return nil;
    _image = image;
    _contentMode = contentMode;
    return self;
}
@end
