//
//  TJSectionTbHeader.m
//  xmh
//
//  Created by ald_ios on 2018/12/3.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJSectionTbHeader.h"
@interface TJSectionTbHeader ()
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

@end
@implementation TJSectionTbHeader
- (void)updateTJSectionTbHeaderTitle:(NSString *)title
{
    _lbTitle.text = title;
}
@end
