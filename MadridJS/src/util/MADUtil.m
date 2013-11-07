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
@end
