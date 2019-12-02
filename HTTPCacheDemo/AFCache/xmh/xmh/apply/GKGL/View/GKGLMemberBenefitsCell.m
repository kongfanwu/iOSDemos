//
//  GKGLMemberBenefitsCell.m
//  xmh
//
//  Created by ald_ios on 2019/1/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLMemberBenefitsCell.h"
@interface GKGLMemberBenefitsCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbSubName;
@property (weak, nonatomic) IBOutlet UILabel *lbYear;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (weak, nonatomic) IBOutlet UIImageView *imgStatus;


@end

@implementation GKGLMemberBenefitsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _bgImgV.layer.cornerRadius = 10;
    _bgImgV.layer.masksToBounds = YES;
//    _bgImgV.backgroundColor = kColor9;
    _imgStatus.hidden = YES;
    _lbYear.layer.borderWidth = 1;
    _lbYear.layer.cornerRadius = 2;
    _lbYear.layer.masksToBounds = YES;
    _btn.layer.cornerRadius = 13;
    _btn.layer.masksToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)updateCellParam:(NSDictionary *)param cellType:(NSInteger )tag
{
    _lbName.text = [NSString stringWithFormat:@"%@权益包",param[@"name"]];
    _lbSubName.text = param[@"type_name"];
    _lbYear.text = [NSString stringWithFormat:@"%@年有效期",param[@"validity"]];
    [_btn setTitle:param[@"statue_name"] forState:UIControlStateNormal];
    if ([param[@"type"] integerValue] == 1) {
        _bgImgV.image = UIImageName(@"gkgl_hyqypuka");
        _lbName.textColor = _lbSubName.textColor = _lbYear.textColor = [UIColor whiteColor];
        _btn.backgroundColor = [ColorTools colorWithHexString:@"#373941"];
        _lbYear.layer.borderColor = [ColorTools colorWithHexString:@"#373941"].CGColor;
    }
    if ([param[@"type"] integerValue] == 2) {
        _bgImgV.image = UIImageName(@"gkgl_hyqyyinka"); 
        _lbName.textColor = _lbSubName.textColor = _lbYear.textColor = [UIColor whiteColor];
        _btn.backgroundColor = [ColorTools colorWithHexString:@"#394B67"];
        _lbYear.layer.backgroundColor = [UIColor whiteColor].CGColor;
    }
    if ([param[@"type"] integerValue] == 3) {
        _bgImgV.image = UIImageName(@"gkgl_hyqyjinka");
        _lbName.textColor = _lbSubName.textColor = _lbYear.textColor = [ColorTools colorWithHexString:@"#7A4F00"];
        _btn.backgroundColor = [ColorTools colorWithHexString:@"#7A4F00"];
        _lbYear.layer.borderColor = [ColorTools colorWithHexString:@"#7A4F00"].CGColor;
    }
    if ([param[@"type"] integerValue] == 4) {
        _bgImgV.image = UIImageName(@"gkgl_hyqybujin");
        _lbName.textColor = _lbSubName.textColor = _lbYear.textColor = [ColorTools colorWithHexString:@"#8B6033"];;
        _btn.backgroundColor = [ColorTools colorWithHexString:@"##8B6033"];;
        _lbYear.layer.backgroundColor = [ColorTools colorWithHexString:@"#8B6033"].CGColor;
    }
    if ([param[@"type"] integerValue] == 5) {
        _bgImgV.image = UIImageName(@"gkgl_hyqyzuanshi");
        _lbName.textColor = _lbSubName.textColor = _lbYear.textColor = [ColorTools colorWithHexString:@"#803100"];
        _btn.backgroundColor = [ColorTools colorWithHexString:@"#803100"];
        _lbYear.layer.borderColor = [ColorTools colorWithHexString:@"#803100"].CGColor;
    }
    if ([param[@"type"] integerValue] == 6) {
        _bgImgV.image = UIImageName(@"gkgl_hyqyzhizun@");
        _lbName.textColor = _lbSubName.textColor = _lbYear.textColor = [UIColor whiteColor];
        _btn.backgroundColor = [UIColor whiteColor];
        [_btn setTitleColor:[ColorTools colorWithHexString:@"#5F6473"] forState:UIControlStateNormal];
        _lbYear.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    if ([param[@"type"] integerValue] == 7) {
        _bgImgV.image = UIImageName(@"gkgl_hyqynvwang");
        _lbName.textColor = _lbSubName.textColor = _lbYear.textColor = [ColorTools colorWithHexString:@"#E4B867"];
        _btn.backgroundColor = [ColorTools colorWithHexString:@"#E4B867"];
        _lbYear.layer.backgroundColor = [ColorTools colorWithHexString:@"#E4B867"].CGColor;
    }
    if (tag == 1) {
        _imgStatus.hidden = NO;
    }
}
@end
