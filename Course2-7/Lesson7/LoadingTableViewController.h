//
//  LoadingTableViewController.h
//  Lesson7
//
//  Created by Azat Almeev on 17.10.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoadingTableViewControllerDelegate;

@interface LoadingTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, weak)id<LoadingTableViewControllerDelegate> delegate;
@property (nonatomic) NSMutableArray *items;
@property BOOL isLoading;
@property BOOL didFail;
- (IBAction)saveChoose:(id)sender;
@property (nonatomic)NSInteger *number;
@end

@protocol LoadingTableViewControllerDelegate <NSObject>
-(void)getNumber:(NSInteger)number;
@end
