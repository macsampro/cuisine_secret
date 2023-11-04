import { Favoris } from 'src/favoris/entities/favoris.entity';
import { QuantityIngredient } from 'src/quantity_ingredients/entities/quantity_ingredient.entity';

export class CreateRecipeDto {
  title: string;
  description: string;
  time_preparation: Date;
  difficulty: string;
  creation_date: Date;
  id_user: number;
  quantityIngredients: QuantityIngredient[];
  favoris: Favoris[];
}
