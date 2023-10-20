import { Module } from '@nestjs/common';
import { QuantityIngredientsService } from './quantity_ingredients.service';
import { QuantityIngredientsController } from './quantity_ingredients.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { QuantityIngredient } from './entities/quantity_ingredient.entity';
import { Recipe } from 'src/recipes/entities/recipe.entity';
import { Ingredient } from 'src/ingredients/entities/ingredient.entity';

@Module({
  imports: [TypeOrmModule.forFeature([QuantityIngredient, Recipe, Ingredient])],
  controllers: [QuantityIngredientsController],
  providers: [QuantityIngredientsService],
})
export class QuantityIngredientsModule {}
