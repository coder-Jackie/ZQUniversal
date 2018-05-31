//
//  OMGToast.m
//  一米辅导-HD
//
//  Created by pengyixiong on 14/12/11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "OMGToast.h"
#import <QuartzCore/QuartzCore.h>

@interface OMGToast (private)

- (id)initWithText:(NSString *)text_;



- (void)toastTaped:(UIButton *)sender_;

- (void)showAnimation;
//- (void)hideAnimation;


- (void)showFromTopOffset:(CGFloat) topOffset_;
- (void)showFromBottomOffset:(CGFloat) bottomOffset_;


@end


@implementation OMGToast

@synthesize contentView;
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:[UIDevice currentDevice]];
//    [contentView release],contentView = nil;
//    [text release],text = nil;
//    [super dealloc];
}


- (id)initWithText:(NSString *)text_{
    if (self = [super init]) {
    
        text = [text_ copy];
        
        UIFont *font = [UIFont boldSystemFontOfSize:18];
        CGSize textSize = [text sizeWithFont:font
                           constrainedToSize:CGSizeMake(280, MAXFLOAT)
                               lineBreakMode:NSLineBreakByWordWrapping];
        CGFloat textWidth =textSize.width + 20;
        CGFloat textHeight =textSize.height + 20;
        if (text.length==0) {
            textWidth=0;
            textHeight=0;
        }
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textWidth, textHeight)];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.font = font;
        self.textLabel.text = text;
        self.textLabel.numberOfLines = 0;
        
        contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.textLabel.frame.size.width, self.textLabel.frame.size.height)];
        contentView.layer.cornerRadius = 5.0f;
        contentView.layer.borderWidth = 1.0f;
        contentView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
        contentView.backgroundColor = [UIColor colorWithRed:0.2f
                                                      green:0.2f
                                                       blue:0.2f
                                                      alpha:0.75f];
        [contentView addSubview:self.textLabel];
        contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [contentView addTarget:self
                        action:@selector(toastTaped:)
              forControlEvents:UIControlEventTouchDown];
        contentView.alpha = 0.0f;
//        [textLabel release];
        
        duration = DEFAULT_DISPLAY_DURATION;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationDidChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:[UIDevice currentDevice]];
    }
    return self;
}

- (void)deviceOrientationDidChanged:(NSNotification *)notify_{
//    [self hideAnimation];
}

-(void)dismissToast{
    [contentView removeFromSuperview];
}

-(void)toastTaped:(UIButton *)sender_{
    [self hideAnimation];
}

- (void)setDuration:(CGFloat) duration_{
    duration = duration_;
}

-(void)showAnimation{
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    contentView.alpha = 1.0f;
    [UIView commitAnimations];
}

-(void)hideAnimation{
    [UIView beginAnimations:@"hide" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissToast)];
    [UIView setAnimationDuration:0.3];
    contentView.alpha = 0.0f;
    [UIView commitAnimations];
}
- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self showInview:window];
}
- (void)showInview:(UIView*)window{
    
    contentView.center = window.center;
    [window  addSubview:contentView];
    //修复ios7下方向问题
    if (!([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)) {
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        if (orientation == UIInterfaceOrientationLandscapeLeft) {
            contentView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        }else if (orientation == UIInterfaceOrientationLandscapeRight){
            contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
    }
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:duration];
}

- (void)showFromTopOffset:(CGFloat) top_{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    contentView.center = CGPointMake(window.center.x, top_ + contentView.frame.size.height/2);
    [window  addSubview:contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:duration];
}

- (void)showFromBottomOffset:(CGFloat) bottom_{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    contentView.center = CGPointMake(window.center.x, window.frame.size.height-(bottom_ + contentView.frame.size.height/2));
    [window  addSubview:contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:duration];
}


+ (OMGToast*)showWithText:(NSString *)text_ {
    return [OMGToast showWithText:text_ duration:DEFAULT_DISPLAY_DURATION];
    
}

+ (OMGToast*)showWithText:(NSString *)text_
            duration:(CGFloat)duration_{
    OMGToast *toast = [[OMGToast alloc] initWithText:text_];
    [toast setDuration:duration_];
    [toast show];
    return toast;
}
+ (OMGToast*)showWithText:(NSString *)text_  inView:(UIView*)view{
    return [OMGToast showWithText:text_ inView:view duration:DEFAULT_DISPLAY_DURATION];
    
}

+ (OMGToast*)showWithText:(NSString *)text_
                   inView:(UIView*)view
                 duration:(CGFloat)duration_{
    OMGToast *toast = [[OMGToast alloc] initWithText:text_];
    [toast setDuration:duration_];
    [toast showInview:view];
    return toast;
}
+ (OMGToast*)showWithText:(NSString *)text_
           topOffset:(CGFloat)topOffset_{
   return [OMGToast showWithText:text_  topOffset:topOffset_ duration:DEFAULT_DISPLAY_DURATION];
}

+ (OMGToast*)showWithText:(NSString *)text_
           topOffset:(CGFloat)topOffset_
            duration:(CGFloat)duration_{
    OMGToast *toast = [[OMGToast alloc] initWithText:text_];
    [toast setDuration:duration_];
    [toast showFromTopOffset:topOffset_];
    return toast;
}

+ (OMGToast*)showWithText:(NSString *)text_
        bottomOffset:(CGFloat)bottomOffset_{
     return [OMGToast showWithText:text_  bottomOffset:bottomOffset_ duration:DEFAULT_DISPLAY_DURATION];
}

+ (OMGToast*)showWithText:(NSString *)text_
        bottomOffset:(CGFloat)bottomOffset_
            duration:(CGFloat)duration_{
    OMGToast *toast = [[OMGToast alloc] initWithText:text_];
    [toast setDuration:duration_];
    [toast showFromBottomOffset:bottomOffset_];
    return toast;
}

@end
