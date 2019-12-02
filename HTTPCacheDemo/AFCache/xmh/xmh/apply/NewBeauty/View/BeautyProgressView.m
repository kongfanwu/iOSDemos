//
//  BeautyProgressView.m
//  xmh
//
//  Created by ald_ios on 2019/5/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyProgressView.h"
@interface BeautyProgressView ()
@property (weak, nonatomic) IBOutlet UIView *container;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *images;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *lbs;


@end
@implementation BeautyProgressView
- (void)updateBeautyProgressViewIndex:(NSInteger)progressIndex
{
    for (int i = 0; i < _images.count; i++) {
        UIImageView * imgv = _images[i];
        UILabel *lb = _lbs[i];
        if (imgv.tag < progressIndex) {
            imgv.image = UIImageName(@"xuanzeguke_yidaozhuangtai");
            lb.textColor = kColorTheme;
        }else{
            imgv.image = UIImageName(@"xuanzeguke_weidaozhuangtai");
            lb.textColor = kColor3;
        }
    }
}


@end
