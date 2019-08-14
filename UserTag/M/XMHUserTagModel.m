//
//  XMHUserTagModel.m
//  xmh
//
//  Created by kfw on 2019/8/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHUserTagModel.h"

static NSDictionary * XMHUserTagModelBoundingAttributes() {
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSFontAttributeName: FONT_SIZE(14), NSParagraphStyleAttributeName: style};
    return attributes;
}

@implementation XMHUserTagModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _type = XMHUserTagModelTypeNormal;
    }
    return self;
}

- (CGSize)cellSize {
    if (!CGSizeEqualToSize(_cellSize, CGSizeZero)) return _cellSize;

    // 84 6个字符宽度。
    CGRect rect = [_name boundingRectWithSize:CGSizeMake(MAXFLOAT, 16) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:XMHUserTagModelBoundingAttributes() context:nil];
    CGFloat w = rect.size.width;
    if (w > 86) {
        w = 86;
    }
    
    if (_type == XMHUserTagModelTypeAdd) {
        w += 22;
    }
    
    // 30 气泡左右间距
    _cellSize = CGSizeMake(w + 15 + 25, 40);
    
    return _cellSize;
}

@end
