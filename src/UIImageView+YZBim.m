//
//  UIImageView+YZBim.m
//  iPhoneBIM
//
//  Created by luhai on 15/12/3.
//  Copyright © 2015年 Dev. All rights reserved.
//

#import "UIImageView+YZBim.h"

@implementation UIImageView (YZBim)
- (void)setImageWithData:(NSData *)data Animated:(BOOL)animated
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage * img = [UIImage imageWithData:data];
        
        // Make a trivial (1x1) graphics context, and draw the image into it
        UIGraphicsBeginImageContext(CGSizeMake(1,1));
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), [img CGImage]);
        UIGraphicsEndImageContext();
        
        // Now the image will have been loaded and decoded and is ready to rock for the main thread
        dispatch_sync(dispatch_get_main_queue(), ^{
            [UIView transitionWithView:self
                              duration:0.7f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{[self setImage:img];}
                            completion:NULL];
        });
    });

}
@end
