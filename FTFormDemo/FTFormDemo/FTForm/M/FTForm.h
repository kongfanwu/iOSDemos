//
//  FTForm.h
//  FTFormDemo
//
//  Created by KFW on 2019/9/9.
//  Copyright © 2019 KFW. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FTFormSection;

NS_ASSUME_NONNULL_BEGIN

@interface FTForm : NSObject

/**  */
@property (nonatomic, strong) NSMutableArray <FTFormSection *> *formSections;

/**
 添加section
 */
- (void)addSection:(FTFormSection *)formSection;

@end

NS_ASSUME_NONNULL_END
