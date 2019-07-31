//
//  Person.m
//  FWMultipleProxyDemo
//
//  Created by kfw on 2019/6/24.
//  Copyright © 2019 kfw. All rights reserved.
//

#import "Person.h"

@implementation Person
#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s", __FUNCTION__);
}
@end
