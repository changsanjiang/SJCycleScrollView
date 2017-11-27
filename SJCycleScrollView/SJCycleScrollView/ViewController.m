//
//  ViewController.m
//  SJCycleScrollView
//
//  Created by BlueDancer on 2017/11/27.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import "ViewController.h"
#import "SJCycleScrollView.h"
#import "SJCycleCollectionCellModel.h"
#import <Masonry.h>
#import "SJPageControl.h"
#import "SJPageIndicatorModel.h"

@interface ViewController ()

@property (nonatomic, strong) SJCycleScrollView *cycleScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cycleScrollView = [SJCycleScrollView new];
    [self.view addSubview:self.cycleScrollView];
    _cycleScrollView.backgroundColor = [UIColor colorWithRed:1.0 * (arc4random() % 256 / 255.0)
                                                       green:1.0 * (arc4random() % 256 / 255.0)
                                                        blue:1.0 * (arc4random() % 256 / 255.0)
                                                       alpha:1];
    
    [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.leading.trailing.offset(0);
        make.height.equalTo(_cycleScrollView.mas_width).multipliedBy(9.0f / 16);
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)add:(id)sender {
    SJCycleCollectionCellModel *model = [SJCycleCollectionCellModel new];
    model.image = [UIImage imageNamed:@"placeholder"];
    
    SJCycleCollectionCellModel *model2 = [SJCycleCollectionCellModel new];
    model2.URLStr = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512376130&di=51fa5848d63511f6182ddf5202afc5ea&imgtype=jpg&er=1&src=http%3A%2F%2Fp2.wmpic.me%2Farticle%2F2015%2F02%2F10%2F1423537834_aExiXcrg.jpeg";
    
    SJCycleCollectionCellModel *model3 = [SJCycleCollectionCellModel new];
    model3.URLStr = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511781482340&di=cf3c5e82d71454a4920645821dc05092&imgtype=0&src=http%3A%2F%2Fp2.wmpic.me%2Farticle%2F2016%2F01%2F07%2F1452146668_hWfHalPq.jpg";
    
    SJCycleCollectionCellModel *model4 = [SJCycleCollectionCellModel new];
    model4.URLStr = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512376187&di=966372cd18a57e800c2a53dc8dc417f5&imgtype=jpg&er=1&src=http%3A%2F%2Fimg2.3lian.com%2F2014%2Ff6%2F56%2Fd%2F32.jpg";
    
    _cycleScrollView.models = @[model, model2, model3, model4];
}

@end
