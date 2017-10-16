//
//  CollectionViewController.m
//  自定义布局的学习
//
//  Created by xyj on 2017/10/9.
//  Copyright © 2017年 xyj. All rights reserved.
//  UICollection的基本使用-启动页制作
#import "ViewController.h"
#import "CollectionViewController.h"
@interface CollectionViewController ()
@end

@implementation CollectionViewController
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    //可以看到self.view != self.collectionView
    self.view.backgroundColor = [UIColor redColor];
    self.collectionView.backgroundColor = [UIColor greenColor];
    //取消弹簧效果
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    //1.必须通过注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}
//2.重写init方法,传值layout
// 初始化的时候必须设置布局参数，通常使用系统提供的流水布局UICollectionViewFlowLayout
-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置滚动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置cell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    // 设置cell之间间距
    layout.minimumInteritemSpacing = 0;
    // 设置行距
    layout.minimumLineSpacing = 0;
    // 设置每一组的内间距
    //    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    return [super initWithCollectionViewLayout:layout];
}
//3.实现代理数据源方法
#pragma mark <UICollectionViewDataSource>
//返回多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//每组多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;;
}
//返回展示的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //自定义cell,在cell里面放一张图片即可(略)
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell.contentView addSubview:[UISwitch new]];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}
#pragma mark <UICollectionViewDelegate>
//点击最后一张时替换掉keyWindow的rootViewcontroller
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 3) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        UIViewController *VC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
        keyWindow.rootViewController = VC;
    }
}
//在这里检测到,一旦替换掉,当前控制器就会被销毁
-(void)dealloc{
    NSLog(@"对象已经销毁");
}
@end
