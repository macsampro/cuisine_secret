import { Recipe } from 'src/recipes/entities/recipe.entity';

export class CreatePhotosDto {
  name: string;
  description: string;
  size: number;
  mimetype: string;
  recipe: Recipe;
}
