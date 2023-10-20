import { Module } from '@nestjs/common';
import { RecipesService } from './recipes.service';
import { RecipesController } from './recipes.controller';
import { User } from 'src/users/entities/user.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Recipe } from './entities/recipe.entity';
import { QuantityIngredient } from 'src/quantity_ingredients/entities/quantity_ingredient.entity';

@Module({
  imports: [TypeOrmModule.forFeature([User, Recipe, QuantityIngredient])],

  controllers: [RecipesController],
  providers: [RecipesService],
})
export class RecipesModule {}
