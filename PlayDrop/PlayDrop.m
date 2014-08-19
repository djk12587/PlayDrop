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
    }
}

- (void)stopDrop {
    if (dropPlayer.isPlaying) {
        [dropPlayer stop];
        dropPlayer = nil;
    }
}

- (BOOL)isPlaying {
    return dropPlayer.isPlaying;
}

#pragma mark - AVAudioPlayer Delegate Methods
-(void) audioPlayerBeginInterruption:(AVAudioPlayer *)player {
    if ([player isPlaying]) {
        [player stop];
        player = nil;
    }
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    player = nil;
}

- (void) audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    NSLog(@"Error: %@",[error description]);
}
@end