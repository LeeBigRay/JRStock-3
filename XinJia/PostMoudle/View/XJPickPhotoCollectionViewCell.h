//
//  XJPickPhotoCollectionViewCell.h
//  XinJia
//
//  Created by 李瑞 on 2017/6/1.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DeletePhotoDelegate;

@interface XJPickPhotoCollectionViewCell : UICollectionViewCell
@property (nonatomic ,strong)UIImageView *photoImageView;//图片
@property (nonatomic ,strong)UIButton *deleteBtn;//删除按钮
@property (nonatomic ,weak)id<DeletePhotoDelegate>delegate;
@end

@protocol DeletePhotoDelegate <NSObject>

-(void)deletePhotoWithCell:(XJPickPhotoCollectionViewCell *)cell;

@end
