//
//  XMHCredentiaItemModel.h
//  xmh
//
//  Created by KFW on 2019/4/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, XMHCredentiaItemModelType) {
    XMHCredentiaItemModelTypeNormal,
    XMHCredentiaItemModelTypeArrow, // 待箭头
};

NS_ASSUME_NONNULL_BEGIN

@interface XMHCredentiaItemModel : NSObject
/** 默认 XMHCredentiaItemModelTypeNormal */
@property (nonatomic) XMHCredentiaItemModelType type;
/** <##> */
@property (nonatomic, copy) NSString *title;
/** <##> */
@property (nonatomic, copy) NSString *imageName;
/** <##> */
@property (nonatomic, copy) NSString *count;
/** 服务端key */
@property (nonatomic, copy) NSString *serviceKey;


/**
 销售凭证元数据
 */
+ (NSArray *)salesTongJiArray;

/**
 服务凭证元数据
 */
+ (NSArray *)serviceTongJiArray;

@end

NS_ASSUME_NONNULL_END
