//
//  XJClasslyCollectionReusableView.h
//  XinJia
//
//  Created by 李瑞 on 2017/5/28.
//  Copyright © 2017年 RayKi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@protocol HomeTypeClickDelegate;
@interface XJClasslyCollectionReusableView : UICollectionReusableView
//@property (nonatomic ,strong)UILabel *textLabele;
@property (nonatomic, strong) SDCycleScrollView   *cycleScrollView;
@property (nonatomic, strong) UICollectionView    *classifyCollection;
@property (nonatomic, weak)id<HomeTypeClickDelegate>delegate;
@end

@protocol HomeTypeClickDelegate <NSObject>

-(void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end
