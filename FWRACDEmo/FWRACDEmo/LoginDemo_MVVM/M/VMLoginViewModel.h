//
//  VMLoginViewModel.h
//  FWRACDEmo
//
//  Created by kfw on 2019/12/20.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "ReactiveObjC-umbrella.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMLoginViewModel : NSObject
@property (nonatomic, strong) NSString *account;

@property (nonatomic, strong) RACSignal *btnEnableSignal;
@property (nonatomic, strong) RACCommand *loginCommand;
@end

NS_ASSUME_NONNULL_END
