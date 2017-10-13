# UICollectionView
UICollectionView的详细使用
1. tableView与collectionView比较 <br>
相同点:
1>.都是通过datasource和delegate驱动的(datasource和delegate)，因此在使用的时候必须实现数据源与代理协议方法;
2>.性能上都实现了循环利用的优化。
不同点:
1>.UITableView的cell是系统自动布局好的，不需要我们布局。但UICollectionView的cell是需要我们自己布局的。所以我们在创建UICollectionView的时候必须传递一个布局参数，系统提供并实现了一个布局样式：流水布局(UICollectionViewFlowLayout)
2>UITableViewController的self.view == self.tableview;,但UICollectionViewController的self.view != self.collectionView；
UICollectionViewController层次结构：控制器View 上面UICollectionView
3>UITableView的滚动方式只能是垂直方向， UICollectionView既可以垂直滚动，也可以水平滚动；
4>UICollectionView的cell只能通过注册来确定重用标识符。不能像tableViewcell一样initWith...
5>并不能直接设置cell的高度/section之间距离的数据源方法,只能通过设置layout来实现
结论: 换句话说，UITableView的布局是UICollectionView的flow layout布局的一种特殊情况，类比于同矩形与正方形的关系
代码举例:
UICollectionView *collection = [[UICollectionView alloc] init];
collection.frame = frame;
[self.view addSubview:collection];
运行报错:
reason: 'UICollectionView must be initialized with a non-nil layout parameter
意思:collctionView初始化时必须要传一个非空布局(layout)参数(parameter)
因此初始化方法如下:
UICollectionView *collection = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
2.UICollectionViewFlowLayout
系统自定义布局,流水布局,即:像流水一样一行满了,排下一行
UICollectionViewLayout的子类
CollectionViewcell排布的样式是由UICollectionViewLayout决定的
该类常用属性如下:
minimumLineSpacing  设置最小行间距
minimumInteritemSpacing 设置垂直间距
解析为何min ?
情况1:
同一行有不同的size的cell.由于高度不同,那么最小行间距就是本行最高的cell距离下一行最高cell的间距
同理,同一列有不同size的cell,由于宽度不同,那么最大列间距就是本列最宽cell距离下一列最宽cell的间距
￼
情况2:
cell的itemsize已经设置固定,行间距再固定,那么界面排版就冲突,因此设置最小间距
￼
//每个cell统一尺寸
itemSize cell的尺寸
//预估cell的尺寸，ios8之后可以先去预估cell的尺寸，然后去自适应(与tableView相似)
estimatedItemSize
//一行代码足以,不需要向tableView2行代码
layout.estimatedItemSize = CGSizeMake( 60, 60);
scrollDirection 设置滚动方向（默认垂直滚动）
//每一组头视图的尺寸。如果是垂直方向滑动，则只有高起作用；如果是水平方向滑动，则只有宽起作用。
headerReferenceSize
//每一组尾部视图的尺寸。如果是垂直方向滑动，则只有高起作用；如果是水平方向滑动，则只有宽起作用。
footerReferenceSize
//每一组的内容缩进
sectionInset


