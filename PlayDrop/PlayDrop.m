//
//  PlayDrop.m
//  BaldBryanDrops
//
//  Created by Daniel Koza on 2/4/13.
//  Copyright (c) 2013 Daniel Koza. All rights reserved.
//

#import "PlayDrop.h"

@implementation PlayDrop

- (void)playDropWithFileName:(NSString *)fileName {
    
    NSURL *urlSample = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],fileName]];
    if ([dropPlayer isPlaying]) {
        [dropPlayer stop];
        dropPlayer = nil;
        [vibrationTimer invalidate];
        vibrationTimer = nil;
    }

	NSError *error;
	dropPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:urlSample error:&error];
	dropPlayer.numberOfLoops = -1;
    [dropPlayer setDelegate:self];
	if (dropPlayer == nil) {
        NSLog(@"%@",[error description]);
    }
	else {
        [dropPlayer play];
        vibrationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(vibrate) userInfo:nil repeats:YES];
    }
}

- (void)stopDrop {
    if (dropPlayer.isPlaying) {
        [dropPlayer stop];
        dropPlayer = nil;
        [vibrationTimer invalidate];
        vibrationTimer = nil;
    }
}

- (BOOL)isPlaying {
    return dropPlayer.isPlaying;
}

- (void) vibrate {
    double delay = 0.0 * NSEC_PER_SEC;
    double time = dispatch_time(DISPATCH_TIME_NOW, delay);
    
    dispatch_after(time, dispatch_get_main_queue(), ^{
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    });
}

#pragma mark - AVAudioPlayer Delegate Methods
-(void) audioPlayerBeginInterruption:(AVAudioPlayer *)player {
    if ([player isPlaying]) {
        [player stop];
        player = nil;
        [vibrationTimer invalidate];
        vibrationTimer = nil;
    }
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    player = nil;
    [vibrationTimer invalidate];
    vibrationTimer = nil;
}

- (void) audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    NSLog(@"Error: %@",[error description]);
}
@end