import { PartialType } from '@nestjs/swagger';
import { CreateQuantityIngredientDto } from './create-quantity_ingredient.dto';

export class UpdateQuantityIngredientDto extends PartialType(
  CreateQuantityIngredientDto,
) {}
