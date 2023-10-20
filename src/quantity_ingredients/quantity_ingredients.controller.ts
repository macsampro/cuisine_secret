import { Controller, Get, Post, Body, Param, Delete } from '@nestjs/common';
import { QuantityIngredientsService } from './quantity_ingredients.service';
import { CreateQuantityIngredientDto } from './dto/create-quantity_ingredient.dto';

@Controller('quantity-ingredients')
export class QuantityIngredientsController {
  constructor(
    private readonly quantityIngredientsService: QuantityIngredientsService,
  ) {}

  @Post()
  create(@Body() createQuantityIngredientDto: CreateQuantityIngredientDto) {
    return this.quantityIngredientsService.create(createQuantityIngredientDto);
  }

  @Get()
  findAll() {
    return this.quantityIngredientsService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.quantityIngredientsService.findOne(+id);
  }

  // @Patch(':id')
  // update(
  //   @Param('id') id: string,
  //   @Body() updateQuantityIngredientDto: UpdateQuantityIngredientDto,
  // ) {
  //   return this.quantityIngredientsService.update(
  //     +id,
  //     updateQuantityIngredientDto,
  //   );
  // }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.quantityIngredientsService.remove(+id);
  }
}
