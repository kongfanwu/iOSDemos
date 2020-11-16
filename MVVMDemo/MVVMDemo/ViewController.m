//
//  ViewController.m
//  MVVMDemo
//
//  Created by kfw on 2020/11/14.
//

#import "ViewController.h"
#import "XMHHomeViewModel.h"
#import "XMHHomeTableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
///
@property (nonatomic, strong) UITableView *tableView;
///
@property (nonatomic, strong) XMHHomeViewModel *vm;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.vm = XMHHomeViewModel.new;
    [self.vm.getDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray *modelArray) {
        [self.tableView reloadData];
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [self.vm getData];
}


#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _vm.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    XMHHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[XMHHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell configModel: _vm.dataArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_vm deleteCellModel:indexPath];
    [self.tableView reloadData];
}

@end
