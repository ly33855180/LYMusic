//
//  LYLeftRightVC.m
//  LYMusicPlay
//
//  Created by 刘羽 on 16/4/16.
//  Copyright © 2016年 RainTimeComming. All rights reserved.
//

#import "LYLeftRightSliderVC.h"

#import "LYLeftViewController.h"
#import "LYRightViewController.h"

#include "LYNaigationViewController.h"
typedef NS_ENUM(NSInteger,RMoveDirection) {
    RMoveDirectionLeft =0,
    RMoveDirectionRight
};
@interface LYLeftRightSliderVC ()<UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIView *mainContentView;
@property (nonatomic, weak) UIView *leftSideView;
@property (nonatomic, weak) UIView *rightSideView;

@property (nonatomic, strong) NSMutableDictionary *controllersDict;
@property (nonatomic, weak) UITapGestureRecognizer *tapGestureRec;
@property (nonatomic, weak) UIPanGestureRecognizer *panGestureRec;

@end

@implementation LYLeftRightSliderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self initSubViews];
    
    
    LYNaigationViewController* leftVC = [[LYNaigationViewController alloc] initWithRootViewController:[[LYLeftViewController alloc] init]];
 
    
    LYNaigationViewController* rightVC = [[LYNaigationViewController alloc] initWithRootViewController:[[LYRightViewController alloc] init]];
    

    
    self.LeftVC  =leftVC;
    self.RightVC =rightVC;
    
    [self initChildControllers:_LeftVC rightVC:_RightVC];
    [self showContentControllerWithModel:@"LYMainViewController"];
    
    UIPanGestureRecognizer* panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveViewWithGesture:)];
    self.panGestureRec = panGestureRecognizer;
    [self.mainContentView addGestureRecognizer:panGestureRecognizer];
}

-(void) moveViewWithGesture:(UIPanGestureRecognizer*) panGesture{
    static CGFloat currntTranslateX;
    if (UIGestureRecognizerStateBegan == panGesture.state) {
        currntTranslateX = self.mainContentView.transform.tx;
        
    }else if(UIGestureRecognizerStateChanged == panGesture.state){
        CGFloat transX = [panGesture translationInView:panGesture.view].x;
         transX = transX + currntTranslateX;
//        if ((transX > self.LeftSContentOffset)||(-transX > self.LeftSContentOffset))
//        {
//            return;
//        }
        CGFloat scaleY = 1;
        NSLog(@"x ==%f",transX);
       
        if (transX > 0) {
            [self.view sendSubviewToBack:self.rightSideView];
            scaleY = 1- (transX / self.RightSContentOffset)* (1 - self.LeftSContentScale);
            
        }else{
            [self.view sendSubviewToBack:self.leftSideView];
            scaleY = 1+(transX / self.RightSContentOffset)* (1 - self.RightSContentScale);

        }
        //currntTranslateX += transX;
        CGAffineTransform transS = CGAffineTransformMakeScale(1, scaleY);
        CGAffineTransform transT = CGAffineTransformMakeTranslation(transX, 0);
        CGAffineTransform conT = CGAffineTransformConcat(transS, transT);
        self.mainContentView.transform = conT;
    }
    else if(UIGestureRecognizerStateEnded == panGesture.state){
        CGFloat panX = [panGesture translationInView:panGesture.view].x;
        CGFloat finalX = currntTranslateX + panX;
        if (finalX > self.LeftSJudgeOffset) {
            //
            CGAffineTransform transS = CGAffineTransformMakeScale(1, self.LeftSContentScale);
            CGAffineTransform transT = CGAffineTransformMakeTranslation(self.LeftSContentOffset, 0);
            CGAffineTransform conT = CGAffineTransformConcat(transS, transT);
            [UIView animateWithDuration:self.LeftSOpenDuration animations:^{
                  self.mainContentView.transform = conT;
            } completion:^(BOOL finished) {
                
            }];
          
            return;
        }
        if (-finalX > self.RightSJudgeOffset) {

                CGAffineTransform transS = CGAffineTransformMakeScale(1, self.RightSContentScale);
                CGAffineTransform transT = CGAffineTransformMakeTranslation(-self.RightSContentOffset, 0);
                CGAffineTransform conT = CGAffineTransformConcat(transS, transT);
                [UIView animateWithDuration:self.RightSCloseDuration animations:^{
                    self.mainContentView.transform = conT;
                } completion:^(BOOL finished) {
                    
                }];
            return;
        }
        CGAffineTransform trans = CGAffineTransformIdentity;
        [UIView animateWithDuration:0.3 animations:^{
            self.mainContentView.transform = trans;
        } completion:^(BOOL finished) {
            //self.panGestureRec.enabled = NO;
        }];
        
    }else{
        //nothing todo;
    }
}
-(void) initSubViews{
    
    UIView * leftview = [[UIView alloc] initWithFrame:self.view.bounds];
    self.leftSideView = leftview;
    [self.view addSubview:leftview];
    
    UIView * rightview = [[UIView alloc] initWithFrame:self.view.bounds];
    self.rightSideView = rightview;
    [self.view addSubview:rightview];
    
    UIView * mainview = [[UIView alloc] initWithFrame:self.view.bounds];
    self.mainContentView = mainview;
    [self.view addSubview:mainview];
}

- (void)initChildControllers:(UIViewController*)leftVC rightVC:(UIViewController*)rightVC{
    [self addChildViewController:leftVC];
    leftVC.view.frame = CGRectMake(0, 0, leftVC.view.frame.size.width,leftVC.view.frame.size.height);
    [self.leftSideView addSubview:leftVC.view];
    
    [self addChildViewController:rightVC];
    rightVC.view.frame = CGRectMake(0, 0, rightVC.view.frame.size.width,rightVC.view.frame.size.height);
    [self.rightSideView addSubview:rightVC.view];
    
}
- (void)closeSideBar{
    CGAffineTransform oriT = CGAffineTransformIdentity;
    
    
    NSTimeInterval timeInterval =
    (self.mainContentView.transform.tx== self.LeftSContentOffset)?self.LeftSCloseDuration:self.RightSCloseDuration;
    
    [UIView animateWithDuration:timeInterval animations:^{
        self.mainContentView.transform = oriT;
    } completion:^(BOOL finished) {
        self.tapGestureRec.enabled = NO;
    }];
}
- (void)showContentControllerWithModel:(NSString *)className
{
    [self closeSideBar];
    LYNaigationViewController* controller = self.controllersDict[className];
    if (!controller) {
        Class c = NSClassFromString(className);
        controller = [[LYNaigationViewController alloc] initWithRootViewController:[[c alloc] init]];
        [self.controllersDict setObject:controller forKey:className];
        
        if (self.mainContentView.subviews.count) {
            UIView* view = [self.mainContentView.subviews firstObject];
            [view removeFromSuperview];
        }
        
        controller.view.frame = self.mainContentView.frame;
        [self.mainContentView addSubview:controller.view];
        [self addChildViewController:controller];
    }
}
-(NSMutableDictionary *)controllersDict{
    if (!_controllersDict) {
        _controllersDict = [NSMutableDictionary dictionary];
    }
    return _controllersDict;
}
+ (LYLeftRightSliderVC*) LeftRightSliderVC{
    static LYLeftRightSliderVC*  leftrightVC;
    static dispatch_once_t once_Token;
    dispatch_once(&once_Token, ^{
        leftrightVC = [[LYLeftRightSliderVC alloc] init];
    });
    
    return leftrightVC;
}
-(instancetype)init{
    if (self = [super init]) {
        _LeftSContentOffset=414-64;
        _RightSContentOffset=414-64;
        _LeftSContentScale=0.85;
        _RightSContentScale=0.85;
        _LeftSJudgeOffset=414*0.5;
        _RightSJudgeOffset=414*0.5;
        _LeftSOpenDuration=0.4;
        _RightSOpenDuration=0.4;
        _LeftSCloseDuration=0.3;
        _RightSCloseDuration=0.3;
    }
    return self;
}
@end
