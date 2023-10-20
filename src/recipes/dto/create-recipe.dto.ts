import { ApiProperty } from '@nestjs/swagger';
import { Favoris } from 'src/favoris/entities/favoris.entity';
import { QuantityIngredient } from 'src/quantity_ingredients/entities/quantity_ingredient.entity';

export class CreateRecipeDto {
  @ApiProperty()
  id_recipe: number;

  @ApiProperty()
  title: string;

  @ApiProperty()
  description: string;

  @ApiProperty()
  time_preparation: Date;

  @ApiProperty()
  difficulty: string;

  @ApiProperty()
  creation_date: Date;

  @ApiProperty()
  id_user: number;

  @ApiProperty()
  quantityIngredients: QuantityIngredient[];

  @ApiProperty()
  favoris: Favoris[];
}
