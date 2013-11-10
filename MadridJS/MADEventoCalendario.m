//
//  MADEventoCalendario.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 10/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import "MADEventoCalendario.h"

@implementation MADEventoCalendario

#define kCalendarioID   @"identificador_calendario"


- (id)initWithIdentificador:(NSString*)calendarioIdentificador
{
    self = [super init];
    if (self) {
        _store = [[EKEventStore alloc] init];
        _identificador = calendarioIdentificador;

    }
    return self;
}


- (id)init
{
    self = [super init];
    if (self) {
        _store = [[EKEventStore alloc]init];
    }
    return self;
}



#pragma mark NSCoding

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_identificador forKey:kCalendarioID];

}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    _identificador                  = [aDecoder decodeObjectForKey:kCalendarioID];

    return [self initWithIdentificador:_identificador];
}



+(MADEventoCalendario *)iniciarDesdeFichero{
    
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"calendario.txt"];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}



-(void)guardarToken{
    
    if (self) {
        NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"calendario.txt"];
        [NSKeyedArchiver archiveRootObject:self toFile:filePath];
    }else{
        
        NSLog(@"No hay backend inicializado error grave");
        NSAssert1(!self, @"error grave [intentar guardar undefined toke] : %@",self);
    }
    
}




-(void)obtenerPermisos{
    
    if (!_permisoConcedido) {
        
    
    
    [_store requestAccessToEntityType:EKEntityTypeEvent
                           completion:^(BOOL granted, NSError *error) {
                               
                               _permisoConcedido = granted;
                               _error_log = [error description];
                           }];
    
    }

}



-(EKCalendar *)crearCalendarioMadridJS{
    
    
    EKCalendar *_myCalendar;
    EKSource *myLocalSource = nil;
    for (EKSource *calendarSource in _store.sources) {
        if (calendarSource.sourceType == EKSourceTypeLocal) {
            myLocalSource = calendarSource;
            break;
        }
    }

    // Create a new calendar of type Local... save and commit
    _myCalendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:_store];
    _myCalendar.title = @"Eventos MadridJS";
    _myCalendar.source = myLocalSource;
    
    
    
    
    
    
    NSError *error = nil;
    [_store saveCalendar:_myCalendar commit:YES error:&error];
    
    if (!error) {
        NSLog(@"created, saved, and commited my calendar with id %@", _myCalendar.calendarIdentifier);
        self.identificador = _myCalendar.calendarIdentifier;
        return _myCalendar;
        
    } else {
        NSLog(@"an error occured when creating the calendar");
        error = nil;
    }

    
    
    return nil;
    
}


-(EKCalendar *)buscarCalendario{

    EKCalendar *_my_calendario = [_store calendarWithIdentifier:_identificador];

    
    if (!_my_calendario) {
        _my_calendario = [self crearCalendarioMadridJS];
    }
    
    [self guardarToken];
    
    
    return _my_calendario;
}


-(void)crearRecordatorio:(MADMeetup *)meet{
    

    if (_permisoConcedido) {
     
        EKEvent *myEvent = [EKEvent eventWithEventStore:_store];
        NSDate *fecha = [meet.tiempo dateByAddingTimeInterval:3600*3];
        EKCalendar *_my_calendario = [self buscarCalendario];
    
    
        myEvent.allDay = NO;
        myEvent.startDate = meet.tiempo;
        myEvent.endDate = fecha;
        myEvent.title = meet.nombre;
        myEvent.calendar = _my_calendario;
        NSError *error;

        [_store saveEvent:myEvent span:EKSpanThisEvent commit:YES error:&error];
    
        if (!error) {
            NSLog(@"the event saved and committed correctly with identifier %@", myEvent.eventIdentifier);
            self.mensaje = @"Se ha creado una cita en la agenda.";
            
        } else {
            NSLog(@"there was an error saving and committing the event");
            self.mensaje = @"Hubo un error al guardar, verifica que la aplicacion tiene permisos \
                             Ajustes/Privacidad/Calendarios.";
            error = nil;
            
            
        }
        
    }else{
        self.mensaje = @"Hubo un error al guardar, verifica que la aplicacion tiene permisos \
        Ajustes/Privacidad/Calendarios.";

    
    }
    
    
}


@end
