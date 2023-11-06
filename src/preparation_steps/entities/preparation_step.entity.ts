import { Recipe } from 'src/recipes/entities/recipe.entity';
import { Column, Entity, JoinColumn, ManyToOne, PrimaryColumn } from 'typeorm';

@Entity({ name: 'preparation_steps' })
export class PreparationStep {
  @PrimaryColumn()
  id_preparation_step: number;

  @Column()
  description: string;

  @Column()
  // @JoinColumn({ name: 'order_step' })
  order_step: number;

  @Column()
  id_recipe: number;

  @ManyToOne(() => Recipe, (recipe) => recipe.preparation_step)
  @JoinColumn({ name: 'id_recipe', referencedColumnName: 'id_recipe' })
  recipe: Recipe;
}
