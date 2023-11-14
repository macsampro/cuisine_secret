import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateQuantityIngredientDto } from './dto/create-quantity_ingredient.dto';
import { QuantityIngredient } from './entities/quantity_ingredient.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

@Injectable()
export class QuantityIngredientsService {
  constructor(
    @InjectRepository(QuantityIngredient)
    private quantityIngredientRepository: Repository<QuantityIngredient>,
  ) {}

  async create(createQuantityIngredientDto: CreateQuantityIngredientDto) {
    const newQuantityIngredient = this.quantityIngredientRepository.create(
      createQuantityIngredientDto,
    );
    const result = await this.quantityIngredientRepository.save(
      newQuantityIngredient,
    );
    return result;
  }

  async findAll() {
    return await this.quantityIngredientRepository.find();
  }

  findOne(id: number) {
    return `This action returns a #${id} quantityIngredient`;
  }

  // update(id: number, updateQuantityIngredientDto: UpdateQuantityIngredientDto) {
  //   return `This action updates a #${id} quantityIngredient`;
  // }

  async remove(id: number) {
    const ingredientFind = await this.quantityIngredientRepository.find({
      where: { id_ingredient: id },
    });

    if (!ingredientFind) {
      throw new NotFoundException(`l'id numéro ${id} n'existe pas !`);
    }
    return await this.quantityIngredientRepository.remove(ingredientFind);
  }
}
