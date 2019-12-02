//
//  LanternMSearchCell.m
//  xmh
//
//  Created by ald_ios on 2019/2/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMSearchCell.h"
@interface LanternMSearchCell ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIImageView *img;
/** 日期 */
@property (weak, nonatomic) IBOutlet UILabel *lbDate;
/** 日期时间 */
@property (weak, nonatomic) IBOutlet UILabel *lb1;
/** 人数 */
@property (weak, nonatomic) IBOutlet UILabel *lb2;
/** 占比 */
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UIView *lbline;
@property (weak, nonatomic) IBOutlet UIButton *btnDel;


@end
@implementation LanternMSearchCell
{
    NSDictionary * _param;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _view1.layer.cornerRadius = 5;
    _view1.layer.masksToBounds = YES;
    _img.layer.cornerRadius = _img.height/2;
    _img.layer.masksToBounds = YES;
    UILongPressGestureRecognizer * gest = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpress:)];
    [self addGestureRecognizer:gest];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)updateCellParam:(NSDictionary *)param
{
    _lbDate.text = param[@"create_time"];
    _lb1.text = param[@"name"];
    _lb2.text = param[@"num"];
    _lb3.text = param[@"bfb"];
    _param = param;
}
- (void)longpress:(UILongPressGestureRecognizer *)gest
{
    _btnDel.hidden = NO;
}
- (IBAction)btnDelClick:(id)sender {
    if (_LanternMSearchCellDelBlock) {
        _LanternMSearchCellDelBlock(_param);
    }
}
@end
