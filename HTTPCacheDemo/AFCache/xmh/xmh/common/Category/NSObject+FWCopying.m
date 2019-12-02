//
//  NSObject+FWCopying.m
//  Aladdin
//
//  Created by 孔凡伍 on 15/9/25.
//  Copyright © 2015年 kongfanwu. All rights reserved.
//

#import "NSObject+FWCopying.h"
#import <objc/message.h>

@implementation XMHFake_YYModelMeta
- (instancetype)initWithClass:(Class)cls { return XMHFake_YYModelMeta.new; }
@end

@implementation XMHFake_YYModelPropertyMeta
@end

@implementation NSObject (FWCopying)

#pragma mark - NSCopying NSMutableCopying

- (id)copyWithZone:(nullable NSZone *)zone
{
    return [self yy_modelCopy];
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone
{
    return [self yy_modelMutableCopy];
}

#pragma mark - Public

- (id)yy_modelMutableCopy {
    if (self == (id)kCFNull) return self;
    
    // 创建私有类
    Class cls = NSClassFromString(@"_YYModelMeta");
    // XMHFake_YYModelMeta *  为了编译通过。实际不是此类型
    XMHFake_YYModelMeta *modelMeta = [cls alloc];
    if ([modelMeta respondsToSelector:@selector(initWithClass:)]) {
        modelMeta = [modelMeta initWithClass:self.class];
    }
    
    
    if (modelMeta->_nsType) return [self copy];
    
    NSObject *one = [self.class new];
    // XMHFake_YYModelPropertyMeta *  为了编译通过。实际不是此类型
    for (XMHFake_YYModelPropertyMeta *propertyMeta in modelMeta->_allPropertyMetas) {
        if (!propertyMeta->_getter || !propertyMeta->_setter) continue;
        
        if (propertyMeta->_isCNumber) {
            switch (propertyMeta->_type & YYEncodingTypeMask) {
                case YYEncodingTypeBool: {
                    bool num = ((bool (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                    ((void (*)(id, SEL, bool))(void *) objc_msgSend)((id)one, propertyMeta->_setter, num);
                } break;
                case YYEncodingTypeInt8:
                case YYEncodingTypeUInt8: {
                    uint8_t num = ((bool (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                    ((void (*)(id, SEL, uint8_t))(void *) objc_msgSend)((id)one, propertyMeta->_setter, num);
                } break;
                case YYEncodingTypeInt16:
                case YYEncodingTypeUInt16: {
                    uint16_t num = ((uint16_t (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                    ((void (*)(id, SEL, uint16_t))(void *) objc_msgSend)((id)one, propertyMeta->_setter, num);
                } break;
                case YYEncodingTypeInt32:
                case YYEncodingTypeUInt32: {
                    uint32_t num = ((uint32_t (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                    ((void (*)(id, SEL, uint32_t))(void *) objc_msgSend)((id)one, propertyMeta->_setter, num);
                } break;
                case YYEncodingTypeInt64:
                case YYEncodingTypeUInt64: {
                    uint64_t num = ((uint64_t (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                    ((void (*)(id, SEL, uint64_t))(void *) objc_msgSend)((id)one, propertyMeta->_setter, num);
                } break;
                case YYEncodingTypeFloat: {
                    float num = ((float (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                    ((void (*)(id, SEL, float))(void *) objc_msgSend)((id)one, propertyMeta->_setter, num);
                } break;
                case YYEncodingTypeDouble: {
                    double num = ((double (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                    ((void (*)(id, SEL, double))(void *) objc_msgSend)((id)one, propertyMeta->_setter, num);
                } break;
                case YYEncodingTypeLongDouble: {
                    long double num = ((long double (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                    ((void (*)(id, SEL, long double))(void *) objc_msgSend)((id)one, propertyMeta->_setter, num);
                } // break; commented for code coverage in next line
                default: break;
            }
        } else {
            if (propertyMeta->_type & YYEncodingTypePropertyWeak) {
                NSLog(@"YYEncodingTypePropertyWeak");
                id value = ((id (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                NSLog(@"self:%@ value:%@",one, value);
                ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)one, propertyMeta->_setter, value);
            } else {
                switch (propertyMeta->_type & YYEncodingTypeMask) {
                    case YYEncodingTypeObject:
                    case YYEncodingTypeClass: {
                        id value = ((id (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                        value = [value mutableCopy];
                        ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)one, propertyMeta->_setter, value);
                    } break;
                    case YYEncodingTypeBlock: {
                        id value = ((id (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                        ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)one, propertyMeta->_setter, value);
                    } break;
                    case YYEncodingTypeSEL:
                    case YYEncodingTypePointer:
                    case YYEncodingTypeCString: {
                        size_t value = ((size_t (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                        ((void (*)(id, SEL, size_t))(void *) objc_msgSend)((id)one, propertyMeta->_setter, value);
                    } break;
                    case YYEncodingTypeStruct:
                    case YYEncodingTypeUnion: {
                        @try {
                            NSValue *value = [self valueForKey:NSStringFromSelector(propertyMeta->_getter)];
                            if (value) {
                                value = [value mutableCopy];
                                [one setValue:value forKey:propertyMeta->_name];
                            }
                        } @catch (NSException *exception) {}
                    } // break; commented for code coverage in next line
                    default: break;
                }
                
            }
        }
    }
    return one;
}

@end
