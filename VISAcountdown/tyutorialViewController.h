//
//  tyutorialViewController.h
//  VISAcountdown
//
//  Created by hiratanaoki on 2014/12/19.
//  Copyright (c) 2014年 hiratanaoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tyutorialViewController : UIViewController<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIPageControl *pageControl;

@property(nonatomic,strong) UIScrollView *cancelView;

@end
