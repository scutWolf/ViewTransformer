//
//  UIView+Radian.m
//  emoticonMaker
//
//  Created by Wolf on 15/3/26.
//  Copyright (c) 2015年 Wolf. All rights reserved.
//

#import "UIView+Radian.h"

@implementation UIView (Radian)

-(CGFloat)rotatedRadian{

    CGAffineTransform currentTransForm = self.transform;
    CGFloat currentRadian = atan2f(currentTransForm.b, currentTransForm.a);
    
    return currentRadian;

}

@end
