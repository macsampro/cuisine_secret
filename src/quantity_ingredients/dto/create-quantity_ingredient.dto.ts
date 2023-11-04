import { Ingredient } from 'src/ingredients/entities/ingredient.entity';
import { Recipe } from 'src/recipes/entities/recipe.entity';
import { Entity } from 'typeorm';

@Entity({ name: 'quantity_ingredients' })
export class CreateQuantityIngredientDto {
  quantity: number;
  unit: string;
  recipe: Recipe[];
  ingredients: Ingredient[];
}
