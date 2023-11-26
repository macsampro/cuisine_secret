import { Module } from '@nestjs/common';
import { RecipesService } from './recipes.service';
import { RecipesController } from './recipes.controller';
import { User } from 'src/users/entities/user.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Recipe } from './entities/recipe.entity';
import { PreparationStep } from 'src/preparation_steps/entities/preparation_step.entity';
import { PhotosModule } from 'src/photos/photos.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([User, Recipe, PreparationStep]),
    PhotosModule, // Assurez-vous que PhotosModule est importé correctement ici
  ],

  controllers: [RecipesController],
  providers: [RecipesService],
})
export class RecipesModule {}
