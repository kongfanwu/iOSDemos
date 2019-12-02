//
//  MessageNextCell.m
//  xmh
//
//  Created by ald_ios on 2018/12/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MessageNextCell.h"
#import "LMsgListModel.h"
@interface MessageNextCell ()
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UILabel *lbMsg;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
@implementation MessageNextCell

- (void)awakeFromNib {
    [super awakeFromNib]; 
    // Initialization code
    _line.backgroundColor = kColorE;
    _lbMsg.textColor = kColor9;
    _lbMsg.font = FONT_SIZE(13);

    _lbTitle.textColor = kColor6;
    _lbTitle.font = FONT_SIZE(15);

    _lbTime.textColor = kColor9;
    _lbTime.font = FONT_SIZE(10);
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _containerView.layer.masksToBounds = YES;
    _containerView.layer.cornerRadius = 5;
    
}
- (void)updateMessageNextCellModel:(LMsgModel *)model
{
    _lbTime.text = model.time;
    _lbTitle.text = model.title;
    _lbMsg.lineSpace = 5;
    _lbMsg.text = model.content;
}
@end
