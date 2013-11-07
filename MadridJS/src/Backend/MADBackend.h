//
//  MADBackend.h
//  MadridJS
//
//  Created by Cesar Luis Valdez on 29/10/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MADMeetup.h"

@class MADBackend;

/*
@protocol BackendDelegate <NSObject>

@optional
-(void)recuperarListaEventos:(NSArray *)listaEventos;

@end
*/

@interface MADBackend : NSObject


@property NSString *token;
@property NSMutableArray *listado_eventos;

//@property (nonatomic, weak) id <BackendDelegate> delegate;
-(void)getUltimosEventos:(int)numero_of_eventos;
-(void)getEventosPasados:(int)numero_of_eventos;
- (id)initWithToken:(NSString *)tokenId;
- (void)parsearData:(NSData *)data;


@end
