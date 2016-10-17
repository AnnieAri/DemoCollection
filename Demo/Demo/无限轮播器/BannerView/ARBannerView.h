//
//  ARBannerView.h
//  Banner
//
//  Created by Ari on 16/10/13.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARBannerView : UIView
@property (nonatomic, strong) NSArray* imageURLs;
@end
/**flowlayout*/
@interface ARFlowLayout : UICollectionViewFlowLayout

@end
/**轮播器自定义cell*/
@interface ARCycleCell : UICollectionViewCell

@end
