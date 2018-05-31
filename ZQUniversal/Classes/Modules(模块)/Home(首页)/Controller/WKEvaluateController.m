//
//  WKEvaluateController.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/25.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "WKEvaluateController.h"
#import "ZQTextView.h"

@interface WKEvaluateController () <UITextFieldDelegate>

/** 星星背景View */
@property (weak, nonatomic) IBOutlet UIView *starBgView;
/** 评价Lb */
@property (weak, nonatomic) IBOutlet UILabel *evaluateLb;
/** 星星按钮数组 */
@property(nonatomic, strong) NSMutableArray *starArr;
/** textView背景View */
@property (weak, nonatomic) IBOutlet UIView *textViewBgView;
/** 字数Lb */
@property (weak, nonatomic) IBOutlet UILabel *numLb;
/** 试图顶部约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTopConstraint;
/** 可输入字数个数 */
@property (nonatomic, assign) NSInteger maxLength;
/** 按钮底部约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnBottomContraint;
@end

@implementation WKEvaluateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.title = @"我要评价";
    self.maxLength = 2000;
    
    // X适配
    self.viewTopConstraint.constant = KSafeAreaTopHeight + 20;
    self.btnBottomContraint.constant = KSafeAreaBottomHeight + 10;
    
    [self addStars];
    
    [self addTextView];
    
}


- (void)addStars
{
    _starArr = [NSMutableArray array];
    
    // 添加星星
    CGFloat starY = 1;
    CGFloat starWH = 18;
    CGFloat starMargin = 5;
    for (int i = 0; i < 5; i++) {
        UIButton *starBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [starBtn setImage:[UIImage imageNamed:@"symbols-ic_star-off"] forState:UIControlStateNormal];
        [starBtn setImage:[UIImage imageNamed:@"symbols-ic_star-on"] forState:UIControlStateSelected];
        starBtn.tag = i + 1;
        starBtn.frame = CGRectMake(i * (starWH + starMargin), starY, starWH, starWH);
        [starBtn addTarget:self action:@selector(starAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.starBgView addSubview:starBtn];
        [self.starArr addObject:starBtn];
        
        if (i == 4) {
            [self starAction:starBtn];
        }
    }
}


- (void)addTextView
{
    // 添加TextView
    ZQTextView *textView = [[ZQTextView alloc] init];
    textView.placehoder = @"欢迎留下您的宝贵想法，评价将在审核后公开显示";
//    textView.textColor = ColorHex(@"222222");
//    textView.font = [UIFont systemFontOfSize:14];
    textView.delegate = (id)self;
    textView.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    [self.textViewBgView addSubview:textView];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
}

- (void)starAction:(UIButton *)btn
{
    NSInteger num = btn.tag;
    
    NSString *showStr = @"非常有帮助";
    switch (num) {
        case 1: {
            showStr = @"没有帮助";
            break;
        }
        case 2: {
            showStr = @"帮助较少";
            break;
        }
        case 3: {
            showStr = @"较有帮助";
            break;
        }
        case 4: {
            showStr = @"很有帮助";
            break;
        }
        case 5: {
            showStr = @"非常有帮助";
            break;
        }
        default:
            break;
    }
    // 评价LB
    self.evaluateLb.text = showStr;
    
    [self.starArr enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < num) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }];
}


- (IBAction)submitBtnAction:(UIButton *)sender {
    ZQLog(@"提交评价点击");
}

#pragma mark - UITextFieldDelegate
-(void)textViewDidChange:(UITextView *)textView{
    
    NSInteger currentNum = textView.text.length >= self.maxLength ? self.maxLength : textView.text.length;
    self.numLb.text = [NSString stringWithFormat:@"%zd/%zd",currentNum,self.maxLength];
    
}

// 限制输入MAXNUM字  只有在键盘输入时系统才会调用,联想输入不会调用.
// range 代表当前输入
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //SDLog(@"----:%zd",range.location);
    if ([text isEqualToString:@""] && range.length > 0) {
        //删除字符肯定是安全的
        return YES;
        
    } else if (range.location >= self.maxLength) {
        //控制输入文本的长度
        [OMGToast showWithText:@"已超出最大可输入长度(2000)" topOffset:180];
        return  NO;
        
    } else if ([text isEqualToString:@"\n"]){
        //禁止输入换行
        return NO;
        
    } else {
        return YES;
    }
    
}

@end
