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
#import "ZHCollectionSectionModel.h"
//#define citemWH 50   //通用item宽高
#define columMargn  15  //限定每列的间距
#define ccolumns 4   //通用每行4个
//#define fitemWH 25  //第一区item宽高
#define fcolumns 7  //第一区每行7个
#define sectionInset 15 //每个section的内缩
#define rowMargn 15  //行间距

#define sectionHeaderWH 60 //header高度
#define sectionFooterWH 15  //footer高度
@interface ZHMenuViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *sectionArray;
@property (nonatomic, assign) BOOL isLineFirst;
@end
static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseIdentifierHeader = @"header";
static NSString * const reuseIdentifierFooter = @"footer";
@implementation ZHMenuViewController
- (NSMutableArray *)sectionArray{
    if (!_sectionArray) {
        _sectionArray = [ZHCollectionSectionModel getSectionDataArray];
    }
    return _sectionArray ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    //1. 初始化整体布局
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
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(ZHCollectionHeaderView.class) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader];
    //注册footer
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierFooter];
    self.isLineFirst = YES;
    
    self.navigationItem.title = @"全部功能";
    self.navigationItem.rightBarButtonItem = [self createBarButtonItemWithTag:111];
    self.navigationItem.leftBarButtonItem = [self createBarButtonItemWithTag:-111];
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    self.navigationItem.rightBarButtonItem.customView.hidden = YES;
}


#pragma mark - defineMethod
/*********列间距一定，尺寸变化**********/
-(CGSize)getCommentSize{
    CGFloat wh = 0;
    CGFloat ww = UIScreen.mainScreen.bounds.size.width;
    wh = (ww - (ccolumns +1)*columMargn)*1.0 /ccolumns;
    return CGSizeMake(wh, wh);
}

-(CGSize)getFirstSize{
    CGFloat wh = 0;
    CGFloat ww = UIScreen.mainScreen.bounds.size.width;
    wh = (ww - (fcolumns +1)*columMargn)*1.0 /fcolumns;
    return CGSizeMake(wh, wh);
}

/*********尺寸一定，列距变化**********/
////获取每个item的布局
////每行4个，宽度50*50
////通用列距
//-(CGFloat)getCommentColumn{
//    CGFloat clum = 0;
//    CGFloat ww = UIScreen.mainScreen.bounds.size.width;
//    clum = (ww - ccolumns * citemWH)*1.0/(ccolumns+1);
//    return clum;
//}
////当非编辑状态时第一列的数据
//-(CGFloat)getFirstColumn{
//    CGFloat clum = 0;
//    CGFloat ww = UIScreen.mainScreen.bounds.size.width;
//    clum = (ww - fcolumns * fitemWH)*1.0/(fcolumns+1);
//    return clum;
//}
//点击编辑，改变当前布局
-(void)changeLayout{
    self.navigationItem.leftBarButtonItem.customView.hidden = NO;
    self.navigationItem.rightBarButtonItem.customView.hidden = NO;
    self.isLineFirst = NO;
    ZHCollectionSectionModel *model = self.sectionArray.firstObject;
    model.isSubtitle = YES;
    model.isRightBtn = NO;
    self.navigationItem.title = @"编辑首页功能";
    [self.collectionView reloadData];
}

/**
 //创建item
 @param tag -111 左边  111右边
 @return item
 */
-(UIBarButtonItem *)createBarButtonItemWithTag:(NSInteger )tag{
    NSString *bttitle = @"完成";
    if (tag== -111) {
        bttitle = @"取消";
    }
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 70, 44);
    NSAttributedString * title = [[NSAttributedString alloc] initWithString:bttitle attributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:16]}];
    [rightButton setAttributedTitle:title forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(itemBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.tag = tag;
    return [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

-(void)itemBtnAction:(UIButton *)btn{
    self.isLineFirst = YES;
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    self.navigationItem.rightBarButtonItem.customView.hidden = YES;
    ZHCollectionSectionModel *model = self.sectionArray.firstObject;
    model.isSubtitle = NO;
    model.isRightBtn = YES;
    self.navigationItem.title = @"全部功能";
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

//多少section
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.sectionArray.count;
}
//每个section多少items
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 7;
    }else{
        return 10;
    }
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
        headerView.model = self.sectionArray[indexPath.section];
        __weak __typeof(&*self) weakSelf = self;
        headerView.selectAction = ^(BOOL isselect) {
            [weakSelf changeLayout];
        };
        return headerView;
    }else{//footer
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierFooter forIndexPath:indexPath];
        footerView.backgroundColor = UIColor.grayColor;
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
    if (indexPath.section == 0) {
        if (self.isLineFirst) {
            return [self getFirstSize];
//            return CGSizeMake(fitemWH, fitemWH);
        }else{
            return [self getCommentSize];
//          return CGSizeMake(citemWH, citemWH);
        }
    }else{
        return [self getCommentSize];
//        return CGSizeMake(citemWH, citemWH);
    }
}
//详细设置每个section的内边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        if (self.isLineFirst) {
            return UIEdgeInsetsMake(sectionInset,columMargn, sectionInset,columMargn);
//            return UIEdgeInsetsMake(sectionInset,[self getFirstColumn], sectionInset,[self getFirstColumn]);
        }else{
            return UIEdgeInsetsMake(sectionInset,columMargn, sectionInset,columMargn);
//            return UIEdgeInsetsMake(sectionInset,[self getCommentColumn], sectionInset,[self getCommentColumn]);
        }
    }else{
        return UIEdgeInsetsMake(sectionInset,columMargn, sectionInset,columMargn);
//        return UIEdgeInsetsMake(sectionInset,[self getCommentColumn], sectionInset,[self getCommentColumn]);
    }
}
//详细设置每个cell中cell的行距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return rowMargn;
}
//详细设置每个section中cell的列距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        if (self.isLineFirst) {
            return columMargn;
//            return [self getFirstColumn];
        }else{
            return columMargn;
//            return [self getCommentColumn];
        }
    }else{
        return columMargn;
//        return [self getCommentColumn];
    }
}
//详细设置每个secton的header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(sectionHeaderWH, sectionHeaderWH);
}
//详细设置每个section的footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(1, sectionFooterWH);
    }else{
        return CGSizeMake(0, 0);
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
