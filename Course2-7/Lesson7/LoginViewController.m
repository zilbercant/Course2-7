//
//  LoginViewController.m
//  Lesson7
//
//  Created by Azat Almeev on 17.10.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "LoginViewController.h"
#import "NavigationController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *offsetConstraint;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewDidLayoutSubviews{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"Login"]&&[defaults objectForKey:@"Password"]){
        [defaults setObject:self.loginField.text forKey:@"Login"];
        [defaults setObject:self.passwordField.text forKey:@"Password"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        NavigationController *navigate = (NavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
        [self presentViewController:navigate animated:YES completion:nil];
        
    }

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [NSNotificationCenter.defaultCenter removeObserver:self];
    [super viewWillDisappear:animated];
}

#pragma mark - Keyboard
- (void)keyboardWillShowNotification:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [UIView animateWithDuration:.3 animations:^{
        CGFloat kbHeight = kbSize.height;
        self.offsetConstraint.constant = -kbHeight / 2;
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHideNotification:(NSNotification *)notification {
    [UIView animateWithDuration:.3 animations:^{
        self.offsetConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    if(textField.returnKeyType==UIReturnKeyNext) {
        UIView *next = [[textField superview] viewWithTag:textField.tag+1];
        [next becomeFirstResponder];
    } else if (textField.returnKeyType==UIReturnKeyDone) {
        [textField resignFirstResponder];
    }
    return YES;
} - (IBAction)logIn:(id)sender {
    if((self.passwordField.text.length >0)&&(self.passwordField.text.length > 0)){
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.loginField.text forKey:@"Login"];
    [defaults setObject:self.passwordField.text forKey:@"Password"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        NavigationController *navigate = (NavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
        [self presentViewController:navigate animated:YES completion:nil];
        
    }
}
@end
