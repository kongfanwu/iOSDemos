//
//  NSObject+FWCopying.h
//  Aladdin
//
//  Created by 孔凡伍 on 15/9/25.
//  Copyright © 2015年 kongfanwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

/*
    以 XMHFakexxx 开头的类是伪造后边的实际私有类。例如 XMHFake_YYModelMeta 伪造 _YYModelMeta。只为能编译时期通过。
 */
@interface XMHFake_YYModelMeta : NSObject {
    @package
    YYClassInfo *_classInfo;
    //    /// Key:mapped key and key path, Value:_YYModelPropertyMeta.
    NSDictionary *_mapper;
    //    /// Array<_YYModelPropertyMeta>, all property meta of this model.
    NSArray *_allPropertyMetas;
    //    /// Array<_YYModelPropertyMeta>, property meta which is mapped to a key path.
    NSArray *_keyPathPropertyMetas;
    //    /// Array<_YYModelPropertyMeta>, property meta which is mapped to multi keys.
    NSArray *_multiKeysPropertyMetas;
    //    /// The number of mapped key (and key path), same to _mapper.count.
    NSUInteger _keyMappedCount;
    /// Model class type.
    NSUInteger _nsType;
    
    BOOL _hasCustomWillTransformFromDictionary;
    BOOL _hasCustomTransformFromDictionary;
    BOOL _hasCustomTransformToDictionary;
    BOOL _hasCustomClassFromDictionary;
}
- (instancetype)initWithClass:(Class)cls;
@end

@interface XMHFake_YYModelPropertyMeta : NSObject {
    @package
    NSString *_name;             ///< property's name
    NSUInteger _type;        ///< property's type
    NSUInteger _nsType;    ///< property's Foundation type
    BOOL _isCNumber;             ///< is c number type
    Class _cls;                  ///< property's class, or nil
    Class _genericCls;           ///< container's generic class, or nil if threr's no generic class
    SEL _getter;                 ///< getter, or nil if the instances cannot respond
    SEL _setter;                 ///< setter, or nil if the instances cannot respond
    BOOL _isKVCCompatible;       ///< YES if it can access with key-value coding
    BOOL _isStructAvailableForKeyedArchiver; ///< YES if the struct can encoded with keyed archiver/unarchiver
    BOOL _hasCustomClassFromDictionary; ///< class/generic class implements +modelCustomClassForDictionary:
    
    /*
     property->key:       _mappedToKey:key     _mappedToKeyPath:nil            _mappedToKeyArray:nil
     property->keyPath:   _mappedToKey:keyPath _mappedToKeyPath:keyPath(array) _mappedToKeyArray:nil
     property->keys:      _mappedToKey:keys[0] _mappedToKeyPath:nil/keyPath    _mappedToKeyArray:keys(array)
     */
    NSString *_mappedToKey;      ///< the key mapped to
    NSArray *_mappedToKeyPath;   ///< the key path mapped to (nil if the name is not key path)
    NSArray *_mappedToKeyArray;  ///< the key(NSString) or keyPath(NSArray) array (nil if not mapped to multiple keys)
    YYClassPropertyInfo *_info;  ///< property's info
    XMHFake_YYModelPropertyMeta *_next; ///< next meta if there are multiple properties mapped to the same key.
}
@end

/**
 *  copy 指针拷贝
 *  mutableCopy 深度拷贝 1) 元素对象深度拷贝 2) 集合类型，本身深度拷贝，集合里元素指针拷贝
 */
@interface NSObject (FWCopying) <NSCopying, NSMutableCopying>

- (id)yy_modelMutableCopy;

@end
