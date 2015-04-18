//
//  ViewTransformer.m
//  emoticonMaker
//
//  Created by Wolf on 15/3/27.
//  Copyright (c) 2015年 Wolf. All rights reserved.
//

#import "ViewTransformer.h"
#import "UIView+Radian.h"

@interface ViewTransformer ()

@property (assign,nonatomic) CGFloat radian;
@property (assign,nonatomic) CGRect currentBounds;
@property (assign,nonatomic) CGPoint startPointCenter;

@end

@implementation ViewTransformer



-(instancetype)initWithIconImage:(UIImage *)image size:(CGSize)size{

    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    self = [super initWithFrame:frame];
    self.hidden = YES;
    
    self.borderColor = [UIColor orangeColor];
    self.borderWidth = 1.0;
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [self addSubview:imageView];
    
    return self;

}


-(void)setTargetView:(UIView *)targetView{
    
    if (!targetView) {
        
        _targetView.layer.borderWidth = 0;
        _targetView = nil;
        self.hidden = YES;
        
    }
    else{
    
        self.layer.zPosition = targetView.layer.zPosition + 1;
        
        for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
            [self removeGestureRecognizer:recognizer];
        }
        UIGestureRecognizer *transformPanGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
        [self addGestureRecognizer:transformPanGesture];
        
        _targetView.layer.borderWidth = 0;
        _targetView = targetView;
        _targetView.layer.borderWidth = self.borderWidth;
        _targetView.layer.borderColor = [self.borderColor CGColor];
        _targetView.layer.allowsEdgeAntialiasing = YES;
        [self correctTransformerPoint];
        
    }
    
    
}

-(void)setBorderColor:(UIColor *)borderColor{

    _borderColor = borderColor;
    self.targetView.layer.borderColor = [borderColor CGColor];
}

-(void)setBorderWidth:(CGFloat)borderWidth{

    _borderWidth = borderWidth;
    self.targetView.layer.borderWidth = borderWidth;

}

-(void)correctTransformerPoint{
    
    if (!self.targetView) {
        NSLog(@"no targetView!");
    }
    else{
        
        self.hidden = NO;
        
        CGFloat currentRadian = [self.targetView rotatedRadian];
        CGSize currentSize = self.targetView.bounds.size;
        
        
        
        CGPoint targetViewCenter = self.targetView.center;
        CGPoint preRightDownPoint  = CGPointMake(currentSize.width, currentSize.height);
        CGFloat x = preRightDownPoint.x * cos(currentRadian) - preRightDownPoint.y *sin(currentRadian);
        CGFloat y = preRightDownPoint.x * sin(currentRadian) + preRightDownPoint.y *cos(currentRadian);
        
        self.center = CGPointMake(targetViewCenter.x + x/2,targetViewCenter.y + y/2);
        
    }
}

-(void)handlePanGesture:(UIPanGestureRecognizer *)recognizer{
    
    CGFloat currentRadian;
    
    if (recognizer.state ==UIGestureRecognizerStateBegan) {

        currentRadian = [self.targetView rotatedRadian];
        
        self.radian = currentRadian;
        self.currentBounds = self.targetView.bounds;
        self.startPointCenter = recognizer.view.center;
    }
    
    
    if (recognizer.state == UIGestureRecognizerStateChanged ||
        recognizer.state == UIGestureRecognizerStateEnded){
        
        
        CGFloat recognizerX = self.startPointCenter.x;
        CGFloat recognizerY = self.startPointCenter.y;
        
        CGPoint translation = [recognizer translationInView:self.targetView.superview];
        
        CGFloat lastPointX = translation.x+recognizerX;
        CGFloat lastPointY = translation.y+recognizerY;
        
        CGPoint centerPoint = self.targetView.center;
        CGFloat centerX = centerPoint.x;
        CGFloat centerY = centerPoint.y;
        
        
        CGFloat a = sqrt((recognizerX - lastPointX)*(recognizerX - lastPointX) + (recognizerY - lastPointY)*(recognizerY - lastPointY));
        //distance of point before moving to Center point
        CGFloat b = sqrt((recognizerX - centerX)*(recognizerX - centerX) + (recognizerY - centerY)*(recognizerY - centerY));
        //distance of point after moving to Center point
        CGFloat c = sqrt((lastPointX - centerX)*(lastPointX - centerX) + (lastPointY - centerY)*(lastPointY - centerY));
        CGFloat radian = 0.0;
        int direction;
        
        CGFloat cosA = (b*b+c*c-a*a)/(2*b*c);
        radian = acos(cosA);
        //Vector
        CGPoint prc = CGPointMake( centerX - recognizerX , centerY - recognizerY );
        CGPoint pcl = CGPointMake( lastPointX - centerX , lastPointY - centerY);
        //Vector X Vector
        CGFloat prcXpcl = prc.x * pcl.y - prc.y * pcl.x ;
        
        if (prcXpcl >= 0) {
            direction = -1;
        }
        else{
            direction = 1;
        }
        
        CGAffineTransform transform = CGAffineTransformMakeRotation(self.radian + radian * direction);
        self.targetView.transform =transform;
        
        CGFloat scale = c/b;
        
        CGRect newBounds = CGRectMake(self.currentBounds.origin.x, self.currentBounds.origin.y, self.currentBounds.size.width * scale , self.currentBounds.size.height * scale );
        
        self.targetView.bounds = newBounds;

        
        CGPoint itemCenterPoint = CGPointMake(self.startPointCenter.x + translation.x, self.startPointCenter.y + translation.y);
        recognizer.view.center = itemCenterPoint;
        
        if ([self.targetView isKindOfClass:[UILabel class]]) {
            
            UILabel *label = (UILabel *)self.targetView;
            NSString *string = label.text;
            
            
            for (int i=1; i<100; i++) {
                
                UIFont *currentFont = label.font;
                
                UIFont *font = [UIFont fontWithName:currentFont.fontName size:i];
                
                CGRect textRect = [string boundingRectWithSize:CGSizeMake(10000.0f, 10000.0f)
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName:font}
                                                       context:nil];
                if ((textRect.size.height>label.bounds.size.height)||(textRect.size.width>label.bounds.size.width)) {
                    
                    label.font = [UIFont fontWithName:currentFont.fontName size:i-1];
                    break;
                    
                }
            }
        }
    }

    
    
    
    
    
}

@end
































