//
//  DiDiCarDecorate.h
//  FWDecorate
//
//  Created by kfw on 2019/9/16.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiDiCarComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface DiDiCarDecorate : NSObject <DiDiCarComponent>
@property (nonatomic, strong) id <DiDiCarComponent> component;

- (id)initWithCarComponent:(id <DiDiCarComponent>) component;

- (void)run;
@end

NS_ASSUME_NONNULL_END
