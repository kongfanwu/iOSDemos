//
//  BookCommonCell1.m
//  xmh
//
//  Created by ald_ios on 2018/10/19.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookCommonCell1.h"
#import "LolHomeModel.h"
@interface BookCommonCell1 ()
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *lbName;
/** 项目 */
@property (weak, nonatomic) IBOutlet UILabel *lbValue;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *lbTime;

@end
@implementation BookCommonCell1
- (void)awakeFromNib
{
    [super awakeFromNib];
}
- (void)updateBookCommonCell1Model:(LGuKeDetail *)model
{
    _lbName.text = model.user_name;
    _lbValue.text = model.pro_name;
    _lbTime.text = model.day;
}
@end
