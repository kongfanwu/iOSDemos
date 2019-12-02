//
//  LanternPlanCollectionCell.m
//  xmh
//
//  Created by ald_ios on 2019/1/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternPlanCollectionCell.h"
#import "LanternPlanInfoListModel.h"
@interface LanternPlanCollectionCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *lbName;

@end
@implementation LanternPlanCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _bgView.layer.cornerRadius = 3;
    _bgView.layer.masksToBounds = YES;
}
- (void)updateLanternPlanCollectionCellModel:(LanternPlanProModel *)model
{
    if (model.selected) {
        _bgView.layer.borderColor = [ColorTools colorWithHexString:@"#FF9072"].CGColor;
        _bgView.backgroundColor = [ColorTools colorWithHexString:@"#FFF3F0"];
        _lbName.textColor = [ColorTools colorWithHexString:@"#FF9072"];
        _bgView.layer.borderWidth = 0.1;
    }else{
        _bgView.layer.borderColor = [ColorTools colorWithHexString:@"#F5F5F5"].CGColor;
        _bgView.backgroundColor = [ColorTools colorWithHexString:@"#F5F5F5"];
        _lbName.textColor = [ColorTools colorWithHexString:@"#cccccc"];
        _bgView.layer.borderWidth = 0.0;
    }
    if (model.isAdd || model.isEdit){
        /** 是否是消耗 */
        if (model.isXH.integerValue == 1 || !model.price) {
            _lbName.text = [NSString stringWithFormat:@"%@",model.name];
        }else{
            _lbName.text = [NSString stringWithFormat:@"%@%ld",model.name,model.num.integerValue * model.price.integerValue];
        }
        
    
    }else{
       _lbName.text = model.name;
    }

}
- (void)updateCellParam:(NSDictionary *)param
{
    _lbName.text = param[@"name"];
    if ([param[@"is_have"] integerValue] == 1) {
        _bgView.backgroundColor = [ColorTools colorWithHexString:@"#FFF3F0"];
        _lbName.textColor = [ColorTools colorWithHexString:@"#FF9072"];
    }
    if ([param[@"is_have"] integerValue] == 0) {
        _bgView.backgroundColor = [ColorTools colorWithHexString:@"#F5F5F5"];
        _lbName.textColor = [ColorTools colorWithHexString:@"#CCCCCC"];
    }
}
- (void)updateCellParam:(NSDictionary *)param tag:(NSInteger)tag
{
    _lbName.text = param[@"name"];
    if (tag == 0) {
        _bgView.backgroundColor = [ColorTools colorWithHexString:@"#FFF3F0"];
        _lbName.textColor = [ColorTools colorWithHexString:@"#FF9072"];
    }else if (tag == 1){
        _bgView.layer.borderWidth = 1;
        _bgView.layer.borderColor = [ColorTools colorWithHexString:@"#FF9072"].CGColor;
        _lbName.textColor = [ColorTools colorWithHexString:@"#FF9072"];
        _bgView.backgroundColor = [UIColor whiteColor];
    }else if (tag == 2){
        _bgView.backgroundColor = kColorF5F5F5;
        _lbName.textColor = kColorC;
    }else{}
}
@end
