//
//  XMHShoppingCartBaseModel.m
//  xmh
//
//  Created by KFW on 2019/4/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHShoppingCartBaseModel.h"

@implementation XMHShoppingCartBaseModel

//- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
//    //
//    if (self.num <= 0) {
//        self.defaultNum = 0;
//        self.selectCount = _defaultNum;
//    }
//    return YES;
//}

+ (NSDictionary *)modelCustomPropertyMapper {
    return NSMutableDictionary.new;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.defaultNum = 1;
        self.selectCount = _defaultNum;
    }
    return self;
}

- (NSString *)id_code {
    if (IsEmpty(_id_code)) {
        _id_code = [NSString stringWithFormat:@"%@_%@", _ID, _code];
    }
    return _id_code;
}

- (void)setID:(NSString *)ID {
    _ID = ID;
    // 初始化设置完 ID code后，设置 shoppingId
    [self updateShoppingId];
}

- (void)setCode:(NSString *)code {
    _code = code;
    // 初始化设置完 ID code后，设置 shoppingId
    [self updateShoppingId];
}

/**
 更新购物唯一id。使用场景：如想加入到购物车，先做mutableCopy操作，在调用 updateShoppingId 更新 shoppingId 属性。
 */
- (void)updateShoppingId {
    if (!IsEmpty(_ID) && !IsEmpty(_code)) {
        self.shoppingId = [NSString stringWithFormat:@"%@_%@_%@", _ID, _code, @(NSDate.new.timeIntervalSince1970).stringValue];
    }
}

/**
 重置model
 */
- (void)reset {
    self.selectCount = _defaultNum;
}


/**
 剩余金额.回收置换
 */
- (CGFloat)computeShengyuPrice {
    return 0;
}
@end
