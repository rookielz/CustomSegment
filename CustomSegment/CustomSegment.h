//
//  CustomSegment.h
//  CustomSegment
//
//  Created by rimi on 2017/1/19.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSegment : UIView

/** 控件高度，默认40 **/
@property(nonatomic,assign)CGFloat height;

/** 选中文字颜色,默认黑色 **/
@property(nonatomic,strong)UIColor *selectTitleColor;

/** 未选中文字颜色，默认白色 **/
@property(nonatomic,strong)UIColor *titleColor;

/** 选中item背景颜色，默认白色 **/
@property(nonatomic,strong)UIColor *selectItemBgColor;

/** 未选中item背景颜色，默认灰色，透明0.2 **/
@property(nonatomic,strong)UIColor *itemBgColor;

/** 控件圆角 **/
@property(nonatomic,assign)CGFloat cornerRadius;

/** 选中项，默认0 **/
@property(nonatomic,assign)NSInteger selectIndex;

/** 边框颜色，默认与选中颜色一致 **/
@property(nonatomic,strong)UIColor *borderColor;


- (instancetype)initWithItems:(NSArray*)items;

@end
