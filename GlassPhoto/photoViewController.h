//
//  photoViewController.h
//  GlassPhoto
//
//  Created by yihl on 4/5/16.
//  Copyright © 2016 yihl. All rights reserved.
//
#import "CameraSessionView.h"
#import <UIKit/UIKit.h>
#import "ElasticTransition.h"
@interface photoViewController : UIViewController<CACameraSessionDelegate>
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) ElasticTransition *transition;
@property (nonatomic, strong) CameraSessionView *cameraView;
@end
