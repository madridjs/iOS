//
//  MADUtil.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 05/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import "MADUtil.h"

@implementation MADUtil


+(NSString *)construirFecha:(NSDate *)fecha{
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:fecha]; // Get necessary date components
    
    return [NSString stringWithFormat:@"dia %d mes %d",[components day], [components month] ];
}

+(NSMutableDictionary *)leerUrlParametros:(NSString *)url{

    //NSString *url = @"http://www.madridjs.org/?code=cc8e05f3a9265a1965c3976a0df12726&state=off";
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:4];
    
    const char *url_path = [url UTF8String];
    char param[90];
    char valor[90];
    param[0] = '\0';
    valor[0] = '\0';
    
    int param_init = 0;
    int valor_init = 0;
    
    int param_cnt = 0;
    int valor_cnt = 0;
    memset(param, 0, 90);
    memset(valor, 0, 90);
    
    
    for (int x = 0; x<=strlen(url_path); x++) {
        char pieza = url_path[x];
        
        if (pieza == '?') {
            param_init = 1;
            valor_init = 0;
            continue;
        }
        
        if (pieza == '=') {
            valor_init = 1;
            param_init = 0;
            continue;
        }
        
        
        if (pieza == '&' ||  x > (strlen(url_path)-1)) {
            [dict setObject:[NSString stringWithFormat:@"%s",valor] forKey:[NSString stringWithFormat:@"%s",param]];
            memset(param, 0, 90); param_cnt = 0;
            memset(valor, 0, 90); valor_cnt = 0;
            param_init = 1;
            valor_init = 0;
            
            continue;
        }
        
        if (valor_init)
            valor[valor_cnt++] = pieza;
        
        if (param_init)
            param[param_cnt++] = pieza;
        
        
        
    }
    
    return dict;

}


@end
