import { RecipeType } from 'src/enums/recipe.enums';
import { Favoris } from 'src/favoris/entities/favoris.entity';
import { PreparationStep } from 'src/preparation_steps/entities/preparation_step.entity';

export class CreateRecipeDto {
  title: string;
  description: string;
  time_preparation: Date;
  difficulty: string;
  creation_date: Date;
  recipe_type: RecipeType;
  id_user: number;
  favoris: Favoris[];
  preparationstep: PreparationStep[];
}
