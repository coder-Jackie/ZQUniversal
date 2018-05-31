//
//  OMGToast.h
//  一米辅导-HD
//
//  Created by pengyixiong on 14/12/11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEFAULT_DISPLAY_DURATION 2.0f


@interface OMGToast : UIView {
    NSString *text;
//    UIButton *contentView;
    CGFloat  duration;
}
@property(nonatomic,strong)UIButton *contentView;
@property (nonatomic , strong)UILabel *textLabel ;
@property (nonatomic,strong)UIImageView * imageView;
- (void)hideAnimation;
- (void)dismissToast;
- (void)setDuration:(CGFloat) duration_;
- (void)show;
+ (OMGToast*)showWithText:(NSString *) text_;
+ (OMGToast*)showWithText:(NSString *) text_
            duration:(CGFloat)duration_;

+ (OMGToast*)showWithText:(NSString *)text_  inView:(UIView*)view;


+ (OMGToast*)showWithText:(NSString *)text_
                   inView:(UIView*)view
                 duration:(CGFloat)duration_;


+ (OMGToast*)showWithText:(NSString *) text_
           topOffset:(CGFloat) topOffset_;
+ (OMGToast*)showWithText:(NSString *) text_
           topOffset:(CGFloat) topOffset
            duration:(CGFloat) duration_;

+ (OMGToast*)showWithText:(NSString *) text_
        bottomOffset:(CGFloat) bottomOffset_;
+ (OMGToast*)showWithText:(NSString *) text_
        bottomOffset:(CGFloat) bottomOffset_
            duration:(CGFloat) duration_;

@end
