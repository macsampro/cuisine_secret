import { Injectable } from '@nestjs/common';
import { CreateRecipeDto } from './dto/create-recipe.dto';
// import { UpdateRecipeDto } from './dto/update-recipe.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/users/entities/user.entity';
import { Repository } from 'typeorm';
import { Recipe } from './entities/recipe.entity';
import { QuantityIngredient } from 'src/quantity_ingredients/entities/quantity_ingredient.entity';

@Injectable()
export class RecipesService {
  constructor(
    @InjectRepository(User) private userRepository: Repository<User>,
    @InjectRepository(Recipe) private recipeRepository: Repository<Recipe>,
    @InjectRepository(QuantityIngredient)
    private quantityIgredientRepository: Repository<QuantityIngredient>,
  ) {}

  async create(createRecipeDto: CreateRecipeDto) {
    const recipes = this.recipeRepository.create(createRecipeDto);
    const result = await this.recipeRepository.save(recipes);
    return result;
  }

  async findAll() {
    return await this.recipeRepository.find();
  }

  findOne(id: number) {
    return `This action returns a #${id} recipe`;
  }

  // update(id: number, updateRecipeDto: UpdateRecipeDto) {
  //   return `This action updates a #${id} recipe`;
  // }

  remove(id: number) {
    return `This action removes a #${id} recipe`;
  }
}
