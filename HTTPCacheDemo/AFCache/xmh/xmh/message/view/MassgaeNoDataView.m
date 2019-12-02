//
//  MassgaeNoDataView.m
//  xmh
//
//  Created by ald_ios on 2018/12/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MassgaeNoDataView.h"
@interface MassgaeNoDataView ()
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;

@end
@implementation MassgaeNoDataView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _lb1.textColor = kColor9;
    _lb2.textColor = kColor9;
    _lb1.text = @"灯神温馨提示：";
    _lb2.text = @"暂没有消息提醒哟";
}
- (void)updateMassgaeNoDataViewText:(NSString *)text
{
    _lb2.text = text;
}
@end
