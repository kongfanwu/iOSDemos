//
//  FTFormVCProtocol.h
//  FTFormDemo
//
//  Created by KFW on 2019/9/18.
//  Copyright © 2019 KFW. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FTFormVCProtocol <NSObject>
@optional
- (void)rowValueDidChangeRow:(FTFormRow *)row newValue:(id)newValue oldValue:(id)oldValue;
@end

NS_ASSUME_NONNULL_END
