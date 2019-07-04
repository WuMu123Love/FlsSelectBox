//
//  FLSFiltrateView.m
//  FlsSelectBox
//
//  Created by fls on 2019/5/5.
//  Copyright © 2019年 fls. All rights reserved.
//

#import "FLSFiltrateView.h"
#import "RHCollectionViewFlowLayout.h"
#import "FLSFiltrateCell.h"
#import "RHHelper.h"
#import "NSBundle+FLSubBundle.h"


#define MarginX      10    //item X间隔
#define MarginY      15    //item Y间隔
#define ItemHeight   30    //item 高度
#define ItemWidth    30    //item 追加宽度
#define Label_W 40
#define Cell_Filtrate @"FLSFiltrateCell"

@interface FLSFiltrateView()<UICollectionViewDelegate, UICollectionViewDataSource, RHCollectionViewDelegateFlowLayout>
@property(nonatomic,strong) NSMutableArray  *  collectionViews ;
@property(nonatomic,strong) NSMutableArray  *  titles ;
@property(nonatomic,strong) NSMutableArray  *  imageViews ;
@property(nonatomic,strong) NSMutableArray * dataArray;
@property(nonatomic,assign) NSInteger secTag ;
@property(nonatomic,strong) NSIndexPath * secIndecPath;
@property(nonatomic,strong) NSMutableArray  * secModelArray ;

@end

@implementation FLSFiltrateView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self createUI];
    }
    return self;
}


- (void)createUI{
    CGFloat view_H = self.bounds.size.height - 20;
    CGFloat view_W = self.bounds.size.width;
    NSInteger arr_count = self.titleArray.count;
    
    if (arr_count > 0) {
        for (int i = 0; i < arr_count; i ++) {
            CGFloat x = 0;
            CGFloat y = view_H*i/arr_count;
            CGFloat H = view_H/arr_count;
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x + MarginX,y+MarginX , H - 2*MarginX, H - 2*MarginX)];
            imageView.tag = 1000 + i;
            imageView.backgroundColor =[UIColor redColor];
            UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(x + H, y+MarginX, H - 2*MarginX, Label_W)];
            titleLable.backgroundColor = [UIColor yellowColor];
            titleLable.textAlignment = NSTextAlignmentCenter;
            titleLable.text = self.titleArray[i];
            titleLable.tag = 2000+ i;
//            RHCollectionViewFlowLayout * flowLayout = [[RHCollectionViewFlowLayout alloc] init];
            UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
                    flowLayout.minimumLineSpacing = MarginY;
                    flowLayout.minimumInteritemSpacing = MarginX;
                    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//                    flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 15, 15);
                UICollectionView * collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(x + H + Label_W+ MarginX, y+MarginX, view_W - (x + H + 2*MarginX+Label_W), H - 2*MarginX) collectionViewLayout:flowLayout];
                    collectionview.backgroundColor = [UIColor whiteColor];
                    collectionview.dataSource = self;
                    collectionview.delegate = self;
                    collectionview.tag = 3000+i;
                    collectionview.showsVerticalScrollIndicator = NO;
                    collectionview.showsHorizontalScrollIndicator = NO;
//                    [collectionview registerClass:[FLSFiltrateCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%@%d",Cell_Filtrate,@"view",i]];
            
            NSBundle * bundle = [NSBundle FLS_subBundleWithBundleName:@"FlsSelectBox" targetClass:[self class]];
            
            UINib * nib = [UINib nibWithNibName:@"FLSFiltrateCell" bundle:bundle];
            
            [collectionview registerNib:nib forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%@%d",Cell_Filtrate,@"view",i]];

            [self addSubview:imageView];
            [self addSubview:titleLable];
            [self addSubview:collectionview];
            [self.imageViews addObject:imageView];
            [self.titles addObject:titleLable];
            [self.collectionViews addObject:collectionview];
        }
    }
    
}



#pragma mark - collectionView delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger tag = collectionView.tag - 3000;
    NSArray * sectionDataArray = self.dataArray[tag];
    return sectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger tag = collectionView.tag - 3000;

    FLSFiltrateCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%@%ld",Cell_Filtrate,@"view",tag] forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.selected = YES;
        [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:0];
    }
    NSArray * sectionDataArray = self.dataArray[tag];
    cell.model = sectionDataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    FLSFiltrateCell * cell = (FLSFiltrateCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = NO;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    FLSFiltrateCell * cell = (FLSFiltrateCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
    
        NSInteger tag = collectionView.tag - 3000;

    if (tag  < self.collectionViews.count ) {
        NSDictionary * secTagAndRow1  = @{@"tag":[NSString stringWithFormat:@"%ld",tag],
                                          @"row":[NSString stringWithFormat:@"%ld",indexPath.row]
                                          };
        [self.secModelArray replaceObjectAtIndex:tag withObject:secTagAndRow1];
        if ((tag +1) < self.collectionViews.count) {
            NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:0];
            for (NSInteger j = tag+1; j < self.collectionViews.count; j++) {
                UICollectionView * collec = self.collectionViews[j];
                [collec selectItemAtIndexPath:index animated:YES scrollPosition:UICollectionViewScrollPositionNone];
                FLSFiltrateCell * cell = (FLSFiltrateCell *)[collec cellForItemAtIndexPath:index];
                cell.selected = YES;
                NSDictionary * secTagAndRow2  = @{@"tag":[NSString stringWithFormat:@"%ld",j],
                                                  @"row":[NSString stringWithFormat:@"%ld",index.row]
                                                  };
                [self.secModelArray replaceObjectAtIndex:j  withObject:secTagAndRow2];

            }

        }

    }


//    if (tag == 0) {
//        NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:0];
//        UICollectionView * collec1 = self.collectionViews[1];
//        UICollectionView * collec2 = self.collectionViews[2];
//        [collec1 selectItemAtIndexPath:index animated:YES scrollPosition:UICollectionViewScrollPositionNone];
//        [collec2 selectItemAtIndexPath:index animated:YES scrollPosition:UICollectionViewScrollPositionNone];
//        FLSFiltrateCell * cell1 = (FLSFiltrateCell *)[collec1 cellForItemAtIndexPath:index];
//        FLSFiltrateCell * cell2 = (FLSFiltrateCell *)[collec2 cellForItemAtIndexPath:index];
//        cell1.selected = YES;
//        cell2.selected = YES;
//
//        NSDictionary * secTagAndRow1  = @{@"tag":[NSString stringWithFormat:@"%ld",tag],
//                                         @"row":[NSString stringWithFormat:@"%ld",indexPath.row]
//                                         };
//        NSDictionary * secTagAndRow2  = @{@"tag":[NSString stringWithFormat:@"%ld",tag+1],
//                                          @"row":[NSString stringWithFormat:@"%ld",index.row]
//                                          };
//        NSDictionary * secTagAndRow3  = @{@"tag":[NSString stringWithFormat:@"%ld",tag+2],
//                                          @"row":[NSString stringWithFormat:@"%ld",index.row]
//                                          };
//        [self.secModelArray replaceObjectAtIndex:0 withObject:secTagAndRow1];
//        [self.secModelArray replaceObjectAtIndex:1 withObject:secTagAndRow2];
//        [self.secModelArray replaceObjectAtIndex:2 withObject:secTagAndRow3];
//
//    }else if (tag == 1){
//        NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:0];
//        UICollectionView * collec2 = self.collectionViews[2];
//        FLSFiltrateCell * cell2 = (FLSFiltrateCell *)[collec2 cellForItemAtIndexPath:index];
//        [collec2 selectItemAtIndexPath:index animated:YES scrollPosition:UICollectionViewScrollPositionNone];
//        cell2.selected = YES;
//        NSDictionary * secTagAndRow2  = @{@"tag":[NSString stringWithFormat:@"%ld",tag],
//                                          @"row":[NSString stringWithFormat:@"%ld",indexPath.row]
//                                          };
//        NSDictionary * secTagAndRow3  = @{@"tag":[NSString stringWithFormat:@"%ld",tag+1],
//                                          @"row":[NSString stringWithFormat:@"%ld",index.row]
//                                          };
//        [self.secModelArray replaceObjectAtIndex:1 withObject:secTagAndRow2];
//        [self.secModelArray replaceObjectAtIndex:2 withObject:secTagAndRow3];
//
//
//    }else if (tag == 2){
//
//        NSDictionary * secTagAndRow3  = @{@"tag":[NSString stringWithFormat:@"%ld",tag],
//                                          @"row":[NSString stringWithFormat:@"%ld",indexPath.row]
//                                          };
//
//        [self.secModelArray replaceObjectAtIndex:2 withObject:secTagAndRow3];
//
//    }
    if (self.backSelectItemArray) {
        self.backSelectItemArray(self.secModelArray);
    }


}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger tag = collectionView.tag - 3000;
    NSArray * sectionDataArray = self.dataArray[tag];
    NSDictionary * model = sectionDataArray[indexPath.row];
    float width = [RHHelper getWidthByText:model[@"title"] font:[UIFont systemFontOfSize:15]] + ItemWidth;
    return CGSizeMake(width, 40);
}

#pragma mark - setter and getter

- (NSMutableArray *)collectionViews{
    if (!_collectionViews) {
        _collectionViews = [NSMutableArray arrayWithCapacity:0];
    }
    return _collectionViews;
}
- (NSMutableArray *)titles{
    if (!_titles) {
        _titles = [NSMutableArray arrayWithCapacity:0];
    }
    return _titles;
}
- (NSMutableArray *)imageViews{
    if (!_imageViews) {
        _imageViews = [NSMutableArray arrayWithCapacity:0];
    }
    return _imageViews;
}
- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    [self createUI];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithArray:@[@[@{@"title":@"英语启蒙",@"select":@"0"},@{@"title":@"英语进阶",@"select":@"0"},@{@"title":@"英语儿童",@"select":@"0"}],
                                                             @[@{@"title":@"LEvel1",@"select":@"0"},@{@"title":@"LEvel2",@"select":@"0"},@{@"title":@"LEvel3",@"select":@"0"},@{@"title":@"LEvel4",@"select":@"0"},@{@"title":@"LEvel5",@"select":@"0"},@{@"title":@"LEvel6",@"select":@"0"}],
                                                             @[@{@"title":@"磨耳朵",@"select":@"0"},@{@"title":@"l牛津树",@"select":@"0"}],@[@{@"title":@"LEvel1",@"select":@"0"},@{@"title":@"LEvel2",@"select":@"0"},@{@"title":@"LEvel3",@"select":@"0"},@{@"title":@"LEvel4",@"select":@"0"},@{@"title":@"LEvel5",@"select":@"0"},@{@"title":@"LEvel6",@"select":@"0"}]]];
    }
    return _dataArray;
}

- (NSMutableArray *)secModelArray{
    if (!_secModelArray) {
        _secModelArray = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0 ; i < self.titles.count; i ++) {
            [_secModelArray addObject:@{@"tag":[NSString stringWithFormat:@"%d",i],
                                        @"row":@"0"
                                        }];
        }
    }
    return _secModelArray;
}


@end
