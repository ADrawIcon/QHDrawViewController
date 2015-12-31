//
//  DrawPaletteView.m
//  lovewith
//
//  Created by imqiuhang on 15/4/22.
//  Copyright (c) 2015年 imqiuhang All rights reserved.
//

#import "DrawPaletteView.h"
#import "UIView+QHUIViewCtg.h"

@implementation DrawPaletteView

#pragma mark - init
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        allMyDrawPaletteLineInfos = [[NSMutableArray alloc] initWithCapacity:10];
        self.currentPaintBrushColor = [UIColor blackColor];
        self.currentPaintBrushWidth =  4.f;
    }
    return self;
	
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        allMyDrawPaletteLineInfos = [[NSMutableArray alloc] initWithCapacity:10];
        self.currentPaintBrushColor = [UIColor blackColor];
        self.currentPaintBrushWidth =  4.f;
    }
    
    return self;
}

#pragma  mark - draw event
//根据现有的线条 绘制相应的图画
- (void)drawRect:(CGRect)rect  {

	CGContextRef context=UIGraphicsGetCurrentContext();
	CGContextSetLineCap(context, kCGLineCapRound);
	CGContextSetLineJoin(context, kCGLineJoinRound);
    
	if (allMyDrawPaletteLineInfos.count>0) {
		for (int i=0; i<[allMyDrawPaletteLineInfos count]; i++) {
            DrawPaletteLineInfo *info = allMyDrawPaletteLineInfos[i];
            
			if ([info.linePoints count]>1) {
				CGContextBeginPath(context);
				CGPoint myStartPoint=[[info.linePoints objectAtIndex:0] CGPointValue];
				CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
				
				for (int j=0; j<[info.linePoints count]-1; j++) {
					CGPoint myEndPoint=[[info.linePoints objectAtIndex:j+1] CGPointValue];
					CGContextAddLineToPoint(context, myEndPoint.x,myEndPoint.y);	
				}
				CGContextSetStrokeColorWithColor(context, info.lineColor.CGColor);
				CGContextSetLineWidth(context, info.lineWidth+1);
				CGContextStrokePath(context);
			}
		}
	}
}


#pragma mark - touch event
//触摸开始
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch* touch=[touches anyObject];

    [self drawPaletteTouchesBeganWithWidth:self.currentPaintBrushWidth andColor:self.currentPaintBrushColor andBeginPoint:[touch locationInView:self ]];
}
//触摸移动
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray* MovePointArray=[touches allObjects];
    [self drawPaletteTouchesMovedWithPonit:[[MovePointArray objectAtIndex:0] locationInView:self]];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}


#pragma mark draw info edite event
//在触摸开始的时候 添加一条新的线条 并初始化
- (void)drawPaletteTouchesBeganWithWidth:(float)width andColor:(UIColor *)color andBeginPoint:(CGPoint)bPoint {
    DrawPaletteLineInfo *info = [DrawPaletteLineInfo new];
    info.lineColor = color;
    info.lineWidth = width;
    
    [info.linePoints addObject:[NSValue valueWithCGPoint:bPoint]];
    
    [allMyDrawPaletteLineInfos addObject:info];
}

//在触摸移动的时候 将现有的线条的最后一条的 point增加相应的触摸过的坐标
- (void)drawPaletteTouchesMovedWithPonit:(CGPoint)mPoint {
    DrawPaletteLineInfo *lastInfo = [allMyDrawPaletteLineInfos lastObject];
    [lastInfo.linePoints addObject:[NSValue valueWithCGPoint:mPoint]];
}

- (void)cleanAllDrawBySelf {
    if ([allMyDrawPaletteLineInfos count]>0)  {
        [allMyDrawPaletteLineInfos removeAllObjects];
        [self setNeedsDisplay];
    }
}

- (void)cleanFinallyDraw {
    if ([allMyDrawPaletteLineInfos count]>0) {
        [allMyDrawPaletteLineInfos  removeLastObject];
    }
    [self setNeedsDisplay];
}


@end

@implementation DrawPaletteLineInfo

- (instancetype)init {
    if (self=[super init]) {
        self.linePoints = [[NSMutableArray alloc] initWithCapacity:10];
    }
    
    return self;
}

@end


