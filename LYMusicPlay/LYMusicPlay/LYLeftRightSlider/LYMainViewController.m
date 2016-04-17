//
//  LYMainViewController.m
//  LYMusicPlay
//
//  Created by 刘羽 on 16/4/16.
//  Copyright © 2016年 RainTimeComming. All rights reserved.
//
#import "LYListionView.h"
#import "LYMainViewController.h"

@interface LYMainViewController ()
@property (weak, nonatomic) IBOutlet UIView *TopView;
@property (nonatomic, strong) UIView* listionView;
@property (nonatomic, strong) UIView* watchView;
@property (nonatomic, strong) UIView* singView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation LYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homePage_default"]];
    
    imgView.frame = self.view.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view insertSubview:imgView atIndex:0];
    
//    self.TopView.backgroundColor = [UIColor colorWithRed:18.0 / 255 green:31.0/255 blue:88/255 alpha:1.0];
   NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"LYListionView" owner:nil options:nil];
    LYListionView* listionView = (LYListionView*)array.firstObject;
    self.listionView = listionView;
    [self.scrollView addSubview:listionView];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.alwaysBounceVertical = NO;
    
    //self.scrollView.contentInset =  UIEdgeInsetsMake(-100, 0, 100, 0);
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
