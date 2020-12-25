//
//  ViewController.m
//  XMHBlockTrampoline
//
//  Created by kfw on 2020/11/27.
//

#import "ViewController.h"
#import "XMHBlockTrampoline.h"
#import "NSArray+XMHMap.h"
#import "NSDictionary+XMHMap.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *arr = @[@"1", @"2", @"3"];
    
    NSArray *result = arr.xmh_map(^id (NSString *obj) {
        return obj;
    });
    NSLog(@"result=%@", result);
    
    NSArray *result2 = arr.xmh_map(^id (NSString *obj, NSNumber *idx) {
        return [NSString stringWithFormat:@"idx=%@ obj=%@", idx, obj];
    });
    NSLog(@"result2=%@", result2);
}

@end
