//
//  GKGLHealthInquiryCell.m
//  xmh
//
//  Created by ald_ios on 2019/1/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLHealthInquiryCell.h"
@interface GKGLHealthInquiryCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbName;

@end
@implementation GKGLHealthInquiryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)updateCellParam:(NSDictionary *)param
{
    _lbName.text = param[@"name"];
}
@end
