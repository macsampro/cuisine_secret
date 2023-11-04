import { Recipe } from 'src/recipes/entities/recipe.entity';
import { Column, Entity, JoinColumn, ManyToOne, PrimaryColumn } from 'typeorm';

@Entity({ name: 'preparation_step' })
export class PreparationStep {
  @PrimaryColumn()
  id_preparation_step: number;

  @Column()
  description: string;

  @Column()
  order: number;

  @Column()
  id_recipe: number;

  @ManyToOne(() => Recipe, (recipe) => recipe.id_preparation_step)
  @JoinColumn({ name: 'id_recipe', referencedColumnName: 'id_recipe' })
  recipe: Recipe;
}
