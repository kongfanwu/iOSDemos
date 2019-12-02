//
//  BookTimeSubmiitView.m
//  xmh
//
//  Created by ald_ios on 2018/10/22.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookTimeSubmiitView.h"
@interface BookTimeSubmiitView ()
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end
@implementation BookTimeSubmiitView
- (void)updateBookTimeSubmiitView:(NSString *)time
{
    _sureBtn.backgroundColor = kBtn_Commen_Color;
    _lbTime.text = time;
}
- (IBAction)click:(id)sender {
    if ([_lbTime.text isEqualToString:@"请选择"] ||_lbTime.text.length <=0) {
        return;
    }
    if (_BookTimeSubmiitViewBlock) {
        _BookTimeSubmiitViewBlock();
    }
}
@end
