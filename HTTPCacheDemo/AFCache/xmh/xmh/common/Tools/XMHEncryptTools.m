//
//  XMHEncryptTools.m
//  xmh
//
//  Created by ald_ios on 2019/5/24.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHEncryptTools.h"
#import "NSString+DE.h"
@implementation XMHEncryptTools
+ (NSString *)encryptbyParam:(NSMutableDictionary *)param
{
    NSArray * keyArray = [param allKeys];
    /** 将key进行排序 */
    NSMutableArray *sortArray = [[NSMutableArray alloc] initWithArray:[keyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }]];
    /** 将value 按照key的顺序存到数组 */
    NSMutableArray *valueArray = [NSMutableArray array];
    NSMutableArray * keySortArr = [[NSMutableArray alloc] initWithArray:sortArray];
    for (NSString *sortString in sortArray) {
        /** 排除value类型有NSNumber的情况 */
        NSString * value = [NSString stringWithFormat:@"%@",[param objectForKey:sortString]];
        if (([value isEqualToString:@""])) {
            [keySortArr removeObject:sortString];
        }else{
            [valueArray addObject:[param objectForKey:sortString]];
        }
    }
    NSMutableArray *signArray = [NSMutableArray array];
    for (int i = 0; i < keySortArr.count; i++) {
        NSString *keyValueStr = [NSString stringWithFormat:@"%@=%@",keySortArr[i],valueArray[i]];
        [signArray addObject:keyValueStr];
    }
    NSString * valuestr = [signArray componentsJoinedByString:@"&"];
    /** 将私钥放在字符串头部 */
    NSString * sign = [NSString stringWithFormat:@"%@%@",kAPP_PRIVATEKEY,valuestr];
    MzzLog(@"加密前---sign---------------%@",sign);
    /** 两次md5 加密 */
    sign = [[sign encryptWithMd5] encryptWithMd5];
    MzzLog(@"加密后---sign---------------%@",sign);
    return sign;
}
@end
