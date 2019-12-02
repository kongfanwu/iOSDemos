//
//  UploadImgInfo.h
//  iCard
//
//  Created by lujunjing on 16-11-7.
//  Copyright (c) 2014年 woaika.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UploadImgInfo : NSObject

@property(nonatomic, strong) NSString *key;
@property(nonatomic, strong) NSString *fileName;
@property(nonatomic, strong) NSData *file;

@end
