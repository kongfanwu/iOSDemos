//
//  ViewController.m
//  FWPredicate
//
//  Created by kfw on 2019/9/16.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()
/** <##> */
@property (nonatomic, strong) Person *p;
/** <##> */
@property (nonatomic, strong) UITableView *tableView;
/** <##> */
@property (nonatomic, strong) NSMutableArray *dataArray;
/**  */
@property (nonatomic) NSInteger index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _index = 0;
    self.dataArray = NSMutableArray.new;
    [_dataArray addObject:@(_index).stringValue];
    [_tableView reloadData];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self test];
//}
//
//- (void)test {
////    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name='kong'"];
////    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"hidden=1"];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age>5 && age<20"];
//    BOOL b = [predicate evaluateWithObject:self.p];
//    NSLog(@"%d", b);
//}
#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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
    _index++;
    [_dataArray addObject:@(_index).stringValue];
//    [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [_tableView insertSections:[NSIndexSet indexSetWithIndex:_index] withRowAnimation:UITableViewRowAnimationAutomatic];
}
@end
