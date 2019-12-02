//
//  XMHSmartMessageCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSmartMessageCell.h"
#import "LMsgListModel.h"

@interface XMHSmartMessageCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *unreadLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UILabel *contentlab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeRightLayout;

@end
@implementation XMHSmartMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = kColorF5F5F5;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = 5;
    _contentlab.numberOfLines = 0;
}
- (void)updateSmartMessageCellModel:(LMsgModel *)model
{
    _timeLab.text = model.time;
    _titleLab.text = model.title;
    _contentlab.text = model.content;
    if (1) {//model.unread 下期优化
        self.unreadLab.hidden = YES;
        self.timeRightLayout.constant = -8;
    }else{
        // FW：处理警告，暂时注释掉
//        self.timeRightLayout.constant = 5;
//        self.unreadLab.hidden = NO;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
