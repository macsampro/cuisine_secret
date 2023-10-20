import { Module } from '@nestjs/common';
import { IngredientsService } from './ingredients.service';
import { IngredientsController } from './ingredients.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Ingredient } from './entities/ingredient.entity';
import { QuantityIngredient } from 'src/quantity_ingredients/entities/quantity_ingredient.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Ingredient, QuantityIngredient])],
  controllers: [IngredientsController],
  providers: [IngredientsService],
})
export class IngredientsModule {}
