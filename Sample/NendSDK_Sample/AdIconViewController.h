//
//  AdIconViewController.h
//  NendSDK_Sample
//
//  Created by ADN on 2013/07/19.
//  Copyright (c) 2013年 F@N Communications. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NADIconLoader.h"

@interface AdIconViewController : UIViewController<NADIconLoaderDelegate>{
    NADIconLoader* nadIconLoader;
    NSMutableArray* nadIconViewArray;
}

@end
