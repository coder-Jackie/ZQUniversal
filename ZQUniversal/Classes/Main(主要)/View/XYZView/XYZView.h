//
//  XYZView.h
//  XYZCollection
//
//  Created by xieyan on 15/7/27.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ViewOf(__View__,__TAG__) [__View__ viewWithTag:__TAG__]
#define LabelOf(__View__,__TAG__) ((UILabel*)[__View__ viewWithTag:__TAG__])
#define ImageOf(__View__,__TAG__) ((UIImageView*)[__View__ viewWithTag:__TAG__])
#define ButtonOf(__View__,__TAG__) ((UIButton*)[__View__ viewWithTag:__TAG__])



#define View(__TAG__) [theView viewWithTag:__TAG__]
#define Label(__TAG__) ((UILabel*)[theView viewWithTag:__TAG__])
#define Image(__TAG__) ((UIImageView*)[theView viewWithTag:__TAG__])
#define Button(__TAG__) ((UIButton*)[theView viewWithTag:__TAG__])



#define LabelCreate(__TAG__) UILabel* label_##__TAG__ = [[UILabel alloc] init];\
label_##__TAG__.tag = __TAG__;\
[theView addSubview:label_##__TAG__];


#define ImageCreate(__TAG__) UIImageView* image##__TAG__ = [[UIImageView alloc] init];\
image##__TAG__.tag = __TAG__;\
image##__TAG__.contentMode = UIViewContentModeCenter;\
[theView addSubview:image##__TAG__];


#define ViewCreate(__TAG__) UIView* view##__TAG__ = [[UIView alloc] init];\
view##__TAG__.tag = __TAG__;\
[theView addSubview:view##__TAG__];



#define XYZDelegateValid (self.xyzDelegate && [self.xyzDelegate respondsToSelector:@selector(XYZResponse:)])


typedef void(^xyzCallBackDefault)(UIView* theView,id msg);

@protocol XYZDelegate <NSObject>
-(void)XYZResponse:(UIView*)view;
@end
@interface UIView (XYZMessage)
@property(nonatomic,assign)id<XYZDelegate>xyzDelegate;

@property(nonatomic,strong)id xyzMessage;

@property(nonatomic,copy) id xyzCallBackBlock;

-(void)xyzMessageSet:(id)message;

+(CGSize)xyzSizeWithMessage:(id)message refSize:(CGSize)size;
@end

@interface XYZView : UIView
@property(nonatomic,assign)UIEdgeInsets separatorInset;
@property(nonatomic,assign)CGFloat separatorLineWidth;
@property(nonatomic,strong)UIColor* separatorColor;


-(void)afterInit;
@end
