//
//  BookChartSelectStoreView.m
//  xmh
//
//  Created by ald_ios on 2019/3/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookChartSelectStoreView.h"
@interface BookChartSelectStoreView ()
@property (weak, nonatomic) IBOutlet UILabel *lb;

@end

@implementation BookChartSelectStoreView
- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [self addGestureRecognizer:tap];
}
- (void)updateViewParam:(NSMutableDictionary *)param
{
    _lb.text = param[@"name"]?param[@"name"]:@"";
}
- (void)click
{
    if (_BookChartSelectStoreViewBlock) {
        _BookChartSelectStoreViewBlock();
    }
}
@end
