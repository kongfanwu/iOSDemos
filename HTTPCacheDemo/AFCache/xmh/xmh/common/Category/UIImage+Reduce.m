//
//  UIImage+Reduce.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/22.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "UIImage+Reduce.h"

@implementation UIImage (Reduce)
- (NSData *)imageCompressToData{
    NSData *data=UIImageJPEGRepresentation(self, 1.0);
//    if (data.length>300*1024) {
//        if (data.length>1024*1024) {//1M以及以上
//            data=UIImageJPEGRepresentation(self, 0.1);
//        }else if (data.length>512*1024) {//0.5M-1M
//            data=UIImageJPEGRepresentation(self, 0.5);
//        }else if (data.length>300*1024) {//0.25M-0.5M
//            data=UIImageJPEGRepresentation(self, 0.9);
//        }
//    }
      data=UIImageJPEGRepresentation(self, 0.1);
    return data;
}

/**
 通过颜色创建图片

 @param color 颜色
 @param size 大小
 @return UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
