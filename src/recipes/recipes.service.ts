import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateRecipeDto } from './dto/create-recipe.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/users/entities/user.entity';
import { Repository } from 'typeorm';
import { Recipe } from './entities/recipe.entity';
import { QuantityIngredient } from 'src/quantity_ingredients/entities/quantity_ingredient.entity';
import { PreparationStep } from 'src/preparation_steps/entities/preparation_step.entity';
import { UpdateRecipeDto } from './dto/update-recipe.dto';

@Injectable()
export class RecipesService {
  constructor(
    @InjectRepository(User)
    private userRepository: Repository<User>,
    @InjectRepository(Recipe)
    private recipeRepository: Repository<Recipe>,
    @InjectRepository(QuantityIngredient)
    private quantityIgredientRepository: Repository<QuantityIngredient>,
    @InjectRepository(PreparationStep)
    private preparationStep: Repository<PreparationStep>,
  ) {}

  /**
   * Méthode qui permet
   * de faire ce que je
   */
  async create(createRecipeDto: CreateRecipeDto) {
    const recipes = this.recipeRepository.create(createRecipeDto);
    const result = await this.recipeRepository.save(recipes);
    return result;
  }

  async findAll() {
    return await this.recipeRepository.find();
  }

  async findOne(id_recipe: number) {
    const found = await this.recipeRepository.findOneBy({
      id_recipe,
    });
    if (!found) {
      throw new NotFoundException(
        `The species id number ${id_recipe} is not found !`,
      );
    }
    return found;
  }

  async update(id_recipe: number, updateRecipeDto: UpdateRecipeDto) {
    // 1 - récupérer la recette dans la BDD en fonction de son id
    const recipToUpdat = await this.findOne(id_recipe);

    // 2 - Fusionner l'objet recupérer dans la BDD avec les changements du DTO (spread operator)
    const fusionRecipes: Recipe = { ...recipToUpdat, ...updateRecipeDto };
    console.log(fusionRecipes);

    // 3 - Sauvegarder les modification en BDD (save)
    return await this.recipeRepository.save(fusionRecipes);
  }

  async remove(id_recipe: number) {
    const recipeToRemove = await this.findOne(id_recipe);
    if (!recipeToRemove) {
      throw new Error(`The recipe with id number: ${id_recipe} is not found !`);
    }
    await this.recipeRepository.remove(recipeToRemove);
    return {
      message: `the recipe ${recipeToRemove.id_recipe} is delet !`,
    };
  }
}
