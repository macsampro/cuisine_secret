// import { Ingredient } from 'src/ingredients/entities/ingredient.entity';
// import { Recipe } from 'src/recipes/entities/recipe.entity';
import { Ingredient } from 'src/ingredients/entities/ingredient.entity';
import { Recipe } from 'src/recipes/entities/recipe.entity';
import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity({ name: 'quantity_ingredients' })
export class QuantityIngredient {
  @PrimaryGeneratedColumn()
  id_quantity_ingredients: number;

  @Column()
  quantity: number;

  @Column({ type: 'varchar', length: 255 })
  unit: string;

  @Column()
  id_recipe: number;

  @Column()
  id_ingredient: number;

  @ManyToOne(() => Recipe, (recipe) => recipe.ingredient)
  @JoinColumn({ name: 'id_recipe', referencedColumnName: 'id_recipe' })
  recipe: Recipe[];

  @ManyToOne(() => Ingredient, (ingredient) => ingredient.recipe)
  @JoinColumn([
    { name: 'id_ingredient', referencedColumnName: 'id_ingredient' },
  ])
  ingredients: Ingredient[];
}
