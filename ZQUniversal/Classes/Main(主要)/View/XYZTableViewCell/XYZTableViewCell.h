//
//  XYZTableViewCell.h
//  beauty
//
//  Created by xieyan on 15-2-11.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  tableviewcell
 */
#define XYZCellModel(_class_,_data_) @{@"class":NSStringFromClass([_class_ class]),@"data":(_data_)}



#define CellImageView(__Tag__)     ((UIImageView*)[cell.contentView viewWithTag:__Tag__])
#define CellLabel(__Tag__) ((UILabel*)[cell.contentView viewWithTag:__Tag__])
#define CellButton(__Tag__) ((UIButton*)[cell.contentView viewWithTag:__Tag__])
#define CellView(__Tag__) ((UIView*)[cell.contentView viewWithTag:__Tag__])
#define CellCustom(__Class__,__Tag__) ((__Class__*)[cell.contentView viewWithTag:__Tag__])



@interface XYZTableViewCell : UITableViewCell
//@property(nonatomic)CGFloat originalWidth;



/**
 *  cell里面有点击等操作工具
 */


@property(nonatomic)NSInteger index;
@property(nonatomic,strong)NSIndexPath*indexPath;
@property BOOL onState;
@property(nonatomic,strong)NSString*responseStr;
@property(nonatomic,strong)NSDictionary*responseDic;





/**
 *  设置它可以启动DrawRect
 */
@property(nonatomic)BOOL showSepar;
@property(nonatomic,strong)UIColor* xyzBgColor;
-(NSDictionary*)textAttributeFont:(NSInteger)font color:(UIColor*)color;



/**
 *  必须重写
 */


-(void)afterInit;//初始化
@end



@interface UIView (XYZ)
+(CGFloat)xyzCellHeight:(id)message width:(CGFloat)width;
@end

