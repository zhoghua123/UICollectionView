//
//  ZHWaterLayout.h
//  自定义布局的学习
//
//  Created by xyj on 2017/10/12.
//  Copyright © 2017年 xyj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHWaterLayout;
//自定义协议
@protocol ZHWaterLayoutDelegate<NSObject>
@required
/**
 返回item的高度
 */
-(CGFloat)waterLayout:(ZHWaterLayout *)waterLayout heightForItemAtIndex:(NSInteger )index andItemWidth:(CGFloat)itemWidth;
@optional
/**
 有多少列
 */
-(NSInteger)columCountWaterLayout:(ZHWaterLayout *)waterLayout;
/**
列边距
 */
-(CGFloat)columMarginWaterLayout:(ZHWaterLayout *)waterLayout;
/**
行间距
 */
-(CGFloat)rowMarginWaterLayout:(ZHWaterLayout *)waterLayout;
/**
 内边距
 */
-(UIEdgeInsets )edgeInsetsWaterLayout:(ZHWaterLayout *)waterLayout;
@end
@interface ZHWaterLayout : UICollectionViewLayout
@property (nonatomic,weak) id<ZHWaterLayoutDelegate> delegate;
@end
