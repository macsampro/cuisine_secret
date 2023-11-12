import { Difficulty, RecipeType } from 'src/enums/recipe.enums';
import { Ingredient } from 'src/ingredients/entities/ingredient.entity';
import { Photo } from 'src/photos/entities/photo.entity';
import { PreparationStep } from 'src/preparation_steps/entities/preparation_step.entity';
import { User } from 'src/users/entities/user.entity';
import {
  Column,
  Entity,
  JoinColumn,
  JoinTable,
  ManyToMany,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity({ name: 'recipes' })
export class Recipe {
  @PrimaryGeneratedColumn()
  id_recipe: number;

  @Column({ type: 'varchar', length: 255 })
  title: string;

  @Column({ type: 'enum', enum: RecipeType })
  recipe_type: string;

  @Column({ type: 'varchar', length: 255 })
  description: string;

  @Column({ type: 'time' })
  time_preparation: Date;

  @Column({ type: 'enum', enum: Difficulty })
  difficulty: string;

  @Column({ type: 'date' })
  creation_date: Date;

  @Column({ type: 'int' })
  id_user: number;

  @ManyToOne(() => User, (user) => user.id_user)
  @JoinColumn({ name: 'id_user' })
  user: User;

  @ManyToMany(() => Ingredient, (ingredient) => ingredient.recipe, {
    eager: true,
  })
  @JoinTable({
    name: 'quantity_ingredients',
    joinColumn: {
      name: 'id_recipe',
      referencedColumnName: 'id_recipe',
    },
    inverseJoinColumn: {
      name: 'id_ingredient',
      referencedColumnName: 'id_ingredient',
    },
  })
  ingredient?: Ingredient[];

  @ManyToMany(() => User, (user) => user.recipe_favoris)
  user_favoris?: User[];

  @OneToMany(() => Photo, (photo) => photo.recipe, { eager: true })
  id_photo?: Photo;

  @OneToMany(
    () => PreparationStep,
    (preparation_step) => preparation_step.recipe,
    { eager: true },
  )
  preparation_step?: PreparationStep;
}
