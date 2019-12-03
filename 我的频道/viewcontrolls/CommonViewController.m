//
//  CommonViewController.m
//  我的频道
//
//  Created by cctv-person on 2018/12/3.
//  Copyright © 2018 cctv-person. All rights reserved.
//

#import "CommonViewController.h"
#import "BaseCollectionViewCell.h"
#import "CollectionReusableView.h"
@interface CommonViewController ()<UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout>
@property (nonatomic , strong) NSArray *headerArr;
@property (nonatomic , strong) UICollectionView *collectionview;
@property (nonatomic , strong) NSMutableArray *selArr;//上层数组
@property (nonatomic , strong) NSMutableArray *unSelArr;//未选数组
@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _selArr = [[NSMutableArray alloc]initWithObjects:@"精选",@"爱看",@"电影",@"综艺",@"少儿",@"动漫",@"纪录片",@"新闻",nil];
    _unSelArr = [[NSMutableArray alloc]initWithObjects:@"美食",@"健康",@"情感",@"健身",@"宠物",@"家居",@"手绘",@"CBA",@"足球",@"美容",@"唱歌",@"教育",@"艺术",@"财经",nil];
    [self.view addSubview:self.collectionview];

    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  section == 0 ?_selArr.count:_unSelArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(100, 40);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    header.headLabel.text= self.headerArr[indexPath.section];
    return header;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        id obj = [_unSelArr objectAtIndex:indexPath.row];
        [_unSelArr removeObject:obj];
        [_selArr addObject:obj];
        [UIView animateWithDuration:0.3 animations:^{
            [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:self.selArr.count-1 inSection:0]];
        }];
    }else{
        id obj = [_selArr objectAtIndex:indexPath.row];
        [_selArr removeObject:obj];
        [_unSelArr insertObject:obj atIndex:0];
        [UIView animateWithDuration:0.3 animations:^{
            [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        }];
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuserCell" forIndexPath:indexPath];
    indexPath.section == 0 ?
    (cell.str= self.selArr[indexPath.row]):(cell.str = self.unSelArr[indexPath.row]);
    return cell;
}


- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSMutableDictionary *tempDict;
    if (sourceIndexPath.section == 0) {
         tempDict= _selArr[sourceIndexPath.item];
        _selArr = [_selArr mutableCopy];
        [_selArr removeObjectAtIndex:sourceIndexPath.item];
    }else{
        tempDict = _unSelArr[sourceIndexPath.item];
        _unSelArr = [_unSelArr mutableCopy];
        [_unSelArr removeObjectAtIndex:sourceIndexPath.item];
    }
    if (destinationIndexPath.section == 0) {
        [_selArr insertObject:tempDict atIndex:destinationIndexPath.item];
    }else{
        [_unSelArr insertObject:tempDict atIndex:destinationIndexPath.item];
    }
}
- (UICollectionView *)collectionview{
    if (!_collectionview) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(70, 40);
        _collectionview = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionview.backgroundColor = UIColor.whiteColor;
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        [_collectionview registerClass:[BaseCollectionViewCell class] forCellWithReuseIdentifier:@"reuserCell"];
        [_collectionview registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
        UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [_collectionview addGestureRecognizer:longPressGes];
    }
    return _collectionview;
}
- (void)longPress:(UILongPressGestureRecognizer *)ges{
    switch (ges.state) {
        case UIGestureRecognizerStateBegan:
        {
            NSIndexPath *indexpath = [self.collectionview indexPathForItemAtPoint:[ges locationInView:self.collectionview]];
            if (indexpath == nil) {
                return;
            }
            [self.collectionview beginInteractiveMovementForItemAtIndexPath:indexpath];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.collectionview updateInteractiveMovementTargetPosition:[ges locationInView:self.collectionview]];
        }
            break;
        case UIGestureRecognizerStateEnded:{
            [self.collectionview endInteractiveMovement];
        }
        default:
            [self.collectionview cancelInteractiveMovement];
            break;
    }
}
- (NSArray *)headerArr{
    if (!_headerArr) {
        _headerArr = @[@"我的频道",@"推荐"];
    }
    return _headerArr;
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
