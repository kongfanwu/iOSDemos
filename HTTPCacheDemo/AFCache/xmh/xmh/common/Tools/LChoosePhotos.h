//
//  LChoosePhotos.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/1.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LChoosePhotos : NSObject
@property (nonatomic, copy)void (^beforeResultBlock)(NSArray *images,NSArray *assets);
@property (nonatomic, copy)void (^afterResultBlock)(NSArray *images,NSArray *assets);

//设置最大选择照片数默认9
@property (nonatomic, assign)NSInteger maxNum;
@property (nonatomic ,strong)NSString *before;
@property (nonatomic ,strong)NSMutableArray *delectBeforeArray;
@property (nonatomic ,strong)NSMutableArray *delectAftereArray;

- (void)show;
@end
