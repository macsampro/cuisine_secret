import { Injectable, NotFoundException } from '@nestjs/common';
import { CreatePreparationStepDto } from './dto/create-preparation_step.dto';
import { UpdatePreparationStepDto } from './dto/update-preparation_step.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Recipe } from 'src/recipes/entities/recipe.entity';
import { User } from 'src/users/entities/user.entity';
import { QuantityIngredient } from 'src/quantity_ingredients/entities/quantity_ingredient.entity';
import { Repository } from 'typeorm';
import { PreparationStep } from './entities/preparation_step.entity';

@Injectable()
export class PreparationStepsService {
  constructor(
    @InjectRepository(PreparationStep)
    private preparationStepRepository: Repository<PreparationStep>,
    @InjectRepository(User)
    private userRepository: Repository<User>,
    @InjectRepository(Recipe)
    private recipeRepository: Repository<Recipe>,
    @InjectRepository(QuantityIngredient)
    private quantityIgredientRepository: Repository<QuantityIngredient>,
  ) {}

  async create(createPreparationStepDto: CreatePreparationStepDto) {
    const newPreparationStep = this.preparationStepRepository.create(
      createPreparationStepDto,
    );
    const result =
      await this.preparationStepRepository.save(newPreparationStep);
    return result;
  }

  async findAll() {
    return await this.preparationStepRepository.find();
  }

  async findOne(id_preparation_step: number) {
    const found = await this.preparationStepRepository.findOneBy({
      id_preparation_step,
    });
    if (!found) {
      throw new NotFoundException(
        `The species id number ${id_preparation_step} is not found !`,
      );
    }
    return found;
  }

  async update(
    id_preparation_step: number,
    updatePreparationStepDto: UpdatePreparationStepDto,
  ) {
    await this.preparationStepRepository.update(
      id_preparation_step,
      updatePreparationStepDto,
    );
    return this.findOne(id_preparation_step);
  }

  async remove(id_preparation_step: number) {
    const preparationStepToRemove = await this.findOne(id_preparation_step);
    if (!preparationStepToRemove) {
      throw new Error(
        `The preparation step with id number: ${id_preparation_step} is not found !`,
      );
    }
    await this.preparationStepRepository.remove(preparationStepToRemove);

    return {
      message: `the preparation step ${preparationStepToRemove.id_preparation_step} is delet !`,
    };
  }
}
