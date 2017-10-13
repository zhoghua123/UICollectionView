//
//  ViewController3.m
//  自定义布局的学习
//
//  Created by xyj on 2017/10/12.
//  Copyright © 2017年 xyj. All rights reserved.
//

/*
 实现瀑布流的3种方案
 1.view上面添加一个scrollView,接着在添加3列tableView,分别禁止tableView的滚动
 2.view上面添加一个scrollView,在一个一个往scrollView上面添加
 3.用uiconllectionView
 分析可得:瀑布流总是找最短的那个添加,因此不是流水布局,那么自定义布局就要继承自根布局
 
 */
#import "ZHWaterLayout.h"
#import "ViewController3.h"
#import "ZHShopViewCell.h"
#import "MJRefresh.h"
#import "XMGShop.h"
#import "MJExtension.h"
@interface ViewController3 ()<UICollectionViewDataSource,ZHWaterLayoutDelegate>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,weak) UICollectionView *collectionView;
@end
static NSString * const cellID = @"shopcell";

@implementation ViewController3
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLayout];
    [self setupRefresh];
}
-(void)setupRefresh{
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(newData)];
    [self.collectionView.header beginRefreshing];
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreData)];
    self.collectionView.footer.hidden = YES;
}
-(void)newData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *aray = [XMGShop objectArrayWithFilename:@"112.plist"];
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:aray];
        [self.collectionView reloadData];
        [self.collectionView.header endRefreshing];
    });
   
}
-(void)moreData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *aray = [XMGShop objectArrayWithFilename:@"112.plist"];
        [self.dataArray addObjectsFromArray:aray];
        [self.collectionView reloadData];
        [self.collectionView.footer endRefreshing];
    });
    
}
-(void)setupLayout{
    ZHWaterLayout *layout = [[ZHWaterLayout alloc] init];
    layout.delegate = self;
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    //只能注册
    [collection registerNib:[UINib nibWithNibName:@"ZHShopViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    collection.backgroundColor = [UIColor whiteColor];
    collection.dataSource = self;
    self.collectionView = collection;
    [self.view addSubview:collection];
}
#pragma mark - ZHWaterLayoutDelegate
-(CGFloat)waterLayout:(ZHWaterLayout *)waterLayout heightForItemAtIndex:(NSInteger )index andItemWidth:(CGFloat)itemWidth{
    XMGShop *shop = self.dataArray[index];
    return itemWidth * shop.h/shop.w;
}
-(NSInteger)columCountWaterLayout:(ZHWaterLayout *)waterLayout{
    return 4;
}
-(CGFloat)columMarginWaterLayout:(ZHWaterLayout *)waterLayout{
    return 10;
}
-(CGFloat)rowMarginWaterLayout:(ZHWaterLayout *)waterLayout{
    return 10;
}
-(UIEdgeInsets)edgeInsetsWaterLayout:(ZHWaterLayout *)waterLayout{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
#pragma mark - UICollectionViewDataSource
//必须实现@required:
//每个section里面有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    self.collectionView.footer.hidden = self.dataArray.count == 0;
    return self.dataArray.count;
}

//每个cell
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZHShopViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    item.shop = self.dataArray[indexPath.item];
    return item;
}
@end
