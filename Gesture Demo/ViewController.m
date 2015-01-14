
#import "ViewController.h"

#define IMAGE_NAME @"Tux"
#define BACK @"cardBack"


@interface ViewController () <UIGestureRecognizerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    // Recuperation de l'image
    UIImage * image = [UIImage imageNamed:IMAGE_NAME];

    
    // Instanciation de l'UIImageView
    UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    imageView.frame = CGRectMake(30, 30, 94, 133);
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.layer.cornerRadius = 8.;
    

    // Ajout
    [self.view addSubview:imageView];
    
    // gestion du tap
    UITapGestureRecognizer * tap = [UITapGestureRecognizer new];
    [tap addTarget:self action:@selector(handleTap:)];
    [imageView addGestureRecognizer:tap];
//    tap.numberOfTapsRequired = 2;
    
    // Gestion du pan
    UIPanGestureRecognizer * pan = [UIPanGestureRecognizer new];
    [pan addTarget:self action:@selector(handlePan:)];
    [imageView addGestureRecognizer:pan];
    
    // Gestion du rotate
    UIRotationGestureRecognizer * rot = [UIRotationGestureRecognizer new];
    [rot addTarget:self action:@selector(handleRotation:)];
    [imageView addGestureRecognizer:rot];
    rot.delegate = self;
    
    // Gestion du pinch
    UIPinchGestureRecognizer * pinch = [UIPinchGestureRecognizer new];
    [pinch addTarget:self action:@selector(handlePinch:)];
    [imageView addGestureRecognizer:pinch];
    pinch.delegate = self;
    
    
}

- (void) handlePinch:(UIPinchGestureRecognizer *)sender
{
    //sender.view.transform = CGAffineTransformMakeScale(sender.scale, sender.scale);
    sender.view.transform = CGAffineTransformScale(sender.view.transform, sender.scale, sender.scale);
    sender.scale = 1;
}

- (void) handleRotation:(UIRotationGestureRecognizer *)sender
{
//    sender.view.transform = CGAffineTransformMakeRotation(sender.rotation);
    sender.view.transform = CGAffineTransformRotate(sender.view.transform, sender.rotation);
    sender.rotation = 0;
}

- (void) handlePan:(UIPanGestureRecognizer *)sender
{
    CGPoint offset = [sender translationInView:self.view];
    
    
    CGPoint newCenter;
  
    newCenter.x = sender.view.center.x + offset.x;
    newCenter.y = sender.view.center.y + offset.y;
    
    sender.view.center = newCenter;
    
    [sender setTranslation:CGPointZero inView:self.view];
}


- (void) handleTap:(UITapGestureRecognizer *)sender
{
    UIImageView * imageView = (UIImageView *) sender.view;
    
    
   [UIView transitionWithView:imageView
                   duration:.33
                    options:UIViewAnimationOptionTransitionFlipFromLeft
                 animations:^{
                     
                  
                     
                     if([imageView.image isEqual:[UIImage imageNamed:IMAGE_NAME]])
                     {
                         imageView.image = [UIImage imageNamed:BACK];
                     }
                     else
                     {
                         imageView.image = [UIImage imageNamed:IMAGE_NAME];
                     }
                 }
                 completion:nil];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end













