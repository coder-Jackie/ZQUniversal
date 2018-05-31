//
//  XYZView.m
//  XYZCollection
//
//  Created by xieyan on 15/7/27.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZView.h"
#import <objc/runtime.h>

@implementation UIView (XYZMessage)

static char xyzdelegatekey;

-(void)setXyzDelegate:(id<XYZDelegate>)xyzDelegate{
    objc_setAssociatedObject(self, &xyzdelegatekey, xyzDelegate, OBJC_ASSOCIATION_ASSIGN);
}
-(id<XYZDelegate>)xyzDelegate{
    return objc_getAssociatedObject(self, &xyzdelegatekey);
}





static char xyzmessageKey;
-(void)setXyzMessage:(id)xyzMessage{
    objc_setAssociatedObject(self, &xyzmessageKey, xyzMessage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self xyzMessageSet:xyzMessage];
}
-(id)xyzMessage{
    return  objc_getAssociatedObject(self, &xyzmessageKey);
}
-(void)xyzMessageSet:(id)message{}




static char xyzCallBackBlockKey;
-(void)setXyzCallBackBlock:(id)xyzCallBackBlock{
    objc_setAssociatedObject(self, &xyzCallBackBlockKey, xyzCallBackBlock, OBJC_ASSOCIATION_COPY);
}
-(id)xyzCallBackBlock{
    return objc_getAssociatedObject(self, &xyzCallBackBlockKey);
}






+(CGSize)xyzSizeWithMessage:(id)message refSize:(CGSize)size{
    return CGSizeZero;
}
@end


@implementation XYZView
-(instancetype)init{
    self = [super init];
    if (self) {
        [self prepare];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self prepare];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
    }
    return self;
}
-(void)prepare{
    _separatorInset = UIEdgeInsetsZero;
    _separatorLineWidth = 1.0;
    [self afterInit];
}
-(void)afterInit{
    
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIColor* color;
    if (self.separatorColor) {
        color = self.separatorColor;
    }else{
        color = [UIColor colorWithWhite:0.800 alpha:1.000];
    }
    [color set];
    CGContextSetLineWidth(ctx, 1.0);
    CGContextSetLineWidth(ctx, self.separatorLineWidth);
    CGContextBeginPath(ctx);
    CGFloat offset = self.separatorLineWidth/2;
    if (self.separatorInset.left>1) {
        
        CGContextMoveToPoint(ctx, rect.origin.x+offset, rect.origin.y+(rect.size.height-self.separatorInset.left)/2);
        
        CGContextAddLineToPoint(ctx, rect.origin.x+offset, rect.origin.y+rect.size.height-(rect.size.height-self.separatorInset.left)/2);
    }
    
    if (self.separatorInset.right>1) {
        
        CGContextMoveToPoint(ctx, rect.origin.x+rect.size.width-offset, rect.origin.y+(rect.size.height-self.separatorInset.right)/2);
        
        CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width-offset, rect.origin.y+rect.size.height-(rect.size.height-self.separatorInset.right)/2);
    }
    
    
    if (self.separatorInset.top>1) {
        
        CGContextMoveToPoint(ctx, rect.origin.x+(rect.size.width-self.separatorInset.top)/2, rect.origin.y+offset);
        
        CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width-(rect.size.width-self.separatorInset.top)/2, rect.origin.y+offset);
    }
    
    if (self.separatorInset.bottom>1) {
        
        CGContextMoveToPoint(ctx, rect.origin.x+(rect.size.width-self.separatorInset.bottom)/2, rect.origin.y+rect.size.height-offset);
        
        CGContextAddLineToPoint(ctx, rect.origin.x+rect.size.width-(rect.size.width-self.separatorInset.bottom)/2, rect.origin.y+rect.size.height-offset);
    }
    CGContextStrokePath(ctx);
}

-(void)setSeparatorLineWidth:(CGFloat)separatorLineWidth{
    _separatorLineWidth = separatorLineWidth;
    [self setNeedsDisplay];
}
-(void)setSeparatorInset:(UIEdgeInsets)separatorInset{
    _separatorInset = separatorInset;
    [self setNeedsDisplay];
}
@end
