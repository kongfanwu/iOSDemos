//
//  DiDiCar.h
//  FWDecorate
//
//  Created by kfw on 2019/9/16.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiDiCarComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface DiDiCar : NSObject <DiDiCarComponent>
- (void)run;
@end

NS_ASSUME_NONNULL_END
