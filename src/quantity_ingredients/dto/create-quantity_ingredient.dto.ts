import { ApiProperty } from '@nestjs/swagger';
import { Ingredient } from 'src/ingredients/entities/ingredient.entity';
import { Recipe } from 'src/recipes/entities/recipe.entity';
import { Entity } from 'typeorm';

@Entity({ name: 'quantity_ingredients' })
export class CreateQuantityIngredientDto {
  @ApiProperty()
  id_quantity_ingredients: number;

  @ApiProperty()
  quantity: number;

  @ApiProperty()
  unit: string;

  @ApiProperty()
  recipe: Recipe[];

  @ApiProperty()
  ingredients: Ingredient[];
}
