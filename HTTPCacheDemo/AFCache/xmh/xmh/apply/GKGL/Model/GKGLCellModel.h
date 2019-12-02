//
//  GKGLCellModel.h
//  xmh
//
//  Created by ald_ios on 2019/1/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CellType) {
    CellTypeUnknow,
    CellTypeInput,
    CellTypeTime,
    CellTypeCustomerAttribute,
    CellTypeStore,
    CellTypeJis,
};


NS_ASSUME_NONNULL_BEGIN

@interface GKGLCellModel : NSObject
@property (nonatomic, copy)NSString * title;
@property (nonatomic, copy)NSString * value;
@property (nonatomic, copy)NSString * placeHolder;
@property (nonatomic, assign)CellType  cellType;
+ (instancetype)createModelTitle:(NSString *)title placeHolder:(NSString *)placeHolder cellType:(CellType)cellType;
+ (instancetype)createModelTitle:(NSString *)title placeHolder:(NSString *)placeHolder value:(NSString *)value cellType:(CellType)cellType;
@end

NS_ASSUME_NONNULL_END
