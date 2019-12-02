//
//  UIImage+Reduce.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/22.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Reduce)
/**
 * 压缩图片
 */
- (NSData *)imageCompressToData;

/**
 通过颜色创建图片
 
 @param color 颜色
 @param size 大小
 @return UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
