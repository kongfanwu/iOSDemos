//
//  XMHDataReportCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHDataReportCell.h"
#import "XMHDataReportListModel.h"
#import "NSString+NCDate.h"
@interface XMHDataReportCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *timeLa;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@end

@implementation XMHDataReportCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [ColorTools colorWithHexString:@"#F5F5F5"];
    self.bgView.layer.cornerRadius = 5;
}
- (void)refreshCellWithModel:(XMHDataReportModel *)model
{
    
    if ([NSString checkIsToday:model.create_time]) {// 当天
        self.timeLa.text =  [NSString formateDateToHHmm:model.create_time];
    }else if ([NSString checkIsCurrentMonth:model.create_time]){// 当月
        self.timeLa.text =  [NSString formateDateToMMdd:model.create_time];
    }else{
         self.timeLa.text =  [NSString formateDateToYYYYMMdd:model.create_time];
    }
    self.nameLab.text = model.name;
    self.detailLab.text = [NSString stringWithFormat:@"共设置%@次任务,执行%@次",model.all,model.zhi];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
