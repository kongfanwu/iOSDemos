//
//  FWTableViewVC.m
//  NSThread+RunLoop
//
//  Created by kfw on 2019/7/30.
//  Copyright © 2019 kfw. All rights reserved.
//

#import "FWTableViewVC.h"

@interface FWTableViewVC ()
/** <##> */
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation FWTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _tableView.rowHeight = 100;
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if(cell == nil) {
//    }
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", indexPath.row];
    cell.imageView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    cell.imageView.image = [UIImage imageNamed:@"2.png"];
    
    UIImage *image = [UIImage imageNamed:@"1.png"];
    
    /*
     RunLoop mode正常 NSDefaultRunLoopMode 滑动时切换为 UITrackingRunLoopMode
     */
    [cell.imageView performSelector:@selector(setImage:)
                         withObject:image
                         afterDelay:0
                            inModes:@[NSDefaultRunLoopMode]];
    
    [[NSRunLoop currentRunLoop] performInModes:@[NSDefaultRunLoopMode] block:^{
        NSLog(@"---:%ld", indexPath.row);
    }];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
