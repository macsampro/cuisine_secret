import { Module } from '@nestjs/common';
import { PreparationStepsService } from './preparation_steps.service';
import { PreparationStepsController } from './preparation_steps.controller';

@Module({
  controllers: [PreparationStepsController],
  providers: [PreparationStepsService],
})
export class PreparationStepsModule {}
