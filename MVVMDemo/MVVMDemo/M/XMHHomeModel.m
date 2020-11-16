//
//  XMHHomeModel.m
//  MVVMDemo
//
//  Created by kfw on 2020/11/14.
//

#import "XMHHomeModel.h"

@implementation XMHHomeModel

- (RACCommand *)likeBlogCommand {
    if (_likeBlogCommand) return _likeBlogCommand;
    @weakify(self);
    _likeBlogCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            if (self.like) {
//                self.count--;
//            } else {
//            }
            self.count++;
            self.like = self.count;
            
            if (self.count > 3) {
                [subscriber sendNext:@NO];
                [subscriber sendCompleted];
            } else {
                [subscriber sendNext:@YES];
                [subscriber sendCompleted];
            }
            return nil;
        }];
    }];
    
    return _likeBlogCommand;
}

@end
