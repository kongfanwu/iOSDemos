//
//  BeautyGWCCommitTopView.m
//  xmh
//
//  Created by ald_ios on 2019/5/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyGWCCommitTopView.h"
@interface BeautyGWCCommitTopView ()
@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *lb;

@end
@implementation BeautyGWCCommitTopView

- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_view addGestureRecognizer:tap];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"YYYY-MM-dd"];
    
    
}
- (void)tap
{
    if (_BeautyGWCCommitTopViewBlock) {
        _BeautyGWCCommitTopViewBlock();
    }
}
- (void)updateBeautyGWCCommitTopViewTitle:(NSString *)title
{
    _lb.text = title;
}
- (void)updateTitle:(NSString *)title
{
    _lb.text = title;
    _lb.textColor = kColor3;
}
@end
