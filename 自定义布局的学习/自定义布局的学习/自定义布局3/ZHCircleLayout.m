//
//  ZHCircleLayout.m
//  自定义布局的学习
//
//  Created by xyj on 2017/10/11.
//  Copyright © 2017年 xyj. All rights reserved.
//
//注意:这里不需要滚动,因此不用重写:-(CGSize)collectionViewContentSize
#import "ZHCircleLayout.h"
@interface ZHCircleLayout()
@property (nonatomic,strong) NSMutableArray *attriArray;
@end
@implementation ZHCircleLayout
-(NSMutableArray *)attriArray{
    if (_attriArray == nil) {
        _attriArray = [NSMutableArray array];
    }
    return _attriArray ;
}
-(void)prepareLayout{
    [super prepareLayout];
    //计算出所有cell的UICollectionViewLayoutAttributes
    [self.attriArray removeAllObjects];
    //那一组多少个
    NSInteger rowcount = [self.collectionView numberOfItemsInSection:0];
    //假设分布在半径100的圆上
    CGFloat radus = 100;
    //圆心的x,y
    CGFloat ocenterx = self.collectionView.frame.size.width * 0.5;
    CGFloat ocentery = self.collectionView.frame.size.height * 0.5;
    
    for (int i = 0 ; i<rowcount; i++) {
        //创建UICollectionViewLayoutAttributes
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexpath];
        //设置布局属性(将图片布局到一个圆上:只要center再一个圆上即可)
        if (rowcount == 1) {
            //只有一个
            attri.center = CGPointMake(ocenterx,ocentery);
            attri.size = CGSizeMake(150, 150);
        }else{
            //多个
            //每个图片的的夹角为
            CGFloat jiao = 2*M_PI/rowcount * i;
            attri.size = CGSizeMake(50, 50);
            CGFloat centerx = ocenterx + radus * sin(jiao);
            CGFloat centery = ocentery + radus * cos(jiao);
            attri.center = CGPointMake(centerx, centery);
            //每个图片旋转相应的度数
            attri.transform = CGAffineTransformMakeRotation(jiao);
        }
        
        //添加UICollectionViewLayoutAttributes到数组中
        [self.attriArray addObject:attri];
    }
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attriArray;
}
/**
 返回每一个cell的布局属性
 要是切换布局的话这个方法必须实现,否则报错
 不切换可以不实现
 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.attriArray[indexPath.item];
}
@end
