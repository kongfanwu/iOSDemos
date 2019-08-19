//
//  XMHUserTagModel.h
//  xmh
//
//  Created by kfw on 2019/8/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XMHUserTagModelType) {
    XMHUserTagModelTypeNormal, // 正常类型 只能查看
    XMHUserTagModelTypeEdit, // 编辑
    XMHUserTagModelTypeAdd,    // 添加类型
};

@interface XMHUserTagModel : NSObject
/** <##> */
@property (nonatomic, copy) NSString *ID;
/** <##> */
@property (nonatomic, copy) NSString *name;
/** 选中状态 */
@property (nonatomic) BOOL select;
/** 删除状态 */
@property (nonatomic) BOOL deleteState;
/** 标签类型 默认 XMHUserTagModelTypeNormal */
@property (nonatomic) XMHUserTagModelType type;

/** <##> */
@property (nonatomic) CGSize cellSize;

@end

NS_ASSUME_NONNULL_END
