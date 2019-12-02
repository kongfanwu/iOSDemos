//
//  BeautyCFBiaoSelectView.m
//  xmh
//
//  Created by ald_ios on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCFBiaoSelectView.h"
@interface BeautyCFBiaoSelectView ()
@property (weak, nonatomic) IBOutlet UIView *viewStore;
@property (weak, nonatomic) IBOutlet UIView *viewDate;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@end
@implementation BeautyCFBiaoSelectView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _lb1.textColor = _lb2.textColor = kColor3;
    _lb1.font = _lb2.font = FONT_SIZE(14);
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_viewStore addGestureRecognizer:tap1];
    [_viewDate addGestureRecognizer:tap2];
}
- (void)tap:(UITapGestureRecognizer *)tapgest
{
    if ([tapgest.view isEqual:_viewStore]) {
        if (_BeautyCFBiaoSelectViewStoreBlock) {
            _BeautyCFBiaoSelectViewStoreBlock();
        }
    }else if ([tapgest.view isEqual:_viewDate]){
        if (_BeautyCFBiaoSelectViewDateBlock) {
            _BeautyCFBiaoSelectViewDateBlock();
        }
    }else{}
}
- (void)updateBeautyCFBiaoSelectViewLeftTitle:(NSString *)leftTitle
{
    _lb1.text = leftTitle;
}
- (void)updateBeautyCFBiaoSelectViewDate:(NSString *)date
{
    _lb2.text = date?date:@"";
}
@end
