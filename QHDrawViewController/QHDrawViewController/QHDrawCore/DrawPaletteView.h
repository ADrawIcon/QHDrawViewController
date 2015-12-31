//
//  Palette.h
//  lovewith
//
//  Created by imqiuhang on 15/4/22.
//  Copyright (c) 2015年 lovewith.me. All rights reserved.
//

#import "QHHead.h"

@interface DrawPaletteView : UIView
{
    
    //当前的画笔宽度和当前的画笔颜色
	float           currentPaintBrushWidth;
	CGColorRef      currentPaintBrushColor;
    
    
    /*!
     *  @author imqiuhang, 16-12-31
     *
     *  @brief 一条线条包含了多个point，对应一个color和width
     */
    NSMutableArray* myAllLines;
	NSMutableArray* myAllPoints;

	NSMutableArray* myAllColors;
	NSMutableArray* myAllWidths;
    
    
    //哈希表暂存 在收到的哈希总数和实际收到的笔画数一致时表示 当前笔画存满 则将收到的所有同伴的笔画显示到画画上
    NSMutableDictionary *partnerHashDrawQuen __deprecated_msg("在线一起画将会在有时间的时候加上，具体可以参考婚礼时光APP的在线一起画功能");

    
	
}

@property (nonatomic) float x;
@property (nonatomic) float y;


- (void)IntroductionpointInitPoint;
- (void)IntroductionpointSavePoint;
- (void)IntroductionpointAddPoint:(CGPoint)sender;
- (void)IntroductionpointHexColor:(NSString *)hexcolor;
- (void)IntroductionpointWidth:(int)sender;

/*!
 *  @author imqiuhang, 16-12-31
 *
 *  @brief 清除所有的 画  如果对方在线，则需要发送清空另一半画板的消息
 */
- (void)cleanAllDrawBySelf;
/*!
 *  @author imqiuhang, 16-12-31
 *
 *  @brief 撤销一步，即清楚上一笔所画内容
 */
- (void)cleanFinallyDraw;


@end
