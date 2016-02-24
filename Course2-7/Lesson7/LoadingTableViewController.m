//
//  LoadingTableViewController.m
//  Lesson7
//
//  Created by Azat Almeev on 17.10.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "LoadingTableViewController.h"

@interface LoadingTableViewController ()

@end
NSString *loadingCellIdentifier = @"LoadingTableViewCell";
@implementation LoadingTableViewController

//Returning back using arrow on upper left corner does nothing

- (NSMutableArray *)items {
    if (!_items)
        _items = [NSMutableArray new];
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"LoadingTableViewCell" bundle:nil] forCellReuseIdentifier:loadingCellIdentifier];
}

- (void)didLoadNewData:(NSArray *)items {
    self.isLoading = NO;
    NSInteger offset = self.items.count * 2;
    [self.items addObjectsFromArray:items];
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (NSInteger i = 0; i < items.count * 2; i++) {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:i + offset inSection:0];
        [indexPaths addObject:ip];
    }
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)didFailToLoadDataWithError:(NSError *)error {
    self.isLoading = NO;
    self.didFail = YES;
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
    NSLog(@"%@", error);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 1 ? !self.didFail : 2 * self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *basicIdentifier = @"BaseCellIdentifier";
    static NSString *subtitleIdentifier = @"subtitleCellIdentifier";
    
    if (indexPath.section == 1)
        return [tableView dequeueReusableCellWithIdentifier:loadingCellIdentifier];
    
    NSInteger index = indexPath.row / 2;
    if (indexPath.row % 2 == 0) {
        UITableViewCell *basicCell = [tableView dequeueReusableCellWithIdentifier:basicIdentifier];
        basicCell.textLabel.text = [NSString stringWithFormat:@"%@", self.items[index]];
        return basicCell;
    }
    else {
        UITableViewCell *subtitleCell = [tableView dequeueReusableCellWithIdentifier:subtitleIdentifier];
        subtitleCell.textLabel.text = [NSString stringWithFormat:@"%@", self.items[index]];
        subtitleCell.detailTextLabel.text = [NSString stringWithFormat:@"%@ subtitle", self.items[index]];
        return subtitleCell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && !self.isLoading) {
        [self loadDataUsingLastID:self.items.lastObject];
    }
}

- (NSArray *)arrayFromStart:(NSNumber *)start {
    NSMutableArray *res = [NSMutableArray new];
    NSInteger offset = [start integerValue];
    if (offset > 0)
        offset++;
    for (NSInteger i = 0; i < 20; i++)
        [res addObject:@(i + offset)];
    return res.copy;
}

- (void)loadDataUsingLastID:(NSNumber *)lastId {
    double delay = .5 + arc4random_uniform(100) / 100.;
    if (arc4random_uniform(100) > 10)
        [self performSelector:@selector(didLoadNewData:) withObject:[self arrayFromStart:lastId] afterDelay:delay];
    else
        [self performSelector:@selector(didFailToLoadDataWithError:) withObject:[NSError errorWithDomain:@"Lesson2" code:500 userInfo:@{ NSLocalizedDescriptionKey : @"Internal error during loading data" }] afterDelay:delay];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
{
      [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    [self.delegate getNumber:indexPath.row/2];

}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;

}
@end
