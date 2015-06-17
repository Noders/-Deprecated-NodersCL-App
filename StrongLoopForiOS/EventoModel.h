//
//  EventoModel.h
//  Noders
//
//  Created by Jose Vildosola on 22-05-15.
//  Copyright (c) 2015 DevIn. All rights reserved.
//

#import <LoopBack/LoopBack.h>

@interface EventoModel : LBModel

@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *url;
@property(strong,nonatomic) NSDictionary *geo;
@property(strong,nonatomic) NSString *fechainicio;
@property(strong,nonatomic) NSString *hostId;

+(Class) getClass;

@end

@interface EventoRepository : LBModelRepository

+(instancetype)repository;

@end

@implementation EventoRepository

+(instancetype)repository{
    EventoRepository *eventoRepo = [self repositoryWithClassName:@"Eventos"];
    eventoRepo.modelClass = [EventoModel class];
    return eventoRepo;
}

@end
