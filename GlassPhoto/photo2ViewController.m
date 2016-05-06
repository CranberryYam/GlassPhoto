//
//  photo2ViewController.m
//  GlassPhoto
//
//  Created by yihl on 4/10/16.
//  Copyright © 2016 yihl. All rights reserved.
//

#import "photo2ViewController.h"

@interface photo2ViewController (){
    UIPanGestureRecognizer *lpr;
}

@end

@implementation photo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTransition];
}

-(void)setTransition{
    lpr = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleRightPan:)];
    [self.view addGestureRecognizer:lpr];
}

-(void)handleRightPan:(UIPanGestureRecognizer*)pan{
    if (pan.state == UIGestureRecognizerStateBegan){
        CGPoint vec=[pan velocityInView:self.view];
        if(!(vec.x>0)){
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
