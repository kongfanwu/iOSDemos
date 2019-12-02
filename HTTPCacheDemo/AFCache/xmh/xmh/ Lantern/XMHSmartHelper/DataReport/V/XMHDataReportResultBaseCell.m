//
//  XMHDataReportResultBaseCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHDataReportResultBaseCell.h"

@implementation XMHDataReportResultBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithModel:(XMHExecutionResultModel *)model {
    [super configureWithModel:model];
}
// 更新布局
- (void)updataMarkLine {}

- (void)resetMarkLine {}
@end
