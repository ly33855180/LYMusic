//
//  LYLeftRightVC.h
//  LYMusicPlay
//
//  Created by 刘羽 on 16/4/16.
//  Copyright © 2016年 RainTimeComming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYLeftRightSliderVC : UIViewController
@property (nonatomic, strong) UIViewController *LeftVC;
@property (nonatomic, strong) UIViewController *RightVC;
@property (nonatomic, strong) UIViewController *MainVC;



@property(nonatomic,assign)float LeftSContentOffset;
@property(nonatomic,assign)float RightSContentOffset;

@property(nonatomic,assign)float LeftSContentScale;
@property(nonatomic,assign)float RightSContentScale;

@property(nonatomic,assign)float LeftSJudgeOffset;
@property(nonatomic,assign)float RightSJudgeOffset;

@property(nonatomic,assign)float LeftSOpenDuration;
@property(nonatomic,assign)float RightSOpenDuration;

@property(nonatomic,assign)float LeftSCloseDuration;
@property(nonatomic,assign)float RightSCloseDuration;

+ (LYLeftRightSliderVC*) LeftRightSliderVC;

@end
