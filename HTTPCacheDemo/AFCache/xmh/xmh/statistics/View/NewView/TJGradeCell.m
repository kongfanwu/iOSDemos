//
//  TJGradeCell.m
//  xmh
//
//  Created by ald_ios on 2018/12/7.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJGradeCell.h"
#import "CustomerGradeListModel.h"
@interface TJGradeCell ()

@property (weak, nonatomic) IBOutlet UILabel *lb;
@end

@implementation TJGradeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)updateTJGradeCellModel:(CustomerSubGradeModel *)model type:(NSString *)type;
{
    _lb.text = [NSString stringWithFormat:@"%@：%@人",model.name,model.num];
    if ([type isEqualToString:model.key]) {
        _lb.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }else{
        _lb.textColor = kColor9;
    }
    
}
@end
