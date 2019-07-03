//
//  ZHMenuViewController.m
//  自定义布局的学习
//
//  Created by mac on 2019/7/3.
//  Copyright © 2019 xyj. All rights reserved.
//

#import "ZHMenuViewController.h"
#import "ZHCollectionFootVeiw.h"
#import "ZHCollectionHeaderView.h"
@interface ZHMenuViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,weak) UICollectionView *collectionView;
@end
static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseIdentifierHeader = @"header";
static NSString * const reuseIdentifierFooter = @"footer";
@implementation ZHMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    //1. 初始化整体布局
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//
    //2. 初始化UICollectionView
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:UIScreen.mainScreen.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    collection.dataSource = self;
    collection.delegate = self;
    [self.view addSubview:collection];
    self.collectionView = collection;
    self.collectionView.backgroundColor = UIColor.whiteColor;
    
    //3. 注册cell、header、footer
    //注册cell
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //ZHCollectionHeaderView、ZHCollectionFootVeiw继承自UICollectionReusableView
    //注册header
    [self.collectionView registerClass:[ZHCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader];
    //注册footer
    [self.collectionView registerClass:[ZHCollectionFootVeiw class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierFooter];
}

#pragma mark - UICollectionViewDataSource

//多少section
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
//每个section多少items
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

//每个item样式
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColor.redColor;
    return cell;
}


//每个header、footer实现
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) { //header
        ZHCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader forIndexPath:indexPath];
        headerView.backgroundColor =UIColor.yellowColor;
        return headerView;
    }else{//footer
        ZHCollectionFootVeiw *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierFooter forIndexPath:indexPath];
        footerView.backgroundColor = UIColor.blueColor;
        return footerView;
    }
}
//是否允许移动 ios9.0
//- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
//
//}
//移动item ios9.0
//- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath NS_AVAILABLE_IOS(9_0){
//
//}

//详细设置布局
#pragma mark - UICollectionViewDelegateFlowLayout
//详细设置每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(70, 70);
}
//详细设置每个section的内边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 15, 0, 15);
}
//详细设置每个cell中cell的行距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}
//详细设置每个section中cell的列距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 50;
}
//详细设置每个secton的header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section%2) {
        return CGSizeMake(60, 60);
    }else{
        return CGSizeMake(100, 100);
    }
}
//详细设置每个section的footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section%2) {
        return CGSizeMake(60, 60);
    }else{
        return CGSizeMake(100, 100);
    }
}
#pragma mark - UICollectionViewDeletegate

// 允许选中时，高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}

// 高亮完成后回调
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    //设置高亮背景色
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
}

// 由高亮转成非高亮完成时的回调
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    //高亮消失时还原背景色
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
}

// 设置是否允许选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}

// 设置是否允许取消选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}
//选中操作
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s", __FUNCTION__);
}
// 取消选中操作
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
}

/**
 移动item从originalIndexPath到proposedIndexPath
 */
//- (NSIndexPath *)collectionView:(UICollectionView *)collectionView targetIndexPathForMoveFromItemAtIndexPath:(NSIndexPath *)originalIndexPath toProposedIndexPath:(NSIndexPath *)proposedIndexPath {
//
//    return proposedIndexPath;
//}
//
//- (CGPoint)collectionView:(UICollectionView *)collectionView targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset {
//
//    return proposedContentOffset;
//}
@end
