import { Injectable } from '@nestjs/common';
import { CreatePreparationStepDto } from './dto/create-preparation_step.dto';
import { UpdatePreparationStepDto } from './dto/update-preparation_step.dto';

@Injectable()
export class PreparationStepsService {
  create(createPreparationStepDto: CreatePreparationStepDto) {
    return 'This action adds a new preparationStep';
  }

  findAll() {
    return `This action returns all preparationSteps`;
  }

  findOne(id: number) {
    return `This action returns a #${id} preparationStep`;
  }

  update(id: number, updatePreparationStepDto: UpdatePreparationStepDto) {
    return `This action updates a #${id} preparationStep`;
  }

  remove(id: number) {
    return `This action removes a #${id} preparationStep`;
  }
}
