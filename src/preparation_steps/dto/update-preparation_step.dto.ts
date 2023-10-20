import { PartialType } from '@nestjs/swagger';
import { CreatePreparationStepDto } from './create-preparation_step.dto';

export class UpdatePreparationStepDto extends PartialType(CreatePreparationStepDto) {}
