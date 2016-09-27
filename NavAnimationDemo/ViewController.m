//
//  ViewController.m
//  NavAnimationDemo
//
//  Created by John Ryan on 9/27/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *translucent = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 200, 44)];
    [translucent setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [translucent setTitle:@"Push Translucent" forState:UIControlStateNormal];
    [translucent addTarget:self action:@selector(pushTranslucent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:translucent];
    
    UIButton *opaque = [[UIButton alloc] initWithFrame:CGRectMake(0, 180, 200, 44)];
    [opaque setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [opaque setTitle:@"Push Opaque" forState:UIControlStateNormal];
    [opaque addTarget:self action:@selector(pushOpaque) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:opaque];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    
    if (self.navigationController.topViewController != self) {
        return;
    }
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    
    UIColor *navColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    UIRectEdge originalEdges = self.edgesForExtendedLayout;
    
    if (self.translucent) {
        self.navigationController.navigationBar.translucent = self.translucent;
    }
    else{
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    if (self.transitionCoordinator) {
        
        
        [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
            self.navigationController.navigationBar.translucent = self.translucent;
            self.navigationController.navigationBar.barTintColor = navColor;
            
        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
            self.edgesForExtendedLayout = originalEdges;
            self.navigationController.navigationBar.translucent = self.translucent;
            self.navigationController.navigationBar.barTintColor = navColor;
            
        }];
    }
    else{
        self.navigationController.navigationBar.translucent = self.translucent;
        self.navigationController.navigationBar.barTintColor = navColor;
        
    }
    
    
    
}


- (void)pushTranslucent {
    
    ViewController *translucent = [[ViewController alloc] init];
    translucent.translucent = true;
    [self.navigationController pushViewController:translucent animated:true];
    
}

- (void)pushOpaque {
    ViewController *opaque = [[ViewController alloc] init];
    opaque.translucent = false;
    [self.navigationController pushViewController:opaque animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
