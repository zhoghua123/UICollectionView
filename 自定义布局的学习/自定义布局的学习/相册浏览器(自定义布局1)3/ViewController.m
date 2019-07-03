//
//  ViewController.m
//  自定义布局的学习
//
//  Created by xyj on 2017/10/9.
//  Copyright © 2017年 xyj. All rights reserved.
//
//自定义布局有两种方式:
//1.继承自UICollectionViewLayout
//2.继承自UICollectionViewFlowLayout
//如果自定义当然选择第二种,因为第一种并不包含流水功能等各种属性
#import "ZHCircleLayout.h"
#import "ViewController.h"
#import "ZHLineLayout.h"
#import "ZHDefineLayout.h"
#import "ZHCollectionViewCell.h"
#import "CollectionViewController2.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *imageArray;
@end
static NSString *cellID = @"itemcell";
@implementation ViewController
-(NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
        for (int i = 0 ;i<20; i++) {
            [_imageArray addObject:[NSString stringWithFormat:@"%d",i+1]];
        }
    }
    return _imageArray ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //1. 初始化自定义布局：ZHLineLayout
    CGFloat collectionWH = [UIScreen mainScreen].bounds.size.width;
    CGRect frame = CGRectMake(0, 200, collectionWH, 300);
    ZHLineLayout *layout = [[ZHLineLayout alloc] init];
    layout.itemSize = CGSizeMake(150, 150);//设置item的尺寸
    //水平滚动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //2. 初始化UICollectionView
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    //只能注册
//    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [collection registerNib:[UINib nibWithNibName:@"ZHCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    collection.dataSource = self;
    collection.delegate = self;
    [self.view addSubview:collection];
    self.collectionView = collection;
   
}
//布局间的切换
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    CollectionViewController2 *collectVC = [[CollectionViewController2 alloc] init];
//    [self presentViewController:collectVC animated:YES completion:nil];
    //看完自定义布局3之后在看下面这个!!切换布局
    if ([self.collectionView.collectionViewLayout isKindOfClass:[ZHLineLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[ZHCircleLayout alloc] init] animated:YES];
    }else if([self.collectionView.collectionViewLayout isKindOfClass:[ZHCircleLayout class]]) {
         [self.collectionView setCollectionViewLayout:[[ZHDefineLayout alloc] init] animated:YES];
    }
    else if([self.collectionView.collectionViewLayout isKindOfClass:[ZHDefineLayout class]]) {
        ZHLineLayout *layout = [[ZHLineLayout alloc] init];
        layout.itemSize = CGSizeMake(150, 150);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [self.collectionView setCollectionViewLayout:layout animated:YES];
    }
}

#pragma mark - UICollectionViewDataSource
//必须实现@required:
//每个section里面有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
}

//每个cell
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZHCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    item.imageName = self.imageArray[indexPath.item];
//    item.backgroundColor = [UIColor redColor];
    //没有该方法,只能使用注册(sb不需要写)
//    if (!item) {
//        item = [UICollectionViewCell alloc] init...
//    }
    //精辟!!!防止重复添加!!!!
//    NSInteger  tag = 10;
//    UILabel *label = (UILabel *)[item.contentView viewWithTag:tag];
//    if (!label) {
//        label = [[UILabel alloc] init];
//        label.tag = tag;
//        [item.contentView addSubview:label];
//    }
//    label.text = [NSString stringWithFormat:@"%zd",indexPath.item];
//    [label sizeToFit];
    return item;
}
#pragma mark - UICollectionViewDeletegate
//点击图片删除图片
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.imageArray removeObjectAtIndex:indexPath.item];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}
@end
