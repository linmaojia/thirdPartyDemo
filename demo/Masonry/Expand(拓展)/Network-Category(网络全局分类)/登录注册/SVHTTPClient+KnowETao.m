//
//  SVHTTPClient+KnowETao.m
//  ETao
//
//  Created by AVGD—JK on 16/4/7.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+KnowETao.h"

@implementation SVHTTPClient (KnowETao)



+ (void)requestNewFeatureImagesArrayWithCallback:(RequestNewFeatureImagesArrayCallback)callBack
{
    
    NSLog(@"------%@",APINewfeature);
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    [[SVHTTPClient sharedClient] GET:APIKnowETao parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error)
        {

            
        }
        else
        {
            NSMutableArray *imagesArray = [NSMutableArray new];
            for(NSString *imageString in (NSArray *)response)
            {
                NSString *newImageString = [imageString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                [imagesArray addObject:newImageString];
            }
            
            callBack(imagesArray);
        }
        
    }];
}

@end
