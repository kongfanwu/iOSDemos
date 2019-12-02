//
//  BookTimeCollectionCell.m
//  xmh
//
//  Created by ald_ios on 2018/10/26.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookTimeCollectionCell.h"
#import "BookJisTimeList.h"
@interface BookTimeCollectionCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *lbName;



@end

@implementation BookTimeCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)updateBookTimeCollectionCellModel:(BookJisTime *)model
{
    
    if(model.state.integerValue == 1){
        if (model.isSelect) {
            _lbName.text = model.time;
            _lbName.textColor = kBtn_Commen_Color;
            _bgView.backgroundColor = [ColorTools colorWithHexString:@"#FEF2F8"];
            _bgView.layer.borderWidth = 1;
            _bgView.layer.borderColor = kBtn_Commen_Color.CGColor;
        }else{
            _lbName.text = model.time;
            _lbName.textColor = kLabelText_Commen_Color_3;
            _bgView.layer.borderWidth = 1;
            _bgView.layer.borderColor = kLabelText_Commen_Color_9.CGColor;
            _bgView.backgroundColor = [UIColor whiteColor];
        }
    }
    if (model.state.integerValue == 5) {
        if (model.isSelect) {
            _lbName.text = model.time;
            _lbName.textColor = kBtn_Commen_Color;
            _bgView.backgroundColor = [ColorTools colorWithHexString:@"#FEF2F8"];
            _bgView.layer.borderWidth = 1;
            _bgView.layer.borderColor = kBtn_Commen_Color.CGColor;
        }else{
            _lbName.text = model.time;
            _bgView.backgroundColor = [ColorTools colorWithHexString:@"#E5E5E5"];
            _bgView.layer.borderColor = kLabelText_Commen_Color_9.CGColor;
            _bgView.layer.borderWidth = 0;
        }
    }
    if (model.state.integerValue == 3) {
        _lbName.text = @"已预约";
        _lbName.textColor = [UIColor whiteColor];
        _bgView.backgroundColor = [ColorTools colorWithHexString:@"#48C2AF"];
        _bgView.layer.borderWidth = 0;
//        _bgView.layer.borderColor = kBtn_Commen_Color.CGColor;
    }
    if (model.state.integerValue == 4) {
        _lbName.text = @"休息";
        _lbName.textColor = kLabelText_Commen_Color_3;
        _bgView.backgroundColor = [ColorTools colorWithHexString:@"#CCCCCC"];
        _bgView.layer.borderWidth = 0;
    }
    if (model.state.integerValue == 0) {
        _lbName.text = @"已过时";
        _lbName.textColor = [UIColor whiteColor];
        _bgView.backgroundColor = [ColorTools colorWithHexString:@"#FF9072"];
        _bgView.layer.borderWidth = 0;
    }
    
    

}
@end
