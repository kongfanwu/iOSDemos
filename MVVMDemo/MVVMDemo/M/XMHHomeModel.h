//
//  XMHHomeModel.h
//  MVVMDemo
//
//  Created by kfw on 2020/11/14.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHHomeModel : NSObject
///
@property (nonatomic, copy) NSString *name;
///
@property (nonatomic) BOOL like;
@property (nonatomic) NSInteger count;

///
@property (nonatomic, strong) RACCommand *likeBlogCommand;
@end

NS_ASSUME_NONNULL_END
