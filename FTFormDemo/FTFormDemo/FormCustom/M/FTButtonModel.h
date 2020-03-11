//
//  FTButtonModel.h
//  FTFormDemo
//
//  Created by KFW on 2019/9/17.
//  Copyright © 2019 KFW. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FTButtonModelType) {
    FTButtonModelTypeNormal, // 默认
    FTButtonModelTypeCustom, // 自定义
};

@interface FTButtonModel : NSObject

/** <##> */
@property (nonatomic) BOOL select;
/** <##> */
@property (nonatomic, copy) NSString *title;
/** 默认 FTButtonModelTypeNormal */
@property (nonatomic) FTButtonModelType type;
@end

NS_ASSUME_NONNULL_END
