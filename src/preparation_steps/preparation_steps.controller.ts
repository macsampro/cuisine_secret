import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { PreparationStepsService } from './preparation_steps.service';
import { CreatePreparationStepDto } from './dto/create-preparation_step.dto';
import { UpdatePreparationStepDto } from './dto/update-preparation_step.dto';

@Controller('preparation-steps')
export class PreparationStepsController {
  constructor(
    private readonly preparationStepsService: PreparationStepsService,
  ) {}

  @Post()
  create(@Body() createPreparationStepDto: CreatePreparationStepDto) {
    return this.preparationStepsService.create(createPreparationStepDto);
  }

  @Get()
  findAll() {
    return this.preparationStepsService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.preparationStepsService.findOne(+id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updatePreparationStepDto: UpdatePreparationStepDto,
  ) {
    return this.preparationStepsService.update(+id, updatePreparationStepDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.preparationStepsService.remove(+id);
  }
}
