//
//  XMHViewModelBase.m
//  xmh
//
//  Created by kfw on 2020/11/13.
//  Copyright © 2020 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHViewModelBase.h"

@implementation XMHViewModelBase

@synthesize page = _page;
@synthesize dataArray = _dataArray;
@synthesize getDataCommand = _getDataCommand;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.page = 1;
    }
    return self;
}

#pragma mark - Public

/// 获取下拉数据
- (void)getData {
    self.page = 1;
    [self.getDataCommand execute:@"getDataCommand"];
}

/// 获取更多数据
- (void)getMoreData {
    self.page++;
    [self.getDataCommand execute:@"getDataCommand"];
}

#pragma mark - lazy

- (NSMutableArray *)dataArray {
    if (_dataArray) return _dataArray;
    _dataArray = NSMutableArray.new;
    return _dataArray;
}

-(RACCommand *)getDataCommand {
    if (_getDataCommand) return _getDataCommand;
    @weakify(self);
    _getDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self getDataComplete:^(BOOL success, NSArray *modelArray) {
                if (success) {
                    if (self.page == 1) {
                        self.dataArray = [modelArray mutableCopy];
                    } else {
                        [self.dataArray addObjectsFromArray:modelArray];
                    }
                    [subscriber sendNext:modelArray];
                    [subscriber sendCompleted];
                } else {
                    // 失败 page 回滚
                    if (self.page > 1) --self.page;
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                }
            }];
            return nil;
        }];
    }];
    return _getDataCommand;
}
@end
