import { ApiProperty } from '@nestjs/swagger';
import { Recipe } from 'src/recipes/entities/recipe.entity';
import { User } from 'src/users/entities/user.entity';

export class CreateFavorisDto {
  @ApiProperty()
  id_user!: number;

  @ApiProperty()
  id_recipe: number;

  @ApiProperty()
  userIdUser: User[];

  @ApiProperty()
  recipe: Recipe[];
}
