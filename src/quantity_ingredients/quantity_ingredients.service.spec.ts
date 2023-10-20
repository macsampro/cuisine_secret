import { Test, TestingModule } from '@nestjs/testing';
import { QuantityIngredientsService } from './quantity_ingredients.service';

describe('QuantityIngredientsService', () => {
  let service: QuantityIngredientsService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [QuantityIngredientsService],
    }).compile();

    service = module.get<QuantityIngredientsService>(
      QuantityIngredientsService,
    );
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
