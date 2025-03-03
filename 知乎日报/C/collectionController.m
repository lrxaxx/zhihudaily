//
//  collectionController.m
//  知乎日报
//
//  Created by 李睿鑫 on 2024/11/18.
//

#import "collectionController.h"

@interface collectionController ()

@end

@implementation collectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"doc = %@", doc);
    NSString* fileName = [doc stringByAppendingPathComponent:@"zhihuDaily.sqlite"];
    _dataBase = [FMDatabase databaseWithPath:fileName];
    
    self.title = @"我的收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _arrID = [NSMutableArray array];
    _arrWebAPI = [NSMutableArray array];
    _arrImageURL = [NSMutableArray array];
    _arrHeadingTitle = [NSMutableArray array];
    _arrImage = [NSMutableArray array];
    
    [self fetchAllData];
    NSLog(@"%@", _arrID);
    NSLog(@"%@", _arrWebAPI);
    NSLog(@"%@", _arrHeadingTitle);
    [self loadImages111];
}

- (void)fetchAllData {
    // 打开数据库
    if ([_dataBase open]) {
        // 执行查询，获取所有数据
        FMResultSet *resultSet = [_dataBase executeQuery:@"SELECT * FROM collectionData"];
        
        // 遍历查询结果
        while ([resultSet next]) {
            NSString *mainHeading = [resultSet stringForColumn:@"mainHeading"];
            NSString *webAPI = [resultSet stringForColumn:@"webAPI"];
            NSString *imageURL = [resultSet stringForColumn:@"imageURL"];
            NSString *newsID = [resultSet stringForColumn:@"newsID"];
            
            [self.arrImageURL addObject:imageURL];
            [self.arrID addObject:newsID];
            [self.arrHeadingTitle addObject:mainHeading];
            [self.arrWebAPI addObject:webAPI];
            
        }
        
        // 关闭结果集
        [resultSet close];
        
        // 关闭数据库
        [_dataBase close];
    } else {
        NSLog(@"无法打开数据库");
    }
}

- (void)loadImages111 {
    // 使用 dispatch_group 来等待所有图片加载完成
    NSLog(@"_arrImageURL = %@", _arrImageURL);
    dispatch_group_t imageLoadGroup = dispatch_group_create();
    NSMutableArray* arrimage = [NSMutableArray array];
    for (NSString *arr in self->_arrImageURL) {
        NSURL *imageurl = [NSURL URLWithString:arr];
        UIImageView *iview = [[UIImageView alloc] init];
        dispatch_group_enter(imageLoadGroup); // 进入组
        
        [iview sd_setImageWithURL:imageurl
                placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                         options:SDWebImageRefreshCached
                       completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                NSLog(@"加载图片失败: %@", error.localizedDescription);
            } else {
                NSLog(@"图片加载成功");
            }
            dispatch_group_leave(imageLoadGroup); // 离开组
        }];
        
        [arrimage addObject:iview];
    }
    self->_arrImage = [arrimage mutableCopy];
    // 在所有图片加载完成后设置主视图
    dispatch_group_notify(imageLoadGroup, dispatch_get_main_queue(), ^{
        [self settingTableview];// 设置主视图
    });
}

-(void) settingTableview {
    _myView = [[collectionView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_myView];
    [_myView InitTableView];
    _myView.tableView.delegate = self;
    _myView.tableView.dataSource = self;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrID.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    collectionCell* cell = [_myView.tableView cellForRowAtIndexPath:indexPath];
    if(!cell) {
        cell = [[collectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"collectionCell"];
    }
    cell.mainTitle.text = _arrHeadingTitle[indexPath.row];
    UIImageView* iView = _arrImage[indexPath.row];
    cell.image.image = iView.image;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TopDetailsController* deatails = [[TopDetailsController alloc] init];
    deatails.count = _arrID.count;
    deatails.countNow = indexPath.row;
    deatails.strid = _arrID;
    deatails.strurl = _arrWebAPI;
    deatails.strTitle = _arrHeadingTitle;
    deatails.strImageURL = _arrImageURL;
    [self.navigationController pushViewController:deatails animated:YES];
}
@end
