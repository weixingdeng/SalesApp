//
//  EHIChatMemberViewController.m
//  MobileSales
//
//  Created by dengwx on 2017/2/20.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatMemberViewController.h"
#import "EHIMemberCollectionViewCell.h"
#import "EHIContactModel.h"

@interface EHIChatMemberViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation EHIChatMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"讨论组成员";
    
    EHIContactModel *selfModel = [[EHIContactModel alloc] init];
    selfModel.UserName = SHARE_USER_CONTEXT.user.user_name;
    
    if (self.memberArray) {
        [self.memberArray insertObject:selfModel atIndex:0];
    }
    [self loadCollectionView];
}

- (void)loadCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // 定义大小
    layout.itemSize = CGSizeMake(autoWidthOf6(45), autoHeightOf6(60));
    // 设置最小行间距
    layout.minimumLineSpacing = autoHeightOf6(18);
    // 设置垂直间距
    layout.minimumInteritemSpacing = autoWidthOf6(32);
    
    layout.sectionInset = UIEdgeInsetsMake(autoHeightOf6(18), autoWidthOf6(24), autoHeightOf6(18), autoWidthOf6(24));
    // 设置水平滚动方向（默认垂直滚动）
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *_collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    
    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerClass:[EHIMemberCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.memberArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EHIContactModel *model = self.memberArray[indexPath.row];
    
    EHIMemberCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.name = model.UserName;
    cell.isBoy = YES;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
