//
//  XMHACDataTopView.m
//  xmh
//
//  Created by ald_ios on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHACDataTopView.h"
#import "XMHCouponSendDataHeaderModel.h"
@interface XMHACDataTopView ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;

@end
@implementation XMHACDataTopView

- (void)awakeFromNib
{
    [super awakeFromNib];
}
- (void)updateViewModel:(XMHCouponSendDataHeaderModel *)model
{
    _lb1.text = model.bygk;
    _lb2.text = model.xzgk;
    _lb3.text = model.xmgk;
    _lb4.text = model.lsgk;
}
@end
