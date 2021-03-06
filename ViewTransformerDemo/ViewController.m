//
//  ViewController.m
//  ViewTransformerDemo
//
//  Created by Wolf on 15/3/28.
//  Copyright (c) 2015年 Wolf. All rights reserved.
//

#import "ViewController.h"
#import "ViewTransformer.h"


@interface ViewController ()

@property (strong,nonatomic) ViewTransformer *viewTransformer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    
    //test view
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor greenColor];
    [view addGestureRecognizer:panGesture];
    

    //test label
    UIPanGestureRecognizer *labelPanGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    NSString *labelString = @"testing";
    UIFont *font = [UIFont fontWithName:@"Arial" size:30];
    CGRect textRect = [labelString boundingRectWithSize:CGSizeMake(10000.0f, 10000.0f)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:font}
                                                   context:nil];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 300, textRect.size.width, textRect.size.height)];
    label.text=labelString;
    label.font = font;
    label.userInteractionEnabled = YES;
    [label addGestureRecognizer:labelPanGesture];
    
    [self.view addSubview:view];
    [self.view addSubview:label];
    
}


-(ViewTransformer *)viewTransformer {
    
    if (!_viewTransformer) {
        
        //size of transformer
        CGSize size = CGSizeMake(25.0, 25.0);
        _viewTransformer = [[ViewTransformer alloc]initWithIconImage:[UIImage imageNamed:@"addIcon"] size:size];
        [self.view addSubview:_viewTransformer];
    }
    return _viewTransformer;
}


-(void)handlePanGesture:(UIPanGestureRecognizer *)recognizer{


    self.viewTransformer.targetView = recognizer.view;
    
    if (recognizer.state == UIGestureRecognizerStateChanged ||
        recognizer.state == UIGestureRecognizerStateEnded){
        
        
        CGPoint translation = [recognizer translationInView:self.view];
        CGPoint point = CGPointMake (translation.x+recognizer.view.center.x,
                                     translation.y+recognizer.view.center.y);
        
        recognizer.view.center = point;
        
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
        [self.viewTransformer correctTransformerPoint];
    }


}

@end
