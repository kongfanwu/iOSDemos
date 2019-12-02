//
//  ApproveDetailModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApproveDetailModel : NSObject

@property (nonatomic, copy)NSString * token;
@property (nonatomic, copy)NSString * accountId;
@property (nonatomic, copy)NSString * join_code;
@property (nonatomic, copy)NSString * code;
@property (nonatomic, copy)NSString * urlstr;
@property (nonatomic, copy)NSString * navTitle;
@property (nonatomic, copy)NSString * from;
@property (nonatomic, copy)NSString * ordernum;
@property (nonatomic, assign)BOOL fromList;
+ (instancetype)initWithToken:(NSString *)token joinCode:(NSString *)joinCode code:(NSString *)code accountId:(NSString *)accountId url:(NSString *)urlStr navTitle:(NSString *)navTitle from:(NSString *)from ordernum:(NSString *)ordernum fromList:(BOOL)fromList;
@end
