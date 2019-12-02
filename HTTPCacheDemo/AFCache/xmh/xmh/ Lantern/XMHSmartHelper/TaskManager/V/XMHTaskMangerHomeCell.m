//
//  XMHTaskMangerHomeCell.m
//  xmh
//
//  Created by ald_ios on 2019/6/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTaskMangerHomeCell.h"
#import "XMHTaskManagerHomeListModel.h"
@interface XMHTaskMangerHomeCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbMsg;
@property (weak, nonatomic) IBOutlet UISwitch *s;
@property (weak, nonatomic) IBOutlet UIImageView *more;
@property (weak, nonatomic) IBOutlet UIView *bg;
@property (nonatomic, strong)XMHTaskManagerHomeModel * model;
@end
@implementation XMHTaskMangerHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _bg.layer.cornerRadius = 5;
    _bg.layer.masksToBounds = YES;
    
    _s.tintColor = kColorTheme;
    _s.onTintColor = kColorTheme;
    _s.backgroundColor = kColorE5E5E5;
    _s.cornerRadius = _s.height/2;
    _s.clipsToBounds = YES;
    [_s addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    _lbTitle.font = FONT_SIZE(16);
    _lbMsg.font = FONT_SIZE(13);
    
    _lbTitle.textColor = kColor3;
    _lbMsg.textColor = kColor9;
}
- (void)switchAction:(UISwitch *)s
{
    if (!s.on) {
        s.tintColor = kColorE5E5E5;
        s.backgroundColor = kColorE5E5E5;
    }
    if (_model.status == 2) {
        [XMHProgressHUD showOnlyText:@"请重新选择时间"];
        [self updateCellModel:_model];
        return ;
    }
    if (_model.status == 3) {
        /** 获取当前时间戳与 任务时间戳对比 */
        NSInteger timeSp = [[NSDate date]timeIntervalSince1970];
        if (_model.end_time <= timeSp) {
            [XMHProgressHUD showOnlyText:@"请重新选择时间"];
            return;
        }
    }
    if (_XMHTaskMangerHomeCellSwitchBlock) {
        _XMHTaskMangerHomeCellSwitchBlock(_model,s.on);
    }
}
- (void)updateCellType:(XMHTaskManagerCellType)cellType
{
    if (cellType == XMHTaskManagerCellEdit) {
        _more.hidden = YES;
        _s.hidden = NO;
    }
    if (cellType == XMHTaskManagerCellLook) {
        _more.hidden = NO;
        _s.hidden = YES;
    }
}
- (void)updateCellModel:(XMHTaskManagerHomeModel *)model
{
    _model = model;
    _lbTitle.text = model.name;
    _lbMsg.text = [NSString stringWithFormat:@"共设置%@次任务，执行%@次",model.num,model.track_num];
    if (model.status == 1) {
        _s.on = YES;
        _s.tintColor = kColorTheme;
        _s.onTintColor = kColorTheme;
    }else {
        _s.on = NO;
        _s.tintColor = kColorE5E5E5;
        _s.backgroundColor = kColorE5E5E5;
    }
}
@end
