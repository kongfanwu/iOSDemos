//
//  MsgRequest.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/5/15.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MsgRequest.h"
#import "Networking.h"
@implementation MsgRequest
+ (void)requestUnReadNumParma:(NSMutableDictionary *)param resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    MsgRequest * request = [[MsgRequest alloc] init];
    [request requestUnReadNumParma:param resultBlock:resultBlock];
    
}
- (void)requestUnReadNumParma:(NSMutableDictionary *)param resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_numTask) {
        [_numTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Messlist/Unread_num",SERVER_APP];
    _numTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info,YES,nil);
        }else{
//            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
//        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestMsgListParam:(NSMutableDictionary *)param resultBlock:(void(^)(LMsgListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
     MsgRequest * request = [[MsgRequest alloc] init];
    [request requestMsgListParam:param resultBlock:resultBlock];
}
- (void)requestMsgListParam:(NSMutableDictionary *)param resultBlock:(void(^)(LMsgListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_msgListTask) {
        [_msgListTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Messlist/getList",SERVER_APP];
    _msgListTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            LMsgListModel * model =  [LMsgListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
+ (void)requestNewHomeMsgListParam:(NSMutableDictionary *)param resultBlock:(void(^)(MsgHomeListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    MsgRequest * request = [[MsgRequest alloc] init];
    [request requestNewHomeMsgListParam:param resultBlock:resultBlock];
}
- (void)requestNewHomeMsgListParam:(NSMutableDictionary *)param resultBlock:(void(^)(MsgHomeListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock
{
    if (_newMsgListTask) {
        [_newMsgListTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Messlist/getNum",SERVER_APP];
    _msgListTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            MsgHomeListModel * model =  [MsgHomeListModel yy_modelWithDictionary:info.data];
            resultBlock(model,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
@end
