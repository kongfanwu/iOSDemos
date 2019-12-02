//
//  TJCustomerListModel.m
//  xmh
//
//  Created by ald_ios on 2018/12/5.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJCustomerListModel.h"

@implementation TJCustomerListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [TJCustomerModel class]};
}
@end

@implementation TJCustomerModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"keci":@"jiedaikeci",
             @"chengjiao":@"chengjiaorenshu",
             @"shicaoxiangmushu":@"xiaohaoxiangmushu"
             };
}

/**
 计算百分比

 @param allKey 总数
 @param var 当前数
 @return 百分比
 */
- (NSString *)bfbComputeTotalVarKey:(NSString *)allKey var:(NSString *)var {
    CGFloat all_xiaoshouyeji_float = [_totalDict[allKey] floatValue];
    if (all_xiaoshouyeji_float <= 0) return @"0.00";
    
    CGFloat xiaoShouYeJi_float = [var floatValue];
    CGFloat bfb = xiaoShouYeJi_float / all_xiaoshouyeji_float * 100.f;
    
    return [NSString stringWithFormat:@"%.2f", bfb];
}

- (NSString *)bfb1
{
    if (_bfb1) return _bfb1;
    _bfb1 = [self bfbComputeTotalVarKey:@"xiaoshouyeji" var:_xiaoshouyeji];
    return _bfb1;
}

- (NSString *)bfb2
{
    if (_bfb2) return _bfb2;
    _bfb2 = [self bfbComputeTotalVarKey:@"xiaohaoyeji" var:_xiaohaoyeji];
    return _bfb2;
}

- (NSString *)bfb3
{
    if (_bfb3) return _bfb3;
    _bfb3 = [self bfbComputeTotalVarKey:@"jiedaikeci" var:_keci];
    return _bfb3;
}

- (NSString *)bfb4
{
    if (_bfb4) return _bfb4;
    _bfb4 = [self bfbComputeTotalVarKey:@"chengjiaorenshu" var:_chengjiao];
    return _bfb4;
}

- (NSString *)bfb5
{
    if (_bfb5) return _bfb5;
    _bfb5 = [self bfbComputeTotalVarKey:@"xiaohaoxiangmushu" var:_shicaoxiangmushu];
    return _bfb5;
}

/*
 Json.cn
 在线解析 什么是JSON JSON解析代码 JSON组件
 
 {"info":{"name":"北京测试样板店","id":790,"xiaoshouyeji":10000,"xiaohaoyeji":100,"jiedaikeci":50,"chengjiaorenshu":26,"xiaohaoxiangmushu":32},"list":{"acc_name":"北京总部测试门店1售后美容师","account":"18600005555","chengjiaorenshu":25,"id":801,"jiedaikeci":49,"pid":795,"store_code":"MD000022","xiaohaoxiangmushu":31,"xiaohaoyeji":99,"xiaoshouyeji":9999}}
 
 
 
 {
 "info":{
     "name":"北京测试样板店",
     "id":790,
     "xiaoshouyeji":10000,
     "xiaohaoyeji":100,
     "jiedaikeci":50,
     "chengjiaorenshu":26,
     "xiaohaoxiangmushu":32
 },
 "list":{
     "acc_name":"北京总部测试门店1售后美容师",
     "account":"18600005555",
     "chengjiaorenshu":25,
     "id":801,
     "jiedaikeci":49,
     "pid":795,
     "store_code":"MD000022",
     "xiaohaoxiangmushu":31,
     "xiaohaoyeji":99,
     "xiaoshouyeji":9999
 }
 }
 
 ©2014 JSON.cn All right reserved. 京ICP备15025187号-1 邮箱：service@json.cn
 */
@end
