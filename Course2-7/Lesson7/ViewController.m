//
//  ViewController.m
//  Lesson7
//
//  Created by Azat Almeev on 11.10.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
NSInteger *num;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   }

- (void)getNumber:(NSInteger)number {
  self.myLabel.text = [self randomStringWithLength:number];
    num = &number;

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        LoadingTableViewController *dvc = segue.destinationViewController;
        dvc.delegate = self;
//    self.myLabel.text = [self randomStringWithLength:num];
    
}

- (IBAction)logOut:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"Login"];
    [defaults removeObjectForKey:@"Password"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    LoginViewController *login = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"loginView"];
    [self.navigationController pushViewController:login animated:YES];

}

-(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

- (IBAction)returnToView:(UIStoryboardSegue *)segue{
    
}




@end

