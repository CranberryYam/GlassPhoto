//
//  ViewController.m
//  GlassPhoto
//
//  Created by yihl on 4/3/16.
//  Copyright © 2016 yihl. All rights reserved.
//
#import "libaryViewController.h"
#import "photoViewController.h"
#import "photo2ViewController.h"
#import "photo3ViewController.h"
#import "ElasticTransition.h"
#import <POP/POP.h>
#import "FBShimmeringView.h"
#import "UIImage+ImageEffects.h"
#import "UIImage+FEBoxBlur.h"
#import "MDScratchImageView.h"
#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    ElasticTransition *transition;
    UIScreenEdgePanGestureRecognizer *lgr;
    UIPanGestureRecognizer *lpr;
    UIScreenEdgePanGestureRecognizer *rgr;
    UIPanGestureRecognizer *rpr;
}
@property (strong, nonatomic) UIImageView *SharpImage;
@property (strong, nonatomic) MDScratchImageView *BluredImage;
@property (strong, nonatomic) UIImage *GlassPhoto;
- (IBAction)LibaryAction:(id)sender;
- (IBAction)TakePhotoAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *TakePhotoButton;
@property (strong, nonatomic) IBOutlet UILabel *TittleLabel;
@property (strong, nonatomic) IBOutlet UIButton *LibaryButton;
@property (strong, nonatomic) IBOutlet UIButton *ShareButton;
- (IBAction)ShareButton:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBluredImage];
    [self addShimmerAnimation];
    [self setTransition];
}

-(void)setTransition{
    transition = [[ElasticTransition alloc] init];

    transition.sticky           = YES;
    transition.showShadow       = YES;
    transition.panThreshold     = 0.1;
    transition.transformType    =TRANSLATEMID;
    
    //lpr = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    //[self.view addGestureRecognizer:lpr];
    
}

-(void)handlePan:(UIPanGestureRecognizer*)pan{
    
    if (pan.state == UIGestureRecognizerStateBegan){
        CGPoint vel = [pan velocityInView:self.view];
        if (vel.x > 0)
        {
            transition.edge = LEFT;
            photo2ViewController *picker=[[photo2ViewController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.transition=transition;
            picker.transitioningDelegate=transition;
            picker.modalTransitionStyle=UIModalPresentationCustom;
            [transition startInteractiveTransitionFromViewController:self ToViewController:picker GestureRecognizer:pan];
        }
        else
        {
            transition.edge = RIGHT;
            libaryViewController *picker = [[libaryViewController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.transition=transition;
            picker.transitioningDelegate=transition;
            picker.modalTransitionStyle=UIModalPresentationCustom;
            [transition startInteractiveTransitionFromViewController:self ToViewController:picker GestureRecognizer:pan];
        }
        
    }else{
        [transition updateInteractiveTransitionWithGestureRecognizer:pan];
    }
}


-(void)addBluredImage{
    UIView *photoView=[self.view viewWithTag:10];
    UIImage *sharpImage = [UIImage imageNamed:@"paint01-02.png"];
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.frame=photoView.bounds;
    imageView.image = sharpImage;
    _SharpImage=imageView;
    [photoView addSubview:imageView];
    
    UIImage *bluredImage = [UIImage imageNamed:@"paint01-02blur.png"];
    _GlassPhoto=bluredImage;
    MDScratchImageView *scratchImageView = [[MDScratchImageView alloc] initWithFrame:imageView.frame];
    [scratchImageView setImage:bluredImage radius:80];
    scratchImageView.image = bluredImage;
    _BluredImage=scratchImageView;
    [photoView addSubview:scratchImageView];
}

-(void)addImage1:(UIImage *)image1 andImage2:(UIImage *)image2{
    UIView *photoView=[self.view viewWithTag:10];
    for(int i = 0;i<[photoView.subviews count];i++){
        [ [ photoView.subviews objectAtIndex:i] removeFromSuperview];
    }
    UIImage *sharpImage = image1;
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.frame=photoView.bounds;
    imageView.image = sharpImage;
    _SharpImage=imageView;
    [photoView addSubview:imageView];
    
    UIImage *bluredImage = image2;
    _GlassPhoto=image2;
    //UIImage *bluredImage = [UIImage imageNamed:@"view1.jpg"];
    MDScratchImageView *scratchImageView = [[MDScratchImageView alloc] initWithFrame:imageView.frame];
    [scratchImageView setImage:bluredImage radius:120];
    scratchImageView.image = bluredImage;
    _BluredImage=scratchImageView;
    [photoView addSubview:scratchImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)LibaryAction:(id)sender {
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    positionAnimation.velocity = @2000;
    positionAnimation.springBounciness = 30;
    [_LibaryButton.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];

    transition.edge = RIGHT;
    libaryViewController *picker = [[libaryViewController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.transition=transition;
    picker.transitioningDelegate=transition;
    picker.modalTransitionStyle=UIModalPresentationCustom;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //UIImage *image1=[info valueForKey:UIImagePickerControllerOriginalImage];
    UIImage *image1 = info[UIImagePickerControllerEditedImage];
    UIImage *image2 = [image1 blurImage];
    [self addImage1:image1 andImage2:image2];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)TakePhotoAction:(id)sender {
    transition.edge = LEFT;
    photo2ViewController *picker=[[photo2ViewController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.transition=transition;
    picker.transitioningDelegate=transition;
    picker.modalTransitionStyle=UIModalPresentationCustom;

    [self presentViewController:picker animated:YES completion:NULL];
        
    /*photo3ViewController *pc=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"photo3"];
    [self presentViewController:pc animated:YES completion:NULL];*/

}
- (IBAction)ShareButton:(id)sender {
    //NSString *text = @"want to see my GlassPhoto";
    //NSURL *url = [NSURL URLWithString:@"http://roadfiresoftware.com/2014/02/how-to-add-facebook-and-twitter-sharing-to-an-ios-app/"];
    UIImage *image = self.GlassPhoto;
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[image]
     applicationActivities:nil];
    controller.excludedActivityTypes = @[
                                         UIActivityTypeMessage,
                                         UIActivityTypeMail,
                                         UIActivityTypePrint,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,
                                         UIActivityTypeAddToReadingList,
                                         UIActivityTypePostToFlickr,
                                         UIActivityTypePostToVimeo,
                                         UIActivityTypeAirDrop,
                                         UIActivityTypeMail,
                                         UIActivityTypeOpenInIBooks,
                                         ];
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)addShimmerAnimation{
    /*FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] initWithFrame:_TakePhotoButton.frame];
     [self.view addSubview:shimmeringView];
     shimmeringView.contentView = _TakePhotoButton;
     shimmeringView.shimmering = YES;
     shimmeringView.shimmeringSpeed=50;
     shimmeringView.shimmeringPauseDuration=0.1;
     
     FBShimmeringView *shimmeringView2 = [[FBShimmeringView alloc] initWithFrame:_LibaryButton.frame];
     [self.view addSubview:shimmeringView2];
     shimmeringView2.contentView = _LibaryButton;
     shimmeringView2.shimmering = YES;
     shimmeringView2.shimmeringSpeed=50;
     shimmeringView2.shimmeringPauseDuration=0.1;*/
    
    FBShimmeringView *shimmeringView3 = [[FBShimmeringView alloc] initWithFrame:_TittleLabel.frame];
    [self.view addSubview:shimmeringView3];
    shimmeringView3.contentView = _TittleLabel;
    shimmeringView3.shimmering = YES;
    //shimmeringView3.shimmeringSpeed=50;
    //shimmeringView3.shimmeringPauseDuration=0.1;
    
    UIView *photoView=[self.view viewWithTag:10];
    FBShimmeringView *shimmeringView4 = [[FBShimmeringView alloc] initWithFrame:photoView.frame];
    [self.view addSubview:shimmeringView4];
    shimmeringView4.contentView = photoView;
    shimmeringView4.shimmering = YES;
    // shimmeringView4.shimmeringSpeed=50;
    //shimmeringView4.shimmeringPauseDuration=0.1;
    //shimmeringView4.shimmeringOpacity=0.3;
}

@end
