//
//  ZHWaterLayout.m
//  自定义布局的学习
//
//  Created by xyj on 2017/10/12.
//  Copyright © 2017年 xyj. All rights reserved.
//

#import "ZHWaterLayout.h"

@interface ZHWaterLayout()
@property (nonatomic,strong) NSMutableArray *attriArray;
//用来存放所有列的高度
@property (nonatomic,strong) NSMutableArray *colsHeght;
//注意get方法要想提示写出,必须在这里先声明!!!!
-(CGFloat)rowMargin;
-(CGFloat)columMargin;
-(NSInteger)columCount;
-(UIEdgeInsets)edgeInsets;

@end
//默认值
static const CGFloat rowMargin = 10;//行距
static const CGFloat colMargin = 10;//列距
static const NSInteger col = 3;//默认列数
static const UIEdgeInsets edgeInsets = {10,10,10,10};//内边距

@implementation ZHWaterLayout
//数据处理get方法
-(CGFloat)rowMargin{
    if ([self.delegate respondsToSelector:@selector(rowMarginWaterLayout:)]) {
        return [self.delegate rowMarginWaterLayout:self];
    }else{
        return rowMargin;
    }
}
-(CGFloat)columMargin{
    if ([self.delegate respondsToSelector:@selector(columMarginWaterLayout:)]) {
        return [self.delegate columMarginWaterLayout:self];
    }else{
        return colMargin;
    }
}
-(NSInteger)columCount{
    if ([self.delegate respondsToSelector:@selector(columCountWaterLayout:)]) {
        return [self.delegate columCountWaterLayout:self];
    }else{
        return col;
    }
}
-(UIEdgeInsets)edgeInsets{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsWaterLayout:)]) {
        return [self.delegate edgeInsetsWaterLayout:self];
    }else{
       return edgeInsets;
    }
}
//记录各列的高度
-(NSMutableArray *)colsHeght{
    if (_colsHeght == nil) {
        _colsHeght = [NSMutableArray array];
    }
    return _colsHeght ;
}
//存储所有cell的UICollectionViewLayoutAttributes
-(NSMutableArray *)attriArray{
    if (_attriArray == nil) {
        _attriArray = [NSMutableArray array];
    }
    return _attriArray ;
}
//初始化操作
-(void)prepareLayout{
    [super prepareLayout];
    //1.每次刷新就回重新布局一次,重新清理一下数据
    //1.1清除高度数组并初始化
    [self.colsHeght removeAllObjects];
    //初始化数组
    for (int i= 0; i<self.columCount; i++) {
        [self.colsHeght addObject:@(self.edgeInsets.top)];
    }
    //1.2清除布局属性数据
    [self.attriArray removeAllObjects];
    //2.计算出所有cell的UICollectionViewLayoutAttributes
    //共多少个item
    NSInteger rowcount = [self.collectionView numberOfItemsInSection:0];
    //遍历计算出每一个
    for (int i = 0 ; i<rowcount; i++) {
        //创建UICollectionViewLayoutAttributes
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:indexpath];
        //添加UICollectionViewLayoutAttributes到数组中
        [self.attriArray addObject:attri];
    }
}
//返回rect内的所有cell的UICollectionViewLayoutAttributes数组
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attriArray;
}

//返回每一个cell的UICollectionViewLayoutAttributes
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //1.创建UICollectionViewLayoutAttributes对象
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //2.设置UICollectionViewLayoutAttributes的frame属性
    CGFloat collectW = self.collectionView.frame.size.width;
    //2.1计算出宽度
    CGFloat width = (collectW-self.edgeInsets.left-self.edgeInsets.right-(self.columCount-1)*self.columMargin)/self.columCount;
    //2.2根据外部模型数据传进来的高度计算出高度
    CGFloat height = [self.delegate waterLayout:self heightForItemAtIndex:indexPath.item andItemWidth:width];
    //2.3 计算出x
    //找出高度最短的那一列
//    __block NSUInteger desCol = 0;
//   __block CGFloat minColHeight = MAXFLOAT;
//    [self.colsHeght enumerateObjectsUsingBlock:^(NSNumber *  _Nonnull colHeight, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (colHeight.doubleValue < minColHeight) {
//            minColHeight = colHeight.doubleValue;
//            desCol = idx;
//        }
//    }];
    //这样遍历可以少算一列
    NSInteger desCol = 0;
    CGFloat minColHeight = [self.colsHeght[0] doubleValue];
    for (NSInteger i = 1; i<self.columCount; i++) {
        //获取第一列的高度
        CGFloat colH = [self.colsHeght[i] doubleValue];
        if (colH<minColHeight) {
            minColHeight = colH;
            desCol = i;
        }
    }
    CGFloat x = self.edgeInsets.left + desCol*(width + self.columMargin);
    //2.4计算出y值
    CGFloat y = minColHeight;//第一行时不加rowmargin
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    //3.赋值frame
    attri.frame = CGRectMake(x,y, width, height);
    //4.更新高度数组
    self.colsHeght[desCol] =@(CGRectGetMaxY(attri.frame)) ;
    return attri;
}

//返回collectionView的contentsize
-(CGSize)collectionViewContentSize{
    CGFloat maxColHeight = [self.colsHeght[0] doubleValue];
    for (NSInteger i = 1; i<self.columCount
         ; i++) {
        //获取第一列的高度
        CGFloat colH = [self.colsHeght[i] doubleValue];
        if (colH>maxColHeight) {
            maxColHeight = colH;
        }
    }
    return CGSizeMake(0, maxColHeight+self.edgeInsets.bottom);
}

@end
