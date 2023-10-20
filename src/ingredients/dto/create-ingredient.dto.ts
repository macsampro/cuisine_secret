import { ApiProperty } from '@nestjs/swagger';

export class CreateIngredientDto {
  @ApiProperty()
  id_ingredient: number;

  @ApiProperty()
  ingredient_name: string;

  @ApiProperty()
  ingredient_type: string;
}
