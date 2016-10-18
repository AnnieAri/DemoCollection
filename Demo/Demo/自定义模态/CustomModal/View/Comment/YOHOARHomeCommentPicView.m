//
//  YOHOARHomeCommentPicView.m
//  YOHOMars
//
//  Created by Ari on 16/9/24.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YOHOARHomeCommentPicView.h"

@interface YOHOARHomeCommentPicViewCell :UICollectionViewCell
@property (nonatomic,copy) NSString *url;
@property (nonatomic,weak) UIImageView *imageView;
@end
@implementation YOHOARHomeCommentPicViewCell

-(void)setUrl:(NSString *)url {
    _url = url;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"sutroMetal"]];
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}


@end
static NSString *const collectionCellid = @"cellID";
@interface YOHOARHomeCommentPicView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,weak) UILabel *label;
@property (nonatomic,weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,weak) UICollectionView *collectionView;
@end
@implementation YOHOARHomeCommentPicView
- (void)setModel:(YOHOARHomeCommentModel *)model {
    _model = model;
    self.pics = model.img;
    [self caculLayoutWithImgCount:self.pics.count];
    [self reloadData];
}
//- (void)setPics:(NSArray<YOHOARHomeCommentPicModel *> *)pics{
//    _pics = pics;
//    
//}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.flowLayout = (UICollectionViewFlowLayout *)layout;
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    self.backgroundColor = [UIColor clearColor];
    self.delegate = self;
    self.dataSource = self;
    //注册cell
    [self registerClass:[YOHOARHomeCommentPicViewCell class] forCellWithReuseIdentifier:collectionCellid];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
}
#pragma mark - 计算layout
- (void)caculLayoutWithImgCount:(NSInteger)count {
    CGFloat side;
    if (count != 0) {
        if (count == 1){
            side = self.bounds.size.width - 1;
        }else if (count == 2){
            side = (self.bounds.size.width - 10) / 2;
        }else if (count == 4){
            side = (self.bounds.size.width - 10) / 2;
        }else {
            side = (self.bounds.size.width - (2*10)) / 3;
        }
    }
    self.flowLayout.itemSize = CGSizeMake(side, side);
}

#pragma mark - 数据源和代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pics.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YOHOARHomeCommentPicViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellid forIndexPath:indexPath];
    cell.url = self.pics[indexPath.row].url;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YOHOARHomeCommentPicViewCell *cell = (YOHOARHomeCommentPicViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%@",cell.imageView.image);
    if (self.isAriControl) {
        [yoho_NotificationCenter postNotificationName:yoho_ARCommentPicClickNotification
                                               object:nil
                                             userInfo:@{yoho_ARCommentPicKey : cell.imageView.image,
                                                        yoho_ARCommentModelKey : self.model,
                                                        yoho_ARCommentFrameKey : cell}];        
    }
    
}
@end
