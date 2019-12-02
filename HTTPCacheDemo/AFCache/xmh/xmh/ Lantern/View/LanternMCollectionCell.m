//
//  LanternMCollectionCell.m
//  xmh
//
//  Created by ald_ios on 2019/1/30.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMCollectionCell.h"

@implementation LanternMCollectionCell
- (void)setIndexController:(UIViewController *)indexController
{
    indexController.view.frame = self.contentView.bounds;
    [self.contentView addSubview:indexController.view];
}
@end
