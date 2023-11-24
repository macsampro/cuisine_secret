import { Module } from '@nestjs/common';
import { PhotosService } from './photos.service';
import { PhotosController } from './photos.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Photo } from './entities/photo.entity';
import { MulterModule } from '@nestjs/platform-express';
import { PassportModule } from '@nestjs/passport';
import { Recipe } from 'src/recipes/entities/recipe.entity';

@Module({
  imports: [
    MulterModule.register({
      dest: './uploads', // Le dossier où Multer va enregistrer les fichiers uploadés.
    }),
    TypeOrmModule.forFeature([Photo, Recipe]), // Enregistrement de l'entité Photo pour l'injection dans les services.
    PassportModule.register({ defaultStrategy: 'jwt' }), // Configuration du module Passport avec la stratégie JWT.
  ],

  controllers: [PhotosController], // Contrôleur qui va gérer les routes pour les photos.
  providers: [PhotosService], // Service qui va gérer la logique métier des photos.
})
export class PhotosModule {}
