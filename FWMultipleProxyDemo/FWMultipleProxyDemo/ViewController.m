//
//  ViewController.m
//  FWMultipleProxyDemo
//
//  Created by kfw on 2019/6/24.
//  Copyright © 2019 kfw. All rights reserved.
//


/*
 http://www.cocoachina.com/articles/14595
 https://www.jianshu.com/p/c95c9a7574e8
 */
#import "ViewController.h"
#import "KIZMultipleProxyBehavior.h"
#import "Person.h"
#import "UITableView+FWBlock.h"

@interface ViewController ()
/** <##> */
@property (nonatomic, strong) UITableView *tableView;
/** <##> */
@property (nonatomic, strong) KIZMultipleProxyBehavior *behaviors;
/** <##> */
@property (nonatomic, strong) Person *person;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = Person.new;
    
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    NSArray *delegates = @[self, self.person, self.tableView];
    KIZMultipleProxyBehavior *behaviors = [[KIZMultipleProxyBehavior alloc] init];
    behaviors.delegateTargets = delegates;
    self.behaviors = behaviors;
    
    self.tableView.dataSource = (id<UITableViewDataSource>)self.behaviors;
    self.tableView.delegate   = (id<UITableViewDelegate>)self.behaviors;
    [self.view addSubview:_tableView];
    [_tableView setDidSelectRowAtIndexPathBlock:^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"setDidSelectRowAtIndexPathBlock");
    }];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", indexPath.row];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s", __FUNCTION__);
}

@end
