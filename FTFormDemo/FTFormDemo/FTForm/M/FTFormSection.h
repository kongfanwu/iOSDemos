//
//  FTFormSection.h
//  FTFormDemo
//
//  Created by KFW on 2019/9/9.
//  Copyright © 2019 KFW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FTFormRow;
@class FTForm;

NS_ASSUME_NONNULL_BEGIN

@interface FTFormSection : NSObject

/** 真实存在的row */
@property (nonatomic, strong) NSMutableArray <FTFormRow *> *formRows;
/** 剔除掉 hidden 存在的row */
@property (nonatomic, strong) NSMutableArray <FTFormRow *> *formRowsHidden;
/** <##> */
@property (nonatomic, weak) FTForm *form;
/** section间间距 默认 0 */
@property (nonatomic) CGFloat sectionEdge;

/**
 添加row
 */
- (void)addRow:(FTFormRow *)row;

@end

NS_ASSUME_NONNULL_END
