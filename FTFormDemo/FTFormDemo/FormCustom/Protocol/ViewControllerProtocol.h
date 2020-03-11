//
//  ViewControllerProtocol.h
//  FTFormDemo
//
//  Created by KFW on 2019/9/17.
//  Copyright © 2019 KFW. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FTFormRow, FTButtonModel;

NS_ASSUME_NONNULL_BEGIN

@protocol ViewControllerProtocol <NSObject>

@optional

/**
 按钮点击回调

 @param row <#row description#>
 @param buttonModel <#buttonModel description#>
 */
- (void)buttonClickRow:(FTFormRow *)row buttonModel:(FTButtonModel *)buttonModel;

/**
 添加自定义

 @param row <#row description#>
 @param customButtonModel <#customButtonModel description#>
 */
- (void)addCustomRow:(FTFormRow *)row customButtonModel:(FTButtonModel *)customButtonModel;

@end

NS_ASSUME_NONNULL_END
