//
//  ViewController.m
//  panDemo
//
//  Created by kfw on 2019/7/26.
//  Copyright © 2019 kfw. All rights reserved.
//

#import "ViewController.h"
#import "ContentVC.h"
#import "CusTableVIew.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate, UIGestureRecognizerDelegate>
/** <##> */
@property (nonatomic, strong) UITableView *tableView, *cusTableVIew;
/** <##> */
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200)];
    headerView.backgroundColor = UIColor.blueColor;
    _tableView.tableHeaderView = headerView;
    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pngClick:)];
//    pan.delegate = self;
//    [self.view addGestureRecognizer:pan];
}

- (void)pngClick:(UIPanGestureRecognizer *)pan {
    NSLog(@"pngClick");
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
//    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", indexPath.row];
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), CGRectGetHeight(tableView.frame))];
    scrollView.backgroundColor = UIColor.redColor;
    [cell.contentView addSubview:scrollView];
//
    NSInteger count = 1;
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(tableView.frame) * count, CGRectGetHeight(tableView.frame));
    
    self.cusTableVIew = [[CusTableVIew alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), CGRectGetHeight(tableView.frame)) style:0];
    [scrollView addSubview:_cusTableVIew];
    
//    for (int i = 0; i < count; i++) {
//        ContentVC *vc = ContentVC.new;
//        [self addChildViewController:vc];
////
//        vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
//        vc.view.frame = CGRectMake(CGRectGetWidth(tableView.frame) * i, 0, CGRectGetWidth(tableView.frame), CGRectGetHeight(tableView.frame));
//        NSLog(@"%@", vc.view);
//
////        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//        UIView *v = vc.view;
//        [scrollView addSubview:v];
//    }
    
    NSLog(@"----");
//
    return cell;
}

#pragma mark - UITableView Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CGRectGetHeight(tableView.frame);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
