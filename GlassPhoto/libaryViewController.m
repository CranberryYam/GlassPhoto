//
//  libaryViewController.m
//  GlassPhoto
//
//  Created by yihl on 4/6/16.
//  Copyright © 2016 yihl. All rights reserved.
//

#import "libaryViewController.h"

@interface libaryViewController (){
       UIPanGestureRecognizer *lpr;
}

@end

@implementation libaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTransition];
}

-(void)setTransition{    
    lpr=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:lpr];
}

-(void)handlePan:(UIPanGestureRecognizer*)pan{
    if (pan.state == UIGestureRecognizerStateBegan){
        CGPoint vel = [pan velocityInView:self.view];
        if (vel.x > 0)
        {
         [self.transition dismissInteractiveTransitionViewController:self GestureRecognizer:pan Completion:nil];
        }
        
    }else{
        [self.transition updateInteractiveTransitionWithGestureRecognizer:pan];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
