//
//  Palette.m
//  lovewith
//
//  Created by imqiuhang on 15/4/22.
//  Copyright (c) 2015年 lovewith.me. All rights reserved.
//

#import "DrawPaletteView.h"
#import "UIView+QHUIViewCtg.h"

@implementation DrawPaletteView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
	
}

- (void)awakeFromNib {
    myAllLines  = [[NSMutableArray alloc] initWithCapacity:10];
    myAllColors = [[NSMutableArray alloc] initWithCapacity:10];
    myAllWidths = [[NSMutableArray alloc] initWithCapacity:10];

}

- (void)drawRect:(CGRect)rect  {

	CGContextRef context=UIGraphicsGetCurrentContext();
	CGContextSetLineCap(context, kCGLineCapRound);
	CGContextSetLineJoin(context, kCGLineJoinRound);
	if (myAllLines.count>0) {
		for (int i=0; i<[myAllLines count]; i++) {
			NSArray* tempArray=[NSArray arrayWithArray:[myAllLines objectAtIndex:i]];

			if ([myAllColors count]>0) {
                currentPaintBrushColor= [QHUtil colorWithHexString:myAllColors[i]].CGColor;
                currentPaintBrushWidth=[[myAllWidths objectAtIndex:i]floatValue]+1;
			}
			if ([tempArray count]>1) {
				CGContextBeginPath(context);
				CGPoint myStartPoint=[[tempArray objectAtIndex:0] CGPointValue];
				CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
				
				for (int j=0; j<[tempArray count]-1; j++) {
					CGPoint myEndPoint=[[tempArray objectAtIndex:j+1] CGPointValue];
					CGContextAddLineToPoint(context, myEndPoint.x,myEndPoint.y);	
				}
				CGContextSetStrokeColorWithColor(context, currentPaintBrushColor);
				CGContextSetLineWidth(context, currentPaintBrushWidth);
				CGContextStrokePath(context);
			}
		}
	}

	if ([myAllPoints count]>1) {
		CGContextBeginPath(context);
		CGPoint myStartPoint=[[myAllPoints objectAtIndex:0]   CGPointValue];
		CGContextMoveToPoint(context,    myStartPoint.x, myStartPoint.y);
		for (int i=0; i<[myAllPoints count]-1; i++) {
			CGPoint myEndPoint=  [[myAllPoints objectAtIndex:i+1] CGPointValue];
			CGContextAddLineToPoint(context, myEndPoint.x,   myEndPoint.y);
		}
		currentPaintBrushColor =  [QHUtil colorWithHexString:[myAllColors lastObject]].CGColor;
		currentPaintBrushWidth=[[myAllWidths lastObject]floatValue]+1;
		CGContextSetStrokeColorWithColor(context, currentPaintBrushColor);
		CGContextSetFillColorWithColor (context,  currentPaintBrushColor);
		CGContextSetLineWidth(context, currentPaintBrushWidth);
		CGContextStrokePath(context);
	}
}

- (void)IntroductionpointInitPoint {
	myAllPoints = [[NSMutableArray alloc] initWithCapacity:10];
}

-(void)IntroductionpointSavePoint {
	[myAllLines addObject:myAllPoints];
}
-(void)IntroductionpointAddPoint:(CGPoint)sender {
	NSValue* pointvalue=[NSValue valueWithCGPoint:sender];
	[myAllPoints addObject:pointvalue ];
}

- (void)IntroductionpointHexColor:(NSString *)color {
	[myAllColors addObject:color];
}

- (void)IntroductionpointWidth:(int)sender {
	[myAllWidths addObject:@(sender)];
}


- (void)cleanAllDrawBySelf {
	if ([myAllLines count]>0)  {
		[myAllLines removeAllObjects];
		[myAllColors removeAllObjects];
		[myAllWidths removeAllObjects];
		[myAllPoints removeAllObjects];
		myAllLines=[[NSMutableArray alloc] initWithCapacity:10];
		myAllColors=[[NSMutableArray alloc] initWithCapacity:10];
		myAllWidths=[[NSMutableArray alloc] initWithCapacity:10];
		[self setNeedsDisplay];
	}
}

- (void)cleanFinallyDraw {
	if ([myAllLines count]>0) {
		[myAllLines  removeLastObject];
		[myAllColors removeLastObject];
		[myAllWidths removeLastObject];
		[myAllPoints removeAllObjects];
    }
	[self setNeedsDisplay];
    if ([myAllLines count]<=0) {
    }
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
