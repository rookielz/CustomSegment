//
//  CustomSegment.m
//  CustomSegment
//
//  Created by rimi on 2017/1/19.
//  Copyright © 2017年 iOS-ZX. All rights reserved.
//

#import "CustomSegment.h"

#define WEAKSELF __weak typeof(self) weakSelf = self;

@interface CustomSegment()

/** items **/
@property(nonatomic,strong)NSArray *items;

/** itemArray **/
@property(nonatomic,strong)NSMutableArray *itemArray;

/** 动画层 **/
@property(nonatomic,strong)UIView *animView;

@end

@implementation CustomSegment

- (instancetype)initWithItems:(NSArray*)items{
    self = [super init];
    if (self) {
        _items = items;
        _height = 40; // 默认高度
        _selectItemBgColor = [UIColor whiteColor];
        _itemBgColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.2];
        _selectTitleColor = [UIColor blackColor];
        _titleColor = [UIColor whiteColor];
        _selectIndex = 0;
        _cornerRadius = 20;
        _borderColor = self.selectItemBgColor;
        [self makeItems];
        [self setUpUI];
    }
    return self;
}

// 初始化UI
- (void)setUpUI{
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.borderWidth = 1;
    self.backgroundColor = self.itemBgColor;
    self.layer.cornerRadius = self.cornerRadius;
    self.frame = CGRectMake(0, 0, ([self getItemMaxWidth] + 20)*self.items.count, 40);
    [self selectItemWithIndex:self.selectIndex];
}

/** 创建item **/
- (void)makeItems{
    WEAKSELF;
    [self.itemArray removeAllObjects];
    CGFloat maxWidth = [self getItemMaxWidth] + 20;
    // 遍历item
    [self.items enumerateObjectsUsingBlock:^(NSString * _Nonnull str, NSUInteger idx, BOOL * _Nonnull stop) {
        // 创建item
        UIButton *itemBtn = [[UIButton alloc]initWithFrame:CGRectMake(maxWidth * idx, 0, maxWidth, weakSelf.height)];
        [itemBtn setTitle:str forState:UIControlStateNormal];
        [itemBtn setTitleColor:weakSelf.selectTitleColor forState:UIControlStateSelected];
        [itemBtn setTitleColor:weakSelf.titleColor forState:UIControlStateNormal];
        itemBtn.layer.cornerRadius = weakSelf.cornerRadius;
        itemBtn.layer.masksToBounds = YES;
        itemBtn.tag = idx;
        [itemBtn addTarget:weakSelf action:@selector(selectItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [weakSelf.itemArray addObject:itemBtn];
        [weakSelf addSubview:itemBtn];
    }];
}

// item点击事件
- (void)selectItemClick:(UIButton*)sender{
    self.selectIndex = sender.tag;
    [self selectItemWithIndex:sender.tag];
}

// 选中item
- (void)selectItemWithIndex:(NSInteger)index{
    [self.itemArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == index) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }];
    [self animViewMoveTo:index];
}

// 动画移动
- (void)animViewMoveTo:(NSInteger)index{
    WEAKSELF;
    [UIView animateWithDuration:0.2 animations:^{
        UIButton *btn = weakSelf.itemArray[index];
        weakSelf.animView.center = btn.center;
    }];
}

// 获取item中的最大宽度
- (CGFloat)getItemMaxWidth{
    __block CGFloat w = 0;
    [self.items enumerateObjectsUsingBlock:^(NSString * _Nonnull str, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect = [str boundingRectWithSize:CGSizeMake(0, self.height) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
        if (rect.size.width > w) {
            w = rect.size.width;
        }
    }];
    return w;
}

#pragma mark - setter

- (void)setHeight:(CGFloat)height
{
    _height = height;
    [self setUpUI];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [self makeItems];
}

- (void)setSelectTitleColor:(UIColor *)selectTitleColor
{
    _selectTitleColor = selectTitleColor;
    [self makeItems];
}

- (void)setItemBgColor:(UIColor *)itemBgColor
{
    _itemBgColor = itemBgColor;
    [self setUpUI];
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    [self selectItemWithIndex:selectIndex];
}

- (void)setSelectItemBgColor:(UIColor *)selectItemBgColor
{
    _selectItemBgColor = selectItemBgColor;
    self.animView.backgroundColor = selectItemBgColor;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    [self setUpUI];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self.animView removeFromSuperview];
    _animView = nil;
    [self setUpUI];
    [self makeItems];
}

#pragma mark - getter

- (NSMutableArray *)itemArray{
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

- (UIView *)animView{
    if (!_animView) {
        _animView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [self getItemMaxWidth] + 20, self.height)];
        _animView.layer.cornerRadius = self.cornerRadius;
        _animView.layer.masksToBounds = YES;
        _animView.backgroundColor = self.selectItemBgColor;
        [self insertSubview:_animView atIndex:0];
    }
    return _animView;
}

@end
