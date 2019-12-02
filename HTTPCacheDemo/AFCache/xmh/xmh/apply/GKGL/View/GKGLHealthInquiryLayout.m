//
//  GKGLHealthInquiryLayout.m
//  xmh
//
//  Created by ald_ios on 2019/1/17.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLHealthInquiryLayout.h"

@implementation GKGLHealthInquiryLayout
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray * attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for (int i = 0; i < attributes.count; i++) {
        if (i!= attributes.count - 1) {
            UICollectionViewLayoutAttributes * curAttr = attributes[i];
            UICollectionViewLayoutAttributes * nextAttr = attributes[i + 1];
            if (CGRectGetMinY(curAttr.frame) == CGRectGetMinY(nextAttr.frame)) {
                if (CGRectGetMinX(nextAttr.frame) - CGRectGetMaxX(curAttr.frame) > self.minimumInteritemSpacing) {
                    CGRect frame = nextAttr.frame;
                    CGFloat x = CGRectGetMaxX(curAttr.frame) + self.minimumInteritemSpacing;
                    frame = CGRectMake(x, CGRectGetMinY(frame), frame.size.width, frame.size.height);
                    nextAttr.frame = frame;
                }
            }
        }
    }
    return attributes;
}

@end
