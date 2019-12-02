//
//  GKGLCustomerBillVerifyCollectionViewCell.m
//  xmh
//
//  Created by ald_ios on 2019/1/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCustomerBillVerifyCollectionViewCell.h"
#import <YYWebImage/YYWebImage.h>
@interface GKGLCustomerBillVerifyCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *imgVSelect;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@end
@implementation GKGLCustomerBillVerifyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _icon.layer.cornerRadius = _icon.height/2;
    _icon.layer.masksToBounds = YES;
}
- (void)updateCellParam:(NSDictionary *)param
{
    [_icon yy_setImageWithURL:URLSTR(param[@"head_img"]) placeholder:kDefaultCustomerImage];
    _lbName.text = param[@"name"];
    if ([param[@"selected"] integerValue] == 0) {
        _imgVSelect.hidden = YES;
    }else{
        _imgVSelect.hidden = NO;
    }
}
@end
