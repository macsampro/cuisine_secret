import { Favoris } from 'src/favoris/entities/favoris.entity';
import { Recipe } from 'src/recipes/entities/recipe.entity';

export class CreateUserDto {
  username: string;
  password_hash: string;
  email: string;
  recipes: Recipe[];
  favoris: Favoris[];
}
