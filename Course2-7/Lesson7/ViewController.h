//
//  ViewController.h
//  Lesson7
//
//  Created by Azat Almeev on 11.10.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingTableViewController.h"

@interface ViewController : UIViewController<LoadingTableViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *myLabel;
@end

