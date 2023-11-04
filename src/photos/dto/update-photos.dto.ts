import { PartialType } from '@nestjs/swagger';
import { CreatePhotosDto } from './create-photos.dto';

export class UpdatePreparationStepDto extends PartialType(CreatePhotosDto) {}
