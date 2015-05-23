//
//  ViewController.m
//  OSKStatusBarViewControllerDemo
//
//  Created by Tomoya_Hirano on 5/23/15.
//  Copyright (c) 2015 Tomoya_Hirano. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [self randomColor];
    self.statusBarColor = [self randomColor];
    [NSTimer scheduledTimerWithTimeInterval:60 target:[NSBlockOperation blockOperationWithBlock:^{
        [self refreshStatusBar];
    }] selector:@selector(main) userInfo:nil repeats:true];
}

- (UIColor*)randomColor{
    CGFloat r = (arc4random_uniform(255) + 1)/255.0;
    CGFloat g = (arc4random_uniform(255) + 1)/255.0;
    CGFloat b = (arc4random_uniform(255) + 1)/255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
