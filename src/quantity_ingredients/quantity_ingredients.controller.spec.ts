import { Test, TestingModule } from '@nestjs/testing';
import { QuantityIngredientsController } from './quantity_ingredients.controller';
import { QuantityIngredientsService } from './quantity_ingredients.service';

describe('QuantityIngredientsController', () => {
  let controller: QuantityIngredientsController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [QuantityIngredientsController],
      providers: [QuantityIngredientsService],
    }).compile();

    controller = module.get<QuantityIngredientsController>(QuantityIngredientsController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
