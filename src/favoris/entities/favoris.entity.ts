import { Recipe } from 'src/recipes/entities/recipe.entity';
import { User } from 'src/users/entities/user.entity';
import { Entity, JoinColumn, ManyToOne, PrimaryColumn } from 'typeorm';

@Entity({ name: 'favoris' })
export class Favoris {
  @PrimaryColumn()
  id_user!: number;

  @PrimaryColumn()
  id_recipe: number;

  @ManyToOne(() => User, (user) => user.recipe_favoris)
  @JoinColumn({ name: 'id_user', referencedColumnName: 'id_user' })
  user: User[];

  @ManyToOne(() => Recipe, (recipe) => recipe.user_favoris)
  @JoinColumn({ name: 'id_recipe', referencedColumnName: 'id_recipe' })
  recipe: Recipe[];
}
