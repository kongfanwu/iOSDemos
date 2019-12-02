//
//  BookTimeJisView.m
//  xmh
//
//  Created by ald_ios on 2018/10/22.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookTimeJisView.h"
#import <YYWebImage/YYWebImage.h>
#import "BookJisTimeList.h"
@interface BookTimeJisView ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@end
@implementation BookTimeJisView
- (void)updateBookTimeJisViewModel:(BookJisTimeList *)model
{
    [_icon yy_setImageWithURL:URLSTR(model.img) placeholder:kDefaultJisImage];
    _lbName.text = model.name;
}
@end
