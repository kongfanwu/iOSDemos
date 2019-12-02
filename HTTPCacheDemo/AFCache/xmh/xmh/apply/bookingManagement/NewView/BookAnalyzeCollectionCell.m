//
//  BookAnalyzeCollectionCell.m
//  xmh
//
//  Created by ald_ios on 2019/3/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookAnalyzeCollectionCell.h"
@interface BookAnalyzeCollectionCell ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end
@implementation BookAnalyzeCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.layer.cornerRadius = 3;
//    self.layer.masksToBounds = YES;
}
- (void)updateCellParam:(NSMutableDictionary *)param
{
    _lb1.text = param[@"name"];
    _lb2.text = [NSString stringWithFormat:@"预约%@/%@",param[@"appoNum"],param[@"appoPro"]];
    _lb3.text = [NSString stringWithFormat:@"执行%@/%@",param[@"servNum"],param[@"servPro"]];
    if ([param[@"state"] integerValue] == 2) {/** 达标 */
        _icon.image = UIImageName(@"styygl_dabiao");
        _bg.backgroundColor = [ColorTools colorWithHexString:@"#ECF8F7"];
        
    }else if ([param[@"state"] integerValue] == 3) {/** 不达标 */
        _icon.image = UIImageName(@"styygl_budabiao");
        _bg.backgroundColor = [ColorTools colorWithHexString:@"#FFF4FA"];
    }else{}
}
@end
