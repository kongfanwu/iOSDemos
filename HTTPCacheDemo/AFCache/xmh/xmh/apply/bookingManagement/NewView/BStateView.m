//
//  BStateView.m
//  xmh
//
//  Created by ald_ios on 2018/10/18.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BStateView.h"
#import "BookQuickRealizeView.h"
@interface BStateView ()
@property (weak, nonatomic) IBOutlet UIImageView *restImgV;
@property (weak, nonatomic) IBOutlet UILabel *lbRest;
@property (strong, nonatomic)BookQuickRealizeView * quickRealizeView;
@property (strong, nonatomic)NSString * pageType;
@property (assign, nonatomic)BOOL isDJL;
@end

@implementation BStateView
{
    NSDictionary *_noticeText;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
   
}
- (void)updateBStateViewisShowRestByPageType:(NSString *)pageType isDJL:(BOOL)isDJL
{
    _pageType = pageType;
    _isDJL = isDJL;

}
- (IBAction)quickRealize:(id)sender
{
    UIWindow * w = [UIApplication sharedApplication].keyWindow;
    [w addSubview:self.quickRealizeView];
    if ([_pageType isEqualToString:@"员工"] ||[_pageType isEqualToString:@"层级"]||[_pageType isEqualToString:@"门店"]) {
        //        _quickRealizeView.tf.text = @"\
        //        是否算达标，取决于员工每天预约/接待人数和每天预约项目数/消耗项目数是否达标。\
        //        \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        //        \执行 a/b=每天接待人数/每天消耗项目数（今日之前）\
        //        \预约 a/b=每天预约人数/每天预约项目数（今日及今日之后）\
        //        \
        //        如：1.今日是18日，之前日期的达标情况，取决于你每天接待的人数和消耗项目数是否达标；\
        //        2.今日是18日，今天及之后日期达标情况，取决于你每天预约人数是否达标\
        //        \
        //        ps：具体达标数值按照商家设置决定";
        _quickRealizeView.tf.hidden = NO;
        _quickRealizeView.tf1.hidden = YES;
    }else if ([_pageType isEqualToString:@"顾客"]){
        _quickRealizeView.tf.hidden = YES;
        _quickRealizeView.tf1.hidden = NO;
        //        _quickRealizeView.tf.text = @"\
        //        是否算达标，取决于当月顾客预约或到店次数，且预约项目数或消耗项目数是否达标\
        //        \
        //        执行 a/b=当月实际到店次数/当月消耗项目数（今日之前）\
        //        预约 a/b=当月预约顾客到店次数/预约顾客项目数（今日及今日之后）\
        //        \
        //        如：1.今日是18日，之前日期的达标情况，取决于实际到店次数和消耗项目数是否达标；\
        //        2.今日是18日，今天及之后日期达标情况，取决于当月预约到店次数是否达标\
        //        \
        //        ps：具体达标数值按照商家设置决定";
    }
    //    _restImgV.hidden = _lbRest.hidden = [pageType isEqualToString:@"4"]?NO:YES;
    //    if ([pageType isEqualToString:@"4"]) {
    //
    //    }
    if (_isDJL) {
        _quickRealizeView.tf.hidden = NO;
        _quickRealizeView.tf1.hidden = YES;
    }
}
- (BookQuickRealizeView *)quickRealizeView
{
    UIWindow * w = [UIApplication sharedApplication].keyWindow;
    if (!_quickRealizeView) {
        _quickRealizeView = loadNibName(@"BookQuickRealizeView");
        _quickRealizeView.frame = w.bounds;
    }
    return _quickRealizeView;
}
@end
