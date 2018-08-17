//
//  UIImageView+AMImageView.m
//  AMDaliy
//
//  Created by 李明明 on 2018/8/6.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "UIImageView+AMImageView.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>
#import "AMCreateFile.h"


@implementation UIImageView (AMImageView)

- (void)am_setImageWithVideoPath:(NSString *)videoPath
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videoPath] options:@{}];
        AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        assetGen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0.0, 600);
        NSError *error;
        CMTime actualTime;
        CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = videoImage;
            // 保存到
        });
        NSString *fileName = [@"lmm/img/" stringByAppendingString:[[videoPath stringByDeletingPathExtension] lastPathComponent]];
        fileName = [NSString stringWithFormat:@"%@.png", fileName];
        NSString *imgPath = [AMCreateFile createFileWithPath:fileName isDir:NO withType:AMDocument];
        NSData *data = UIImagePNGRepresentation(videoImage);
        BOOL iswirtten = [data writeToFile:imgPath atomically:YES];
        NSLog(@"iswirtten:%d", iswirtten);
        CGImageRelease(image);
    });
}










@end
