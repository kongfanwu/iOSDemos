//
//  XMHUserTagSectionModel.h
//  xmh
//
//  Created by kfw on 2019/8/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMHUserTagModel;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XMHUserTagSectionModelType) {
    XMHUserTagSectionModelTypeNormal, // 正常类型
    XMHUserTagSectionModelTypeAdd,    // 添加类型
};

@interface XMHUserTagSectionModel : NSObject
/** <##> */
@property (nonatomic, copy) NSString *ID;
/** <##> */
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *footerName;
/** <##> */
@property (nonatomic, strong, nullable) NSMutableArray <XMHUserTagModel *> *childs;
/** 标签类型 默认 XMHUserTagSectionModelTypeNormal */
@property (nonatomic) XMHUserTagSectionModelType type;

@end

NS_ASSUME_NONNULL_END
