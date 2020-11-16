//
//  XMHHomeViewModel.m
//  MVVMDemo
//
//  Created by kfw on 2020/11/14.
//

#import "XMHHomeViewModel.h"
#import "XMHHomeModel.h"

@implementation XMHHomeViewModel
- (void)getDataComplete:(void(^)(BOOL success, id modelArray))complete {
//    NSMutableDictionary *params = NSMutableDictionary.new;
//    params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
//    params[@"store_code"] = [ShareWorkInstance shareInstance].share_join_code.store_code;
//    params[@"page"] = @(self.page);
//    params[@"user_id"] = _userId;
//    params[@"page_size"] = @"2";
//    [XMHProgressHUD showGifImage];
//    [YQNetworking postWithUrl:[XMHHostUrlManager url:@"v5.user_new/user_grade_trajectory"] refreshRequest:YES cache:NO params:params progressBlock:nil resultBlock:^(BaseModel *obj, BOOL isSuccess, NSError *error) {
//        if (isSuccess) {
//            [XMHProgressHUD dismiss];
//            NSArray *modelArray = [NSArray yy_modelArrayWithClass:[XMHBookingOrderListModel class] json:obj.data[@"list"]];
//            if (complete) complete(isSuccess, modelArray);
//        } else {
//            if (complete) complete(isSuccess, nil);
//        }
//    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        NSMutableArray *modelArray = NSMutableArray.new;
        int lastNum = [self.dataArray.lastObject intValue];
        for (int i = lastNum; i < lastNum + 5; i++) {
            
            XMHHomeModel *model = XMHHomeModel.new;
            model.name = @(i).stringValue;
            model.count = 0;
            [modelArray addObject:model];
        }
        if (complete) complete(YES, modelArray);
    });
}

- (void)deleteCellModel:(NSIndexPath *)indexPath {
    if (!(indexPath.row < self.dataArray.count)) return;
    [self.dataArray removeObjectAtIndex:indexPath.row];
}

@end
