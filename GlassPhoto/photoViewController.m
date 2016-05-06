//
//  photoViewController.m
//  GlassPhoto
//
//  Created by yihl on 4/5/16.
//  Copyright © 2016 yihl. All rights reserved.
//

#import "photoViewController.h"

@interface photoViewController (){
    UIScreenEdgePanGestureRecognizer *rgr;
}

@end

@implementation photoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCamerView];
    [self setTransition];
}

-(void)addCamerView{
    _cameraView = [[CameraSessionView alloc] initWithFrame:self.view.frame];
    _cameraView.delegate = self;
    [self.view addSubview:_cameraView];
}

-(void)didCaptureImage:(UIImage *)image {
    _image=image;
}

-(void)setTransition{
    rgr = [[UIScreenEdgePanGestureRecognizer alloc] init];
    [rgr addTarget:self action:@selector(handleRightPan:)];
    rgr.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:rgr];
}

-(void)handleRightPan:(UIPanGestureRecognizer*)pan{
    if (pan.state == UIGestureRecognizerStateBegan){
        [self.transition dismissInteractiveTransitionViewController:self GestureRecognizer:pan Completion:nil];
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
