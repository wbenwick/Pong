//
//  FLXViewController.m
//  Pong
//
//  Created by Administrator on 3/20/14.
//  Copyright (c) 2014 FileLogix. All rights reserved.
//

#import "FLXViewController.h"
#import "FLXBallView.h"
#import "FLXBallImageView.h"
#import "FLXPaddleView.h"

@interface FLXViewController () <UICollisionBehaviorDelegate>
{
    __weak IBOutlet FLXPaddleView *paddleView;
    __weak IBOutlet FLXBallImageView *ballImageView1;
    __weak IBOutlet FLXBallImageView *ballImageView2;
   
    UIDynamicAnimator       *dynamicAnimator;
    UIPushBehavior          *pushBehavior;
    UICollisionBehavior     *collisionBehavior;
    UIGravityBehavior       *gravityBehavior;
    UIDynamicItemBehavior   *ballDynamicBehavior1;
    UIDynamicItemBehavior   *ballDynamicBehavior2;
    UIDynamicItemBehavior   *paddleDynamicBehavior;
    NSString                *ballImageString1;
    NSString                *ballImageString2;
    
}

@end

@implementation FLXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    pushBehavior  = [[UIPushBehavior alloc] initWithItems:@[ballImageView1, ballImageView2] mode: UIPushBehaviorModeInstantaneous];
    collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[ballImageView1, ballImageView2, paddleView]];
    ballDynamicBehavior1 = [[UIDynamicItemBehavior alloc] initWithItems:@[ballImageView1, ballImageView2]];
//    ballDynamicBehavior2 = [[UIDynamicItemBehavior alloc] initWithItems:@[ballImageView2]];
    paddleDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[paddleView]];

    ballImageString1 = [NSString stringWithFormat:@"DonBora"];
    ballImageString2 = [NSString stringWithFormat:@"Brandon"];
    
    pushBehavior.pushDirection = CGVectorMake(.5,.5);
    pushBehavior.active = YES;
    pushBehavior.magnitude = 1.0;
    pushBehavior.angle = 45;
    [dynamicAnimator addBehavior:pushBehavior];
    
//    gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[ballView]];
//    gravityBehavior.magnitude = 0.0;
//    gravityBehavior.gravityDirection = CGVectorMake(0, 0);
//    [dynamicAnimator addBehavior:gravityBehavior];

    
    ballDynamicBehavior1.allowsRotation = NO;
    ballDynamicBehavior1.elasticity = 1.0f;
    ballDynamicBehavior1.friction = 0.0f;
    ballDynamicBehavior1.resistance = 0.0f;
    [dynamicAnimator addBehavior:ballDynamicBehavior1];
//
//    ballDynamicBehavior2.allowsRotation = YES;
//    ballDynamicBehavior2.elasticity = 1.0;
//    ballDynamicBehavior2.friction = 0.0;
//    ballDynamicBehavior2.resistance = 0.0;
//    [dynamicAnimator addBehavior:ballDynamicBehavior2];
    
    paddleDynamicBehavior.allowsRotation = NO;
    paddleDynamicBehavior.density = 10000.0f;
    paddleDynamicBehavior.elasticity = 1.0f;
    paddleDynamicBehavior.friction = 0;
    paddleDynamicBehavior.resistance = 0;
    [dynamicAnimator addBehavior:paddleDynamicBehavior];

    collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;

    collisionBehavior.collisionDelegate = self;
    [dynamicAnimator addBehavior:collisionBehavior];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    
//    [UIView animateWithDuration:1.0 animations:^{
//        ballImageView1.tintColor = [UIColor greenColor];
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:1.0 animations:^{
//            ballImageView1.tintColor = [UIColor whiteColor];
//        }];
//        NSLog(@"animation complete");
//    }];
//    NSLog(@"collision detected");

//      ballDynamicBehavior1.elasticity = 0.5f;
//    pushBehavior.magnitude = 0.5;
//    pushBehavior.angle=0;
    
//    NSLog(@"Ball 1: %@", NSStringFromCGPoint([ballDynamicBehavior1 linearVelocityForItem:ballImageView1]));
//    NSLog(@"Ball 2: %@", NSStringFromCGPoint([ballDynamicBehavior1 linearVelocityForItem:ballImageView2]));

//    NSLog(@"Ball 1: %@", ballImageView1.accessibilityIdentifier);
//    NSLog(@"Ball 2: %@", ballImageView2.accessibilityIdentifier);



    

    
//    pushBehavior.pushDirection = CGVectorMake(0,0);

}

-(void) collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p
{

    if ([item1 isEqual:paddleView] || [item2 isEqual:paddleView])  {
        NSLog(@"Collided with Paddle");
        if ([item1 isEqual:ballImageView1] || [item2 isEqual:ballImageView1]) {
            NSLog(@"Ball 1 collision");
            
            if ([ballImageString1 isEqualToString:@"Max"]) {
                ballImageView1.image = [UIImage imageNamed:@"DonBora"];
                ballImageString1 = @"DonBora";
            }
            else {
                ballImageView1.image = [UIImage imageNamed:@"Max"];
                ballImageString1 = @"Max";
            }
            
        }
        
        if ([item1 isEqual:ballImageView2] || [item2 isEqual:ballImageView1] ) {
            NSLog(@"Ball 2 collision");
            
            if ([ballImageString2 isEqualToString:@"Ryan"]) {
                ballImageView2.image = [UIImage imageNamed:@"Brandon"];
                ballImageString2 = @"Brandon";
            }
            else {
                ballImageView2.image = [UIImage imageNamed:@"Ryan"];
                ballImageString2 = @"Ryan";
            }
            
        }
    
    
    }
}

-(IBAction)dragPaddle:(UIPanGestureRecognizer *)panGestureRecognizer
{
    paddleView.center = CGPointMake([panGestureRecognizer locationInView:self.view].x,paddleView.center.y);
    [dynamicAnimator updateItemUsingCurrentState:paddleView];
}

-

@end
