//
//  PlayDrop.h
//  BaldBryanDrops
//
//  Created by Daniel Koza on 2/4/13.
//  Copyright (c) 2013 Daniel Koza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@interface PlayDrop : NSObject <AVAudioPlayerDelegate>{
    AVAudioPlayer *dropPlayer;
}

@property (nonatomic,strong)  id delegate;

- (void)playDropWithFileName:(NSString *)fileName;
- (void)stopDrop;
- (BOOL)isPlaying;
@end