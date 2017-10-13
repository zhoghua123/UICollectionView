//
//  ViewController2.m
//  自定义布局的学习
//
//  Created by xyj on 2017/10/11.
//  Copyright © 2017年 xyj. All rights reserved.
//  将Main.sb中的Class改为这个类就可以看了!!!!
/*
 本次使用布局完全用自定义布局UICollectionViewLayout,不再继承自流水布局UICollectionViewFlowLayout
 */
#import "ZHDefineLayout.h"
#import "ZHCollectionViewCell.h"
#import "ViewController2.h"

@interface ViewController2 ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@end
static NSString *cellID = @"itemcell";
@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = self.view.bounds;
    ZHDefineLayout *layout = [[ZHDefineLayout alloc] init];
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    //只能注册
    [collection registerNib:[UINib nibWithNibName:@"ZHCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    collection.dataSource = self;
    collection.delegate = self;
    [self.view addSubview:collection];
    //自定义布局有两种方式:
    //1.继承自UICollectionViewLayout
    //2.继承自UICollectionViewFlowLayout
    //如果自定义当然选择第二种,因为第一种并不包含流水功能等各种属性
}
#pragma mark - UICollectionViewDataSource
//必须实现@required:
//每个section里面有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

//每个cell
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZHCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    item.imageName = [NSString stringWithFormat:@"%zd",indexPath.item+1];
    return item;
}
@end

