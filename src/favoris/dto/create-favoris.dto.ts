import { Recipe } from 'src/recipes/entities/recipe.entity';
import { User } from 'src/users/entities/user.entity';

export class CreateFavorisDto {
  id_user!: number;
  id_recipe: number;
  userIdUser: User[];
  recipe: Recipe[];
}
