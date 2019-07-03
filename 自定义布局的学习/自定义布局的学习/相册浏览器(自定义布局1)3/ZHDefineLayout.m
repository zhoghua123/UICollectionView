//
//  ZHDefineLayout.m
//  自定义布局的学习
//
//  Created by xyj on 2017/10/11.
//  Copyright © 2017年 xyj. All rights reserved.
//

//
/*
 本次使用布局完全用自定义布局UICollectionViewLayout,不再继承自流水布局UICollectionViewFlowLayout
 继承自最根本的布局UICollectionViewLayout注意以下几点:
 1.cell的所有的attribute对象需要自己创建
 需要重写:layoutAttributesForElementsInRect方法
 为了只计算一次,那么就可以把计算放在prepareLayout方法中
 如果数据量非常大,那么可以把计算放在子线程中,当计算完成回到主线程刷新布局即可
 2.collectionView的contentsize需要你重新告诉他,否则不滚动
 需要重写:collectionViewContentSize方法
 3.重写返回每一个cell的布局属性layoutAttributesForItemAtIndexPath
 要是切换布局的话这个方法必须实现,否则报错
 不切换可以不实现
 */
#import "ZHDefineLayout.h"
@interface ZHDefineLayout()
@property (nonatomic,strong) NSMutableArray *attriArray;
@end
@implementation ZHDefineLayout
-(NSMutableArray *)attriArray{
    if (_attriArray == nil) {
        _attriArray = [NSMutableArray array];
    }
    return _attriArray ;
}
-(void)prepareLayout{
    [super prepareLayout];
    //1. 计算出所有cell的UICollectionViewLayoutAttributes
    [self.attriArray removeAllObjects];
    //拿到collectionView的所有的cell个数,这里只考虑一个section,多组两重for循环
    //多少组
    NSInteger sectoncount = [self.collectionView numberOfSections];
    //那一组多少个
    NSInteger rowcount = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0 ; i<rowcount; i++) {
        //创建UICollectionViewLayoutAttributes
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexpath];
        //设置布局属性
        CGFloat width = self.collectionView.frame.size.width * 0.5;
        CGFloat height = 0;
        CGFloat x = 0;
        CGFloat y = 0;
        //i%3==0时 height = width
        if (i%3 == 0) {
            height = width;
            x = 0;
            y = i/3*width;
        }else if (i%3 == 1){
            height = 0.5*width;
            x = width;
            y = i/3 * width;
        }else if (i%3 == 2){
            height = 0.5 * width;
            x = width;
            y = i/3 * width + 0.5*width;
        }
        attri.frame = CGRectMake(x, y, width, height);
        //添加UICollectionViewLayoutAttributes到数组中
        [self.attriArray addObject:attri];
    }
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //继承自最根本的布局,因此就不用调用该方法了
//    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    //既然没有,那就需要我们自己创建了
    return self.attriArray;
}
//2. 因为你是空白继承,需要告诉他collectionView的contentsize才能滚动
-(CGSize)collectionViewContentSize{
    //那一组多少个
    NSInteger rowcount = [self.collectionView numberOfItemsInSection:0];
    CGSize size;
    size.width = self.collectionView.frame.size.width;
    CGFloat height =(rowcount + 2)/3 *self.collectionView.frame.size.width * 0.5 ;
    size.height = height;
    return size;
}

/**
 3. 返回每一个cell的布局属性
 要是切换布局的话这个方法必须实现,否则报错
 不切换可以不实现
 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.attriArray[indexPath.item];
}
@end
