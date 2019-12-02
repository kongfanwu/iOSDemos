//
//  UIImage+GIFImage.h
//  xmh
//
//  Created by ald_ios on 2019/5/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN
typedef void (^GIFimageBlock)(UIImage *GIFImage);
@interface UIImage (GIFImage)
/** 根据本地GIF图片名 获得GIF image对象 */
+ (UIImage *)imageWithGIFNamed:(NSString *)name;

/** 根据一个GIF图片的data数据 获得GIF image对象 */
+ (UIImage *)imageWithGIFData:(NSData *)data;

/** 根据一个GIF图片的URL 获得GIF image对象 */
+ (void)imageWithGIFUrl:(NSString *)url and:(GIFimageBlock)gifImageBlock;
@end

NS_ASSUME_NONNULL_END
