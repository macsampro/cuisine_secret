import { Test, TestingModule } from '@nestjs/testing';
import { PreparationStepsService } from './preparation_steps.service';

describe('PreparationStepsService', () => {
  let service: PreparationStepsService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [PreparationStepsService],
    }).compile();

    service = module.get<PreparationStepsService>(PreparationStepsService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
