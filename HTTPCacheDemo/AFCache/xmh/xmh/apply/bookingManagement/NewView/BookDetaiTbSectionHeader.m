//
//  BookDetaiTbSectionHeader.m
//  xmh
//
//  Created by ald_ios on 2018/10/22.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookDetaiTbSectionHeader.h"
@interface BookDetaiTbSectionHeader ()
@property (weak, nonatomic) IBOutlet UILabel *lbName;

@end
@implementation BookDetaiTbSectionHeader
{
    NSArray * _sectionName;
    NSInteger _index;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    _sectionName = @[@"请选择顾客预约内容",@"请选择服务技师时间"];
}
- (void)updateBookDetaiTbSectionHeader:(NSInteger)index
{
    _index = index;
    _lbName.text = _sectionName[index];
}
- (void)tap:(UITapGestureRecognizer *)tap
{
    if (_BookDetaiTbSectionHeaderBlock) {
        _BookDetaiTbSectionHeaderBlock(_index);
    }
}
@end
