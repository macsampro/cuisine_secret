import { Module } from '@nestjs/common';
import { PreparationStepsService } from './preparation_steps.service';
import { PreparationStepsController } from './preparation_steps.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Recipe } from 'src/recipes/entities/recipe.entity';
import { QuantityIngredient } from 'src/quantity_ingredients/entities/quantity_ingredient.entity';
import { PreparationStep } from './entities/preparation_step.entity';
import { Ingredient } from 'src/ingredients/entities/ingredient.entity';
import { User } from 'src/users/entities/user.entity';
@Module({
  imports: [
    TypeOrmModule.forFeature([
      User,
      PreparationStep,
      Recipe,
      QuantityIngredient,
      Ingredient,
    ]),
  ],
  controllers: [PreparationStepsController],
  providers: [PreparationStepsService],
})
export class PreparationStepsModule {}
