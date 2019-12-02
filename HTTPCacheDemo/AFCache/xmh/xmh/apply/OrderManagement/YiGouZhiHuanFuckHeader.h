//
//  YiGouZhiHuanFuckHeader.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/10.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YiGouZhiHuanFuckHeader : UIView
@property (weak, nonatomic) IBOutlet UIImageView *im1;
@property (weak, nonatomic) IBOutlet UIImageView *im2;
@property (weak, nonatomic) IBOutlet UIImageView *im3;

@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UIImageView *line2;


@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;

- (void)YiGouZhiHuanFuckHeader:(NSInteger)stepValue;


@end
