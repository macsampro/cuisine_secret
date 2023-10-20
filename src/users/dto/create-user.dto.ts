import { ApiProperty } from '@nestjs/swagger';
import { Favoris } from 'src/favoris/entities/favoris.entity';
import { Recipe } from 'src/recipes/entities/recipe.entity';

export class CreateUserDto {
  @ApiProperty()
  username: string;

  @ApiProperty()
  password_hash: string;

  @ApiProperty()
  email: string;

  @ApiProperty()
  recipes: Recipe[];

  @ApiProperty()
  favoris: Favoris[];
}
