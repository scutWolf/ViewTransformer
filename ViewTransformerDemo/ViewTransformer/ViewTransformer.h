//
//  ViewTransformer.h
//  emoticonMaker
//
//  Created by Wolf on 15/3/27.
//  Copyright (c) 2015年 Wolf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewTransformer : UIView

@property (strong,nonatomic) UIView *targetView;

-(instancetype)initWithSize:(CGSize)size;
-(void)setTargetView:(UIView *)targetView;
-(void)correctTransformerPoint;

@end
