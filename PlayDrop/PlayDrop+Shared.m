//
//  PlayDrop+Shared.m
//  BaldBryanDrops
//
//  Created by Daniel Koza on 2/5/13.
//  Copyright (c) 2013 Daniel Koza. All rights reserved.
//

#import "PlayDrop+Shared.h"

static PlayDrop *sharePlayDrop = NULL;

@implementation PlayDrop (Shared)
+(PlayDrop *) retrieveSharedPlayDrop {
    @synchronized(sharePlayDrop)
    {
        if ( !sharePlayDrop || sharePlayDrop == NULL )
        {
            sharePlayDrop = [[PlayDrop alloc]init];
        }
        return sharePlayDrop;
    }
}
@end