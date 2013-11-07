//
//  MADMeetup.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 02/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import "MADMeetup.h"

@implementation MADMeetup


#define DESC_CHARLA_SPA @"<p><b>Descripción de la charla</b></p>"
#define BIO_CHARLA_SPA @"<p><b>Biografía del ponente</b></p>"

#define DESC_CHARLA_ENG @"Description"
#define BIO_CHARLA_ENG @"Speaker Bio"


- (id)initWithDiccionario:(NSDictionary *)meetu_dicc
{
    self = [super init];
    if (self) {
        _nombre             = [meetu_dicc objectForKey:@"name"];
        _identificador      = [meetu_dicc objectForKey:@"id"];
        _descripcion        = [meetu_dicc objectForKey:@"description"];
        _url                = [meetu_dicc objectForKey:@"event_url"];
        _estado             = [meetu_dicc objectForKey:@"status"];
        _personas           = [[meetu_dicc objectForKey:@"yes_rsvp_count"] integerValue];
        _how_to_find        = [meetu_dicc objectForKey:@"how_to_find_us"];
        
        
        
        [self extraerBioAndDesc:_descripcion];
        
        NSDictionary *venue_dicc  =  [meetu_dicc objectForKey:@"venue"];
        
        double creado_sec             = [[meetu_dicc objectForKey:@"created"]doubleValue];
        double actualizado_sec        = [[meetu_dicc objectForKey:@"updated"]doubleValue];
        double tiempo_sec             = [[meetu_dicc objectForKey:@"time"]doubleValue];
        
        _actualizado = [NSDate dateWithTimeIntervalSinceReferenceDate:(actualizado_sec / 1000)];
        _creado      = [NSDate dateWithTimeIntervalSinceReferenceDate:(creado_sec / 1000)];
        _tiempo      = [NSDate dateWithTimeIntervalSinceReferenceDate:(tiempo_sec / 1000)];
        
        
          _direccion = [[MADMeetupDireccion alloc]initWithDiccionario:venue_dicc];
        
      //  [NSDate dateWithTimeIntervalSince1970:]
    }
    return self;
}



-(void)extraerBioAndDesc:(NSString*)htmlString{
    
    
    NSMutableString *str_descripcion_charla = [[NSMutableString alloc]init];
    NSMutableString *str_bio_charla =[[NSMutableString alloc]init];
    
    bool guardar_data_desc = NO;
    bool guardar_data_bio  = NO;
    
    NSArray *htmlLine = [htmlString componentsSeparatedByString:@"\n"];
    
    for (NSString *line in htmlLine) {
        
        if ([line isEqualToString:DESC_CHARLA_SPA] || [line rangeOfString:DESC_CHARLA_ENG].location != NSNotFound) {
            guardar_data_desc = YES;
        }
        if ([line isEqualToString:BIO_CHARLA_SPA] || [line rangeOfString:BIO_CHARLA_ENG].location != NSNotFound) {
            guardar_data_desc = NO;
            guardar_data_bio = YES;
        }
        
        if (guardar_data_desc) {
            [str_descripcion_charla appendString:line];
        }
        
        if (guardar_data_bio) {
            [str_bio_charla appendString:line];
        }
        
    }
    
    _bio_charla = str_bio_charla;
    _desc_charla = str_descripcion_charla;
    
    
}


@end
