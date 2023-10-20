import { Test, TestingModule } from '@nestjs/testing';
import { PreparationStepsController } from './preparation_steps.controller';
import { PreparationStepsService } from './preparation_steps.service';

describe('PreparationStepsController', () => {
  let controller: PreparationStepsController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [PreparationStepsController],
      providers: [PreparationStepsService],
    }).compile();

    controller = module.get<PreparationStepsController>(PreparationStepsController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
