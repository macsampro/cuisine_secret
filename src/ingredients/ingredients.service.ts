import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateIngredientDto } from './dto/create-ingredient.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Ingredient } from './entities/ingredient.entity';
import { Repository } from 'typeorm';

@Injectable()
export class IngredientsService {
  constructor(
    @InjectRepository(Ingredient)
    private ingredientRepository: Repository<Ingredient>,
  ) {}

  async create(createIngredientDto: CreateIngredientDto) {
    const newingredient = this.ingredientRepository.create(createIngredientDto);
    const result = await this.ingredientRepository.save(newingredient);
    return result;
  }

  async findAll() {
    return await this.ingredientRepository.find();
  }

  findOne(id: number) {
    return `This action returns a #${id} ingredient`;
  }

  // update(id: number, updateIngredientDto: UpdateIngredientDto) {
  //   return `This action updates a #${id} ingredient`;
  // }

  async remove(id: number) {
    const ingredientFind = await this.ingredientRepository.find({
      where: { id_ingredient: id },
    });

    if (!ingredientFind) {
      throw new NotFoundException(`l'id numéro ${id} n'existe pas !`);
    }
    return await this.ingredientRepository.remove(ingredientFind);
  }
}
