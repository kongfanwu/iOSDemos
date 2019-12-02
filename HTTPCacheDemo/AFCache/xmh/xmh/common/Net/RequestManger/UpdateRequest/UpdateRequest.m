//
//  UpdateRequest.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/8/7.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "UpdateRequest.h"

@implementation UpdateRequest
+ (void)requestVersionParam:(NSMutableDictionary *)param resultBlock:(void(^)(NSDictionary *dataDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    UpdateRequest * request = [[UpdateRequest alloc] init];
    [request requestVersionParam:param resultBlock:resultBlock];
}
- (void)requestVersionParam:(NSMutableDictionary *)param resultBlock:(void(^)(NSDictionary *dataDic, BOOL isSuccess, NSDictionary * errorDic))resultBlock{
    if (_updateTask) {
        [_updateTask cancel];
    }
    NSString * url = [NSString stringWithFormat:@"%@v5.Version/version",SERVER_APP];
    _updateTask = [Networking requestWithURL:url params:param requsetMethod:EAFRequestMethod_Post success:^(id  _Nullable result) {
        BaseModel  * info = [BaseModel yy_modelWithDictionary:result];
        if (info.code ==1) {
            resultBlock(info.data,YES,nil);
        }else{
            [MzzHud toastWithTitle:@"提示" message:info.msg];
        }
    } fail:^(id  _Nullable errorresult) {
        resultBlock(nil,NO,@{@"error":@"网络请求错误"});
        [MzzHud toastWithTitle:@"提示" message:@"网络请求错误"];
    }];
}
@end
