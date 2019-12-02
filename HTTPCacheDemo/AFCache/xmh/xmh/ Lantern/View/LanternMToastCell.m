//
//  LanternMToastCell.m
//  xmh
//
//  Created by ald_ios on 2019/2/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMToastCell.h"
@interface LanternMToastCell ()
@property (weak, nonatomic) IBOutlet UILabel *lb;

@end
@implementation LanternMToastCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)updateCellParam:(NSString *)param
{
    _lb.text = param;
}

@end
