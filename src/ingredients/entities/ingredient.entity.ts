import { Recipe } from 'src/recipes/entities/recipe.entity';
import { Column, Entity, ManyToMany, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ name: 'ingredients' })
export class Ingredient {
  @PrimaryGeneratedColumn()
  id_ingredient: number;

  @Column()
  ingredient_name: string;

  @Column()
  ingredient_type: string;

  @ManyToMany(() => Recipe, (recipe) => recipe.ingredient)
  recipe?: Recipe[];
}
