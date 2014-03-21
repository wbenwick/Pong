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
   
    UIDynamicAnimator   *dynamicAnimator;
    UIPushBehavior      *pushBehavior;
    UICollisionBehavior *collisionBehavior;
    UIGravityBehavior   *gravityBehavior;
    UIDynamicItemBehavior   *ballDynamicBehavior1;
    UIDynamicItemBehavior   *ballDynamicBehavior2;
    UIDynamicItemBehavior   *paddleDynamicBehavior;
    
}

@end

@implementation FLXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    pushBehavior  = [[UIPushBehavior alloc] initWithItems:@[ballImageView1, ballImageView2] mode: UIPushBehaviorModeInstantaneous];
    collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[ballImageView1, ballImageView2, paddleView]];
    ballDynamicBehavior1 = [[UIDynamicItemBehavior alloc] initWithItems:@[ballImageView1]];
    ballDynamicBehavior2 = [[UIDynamicItemBehavior alloc] initWithItems:@[ballImageView2]];
    paddleDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[paddleView]];
    
    pushBehavior.pushDirection = CGVectorMake(0.5,1.0);
    pushBehavior.active = YES;
    pushBehavior.magnitude = 0.5;
    [dynamicAnimator addBehavior:pushBehavior];
    
//    gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[ballView]];
//    gravityBehavior.magnitude = 0.0;
//    gravityBehavior.gravityDirection = CGVectorMake(0, 0);
//    [dynamicAnimator addBehavior:gravityBehavior];

    
    ballDynamicBehavior1.allowsRotation = YES;
    ballDynamicBehavior1.elasticity = 1.1;
    ballDynamicBehavior1.friction = 0.01;
    ballDynamicBehavior1.resistance = 0.0;
    [dynamicAnimator addBehavior:ballDynamicBehavior1];

    ballDynamicBehavior2.allowsRotation = NO;
    ballDynamicBehavior2.elasticity = 1.0;
    ballDynamicBehavior2.friction = 0.0;
    ballDynamicBehavior2.resistance = 0.0;
    [dynamicAnimator addBehavior:ballDynamicBehavior2];
    
    paddleDynamicBehavior.allowsRotation = NO;
    paddleDynamicBehavior.density = 10000.0f;
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
//        ballView.backgroundColor = [UIColor greenColor];
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:1.0 animations:^{
//            ballView.backgroundColor = [UIColor whiteColor];
//        }];
//        NSLog(@"animation complete");
//    }];
//    NSLog(@"collision detected");
    
}

-(IBAction)dragPaddle:(UIPanGestureRecognizer *)panGestureRecognizer
{
    paddleView.center = CGPointMake([panGestureRecognizer locationInView:self.view].x,paddleView.center.y);
    [dynamicAnimator updateItemUsingCurrentState:paddleView];
}

@end
