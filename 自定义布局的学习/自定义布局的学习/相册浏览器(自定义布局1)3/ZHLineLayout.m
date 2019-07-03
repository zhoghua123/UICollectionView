//
//  ZHLineLayout.m
//  自定义布局的学习
//
//  Created by xyj on 2017/10/10.
//  Copyright © 2017年 xyj. All rights reserved.
//
/*
 实现主要步骤:
 1.cell的放大缩小
 2.停止滚动时:cell的居中
 UICollectionViewLayoutAttributes-布局属性
 一个cell就对应一个UICollectionViewLayoutAttributes对象
 UICollectionViewLayoutAttributes对象决定了cell的展示样式(frame等其他)
 */
#import "ZHLineLayout.h"

@implementation ZHLineLayout


/**
 UICollectionViewLayout方法：
 当collectionView的显示范围发生改变的时候(就是contentsize显示那部分),是否需要重新布局
 一旦刷新布局,就会重新调用layoutAttributesForElementsInRect方法和prepareLayout方法
 即:只要滚动,就回改变contentsize的显示rect,那么就会调用layoutAttributesForElementsInRect重新布局
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

/**
 UICollectionViewLayout方法
 准备布局
 所有的初始化操作都要放在这里面,不要放在上面init中,因为调用init方法时,self还没有添加到collectionView里面,因此self.collectionView为nil,itemsize也不能拿到,拿到的只是系统默认的50,50
 */
-(void)prepareLayout{
    [super prepareLayout];
    //设置secton的内边距,为了让第一个和最后一个cell显示在最中间
    CGFloat margin = (self.collectionView.frame.size.width - self.itemSize.width)*0.5;
    self.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
}
/**
 UICollectionViewLayout方法
 1. 通过这个方法返回所有的attributes,去展示cell
 2. 这个方法返回值是一个数组(数组里面存放着rect范围内所有元素的布局属性)
 3. 这个方法返回值决定了rect范围内所有元素的排布(frame)
 4. UICollectionViewLayoutAttributes-布局属性
    1. 一个cell就对应一个UICollectionViewLayoutAttributes对象
    2. UICollectionViewLayoutAttributes对象决定了cell的展示样式(frame等其他)
 5. 实现功能：cell的放大缩小
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //1. 获得super已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    //2. 在原有布局属性基础上,进行微调，设置缩放
    //思路:当cell的中心点x距离collectionView的中心线越来越近时应该放大,重合时最大,越来越远时应该缩小,注意这个距离是相对于contentsize的!!
    //2.1 计算collectionView最中心点的x值,注意是相对于contentsize的! 偏移量+宽度的一半
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    for (UICollectionViewLayoutAttributes *attri in array) {
        //每一个cell中心点的x,注意是相对于collectionView的contentsize的
//        NSLog(@"%f",attri.center.x );
        //2.2 拿到cell中心点x与cellectionview中心点的距离
        CGFloat delta = ABS(attri.center.x - centerX);
        //2.3 根据间距值计算出cell的缩放比例
        CGFloat scale = 1 - delta/self.collectionView.frame.size.width;
        attri.transform = CGAffineTransformMakeScale(scale, scale);
        NSLog(@"%f",delta);
    }
//    NSLog(@"%zd",array.count );
//    NSLog(@"%f",self.collectionView.frame.size.width );
    return array;
}

/**
 UICollectionViewLayout方法
 1. 实现功能：停止滚动时（不是最后一个cell时）,cell的居中
 2. 这个方法就决定了,collectionview停止滚动时的偏移量contentsize的offset(x,y)
 3. 换句话说,返回值point是啥,contenview就在哪地方停下来
 4. 注意,point是相对于contentsize而言的
 5. 调用时刻:手一松开就会调用,但是注意此时collectionView可能任然在滚动!
 6. 因此这几个参数
    1. proposedContentOffset:真正停止那一刻的偏移量
    2. self.collectionView.contentOffset.x:手停那一刻的偏移量
    2. 参数velocity:速度描述量,velocity.x水平方向上的速率,velocity.y竖直方向上的速率
    3. 注意:如果将下面的proposedContentOffset全部改为self.collectionView.contentOffset的话,结果是手一旦松开就回停止滚动,但是仍然会居中显示
 7. 思路:
    1.拿到哪个cell距离collectionView中心线最近距离
    2.改变这个contentView的偏移量即可
 */
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    //1.拿到所有cell的中心点x
    //用super,否者会调用上面的那个方法
    //注意这里要传的当然也是真正停止后矩形的x
    CGRect rect;
    rect.origin.x = proposedContentOffset.x;
    rect.origin.y = 0;
    rect.size = self.collectionView.frame.size;
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
   //计算collectionView最中心点的x值
   //self.collectionView.contentOffset.x此时就不能用这个了
   CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
   CGFloat mindelta = MAXFLOAT;
   for (UICollectionViewLayoutAttributes *attri in array) {
       if (ABS(mindelta) > ABS(attri.center.x - centerX)) {
           mindelta = attri.center.x - centerX;
       } ;
    }
   NSLog(@"%f-------%f=======%f",self.collectionView.contentOffset.x,velocity.x,proposedContentOffset.x);
    //2.修改contentView原有的偏移量
    proposedContentOffset.x += mindelta;
   return proposedContentOffset;
}
@end
