import { Recipe } from 'src/recipes/entities/recipe.entity';
import {
  Column,
  Entity,
  JoinTable,
  ManyToMany,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity({ name: 'users' })
export class User {
  @PrimaryGeneratedColumn()
  id_user!: number;

  @Column()
  username: string;

  @Column()
  email: string;

  @Column()
  password_hash: string;

  @OneToMany(() => Recipe, (recipe) => recipe.user, { eager: true })
  recipes: Recipe[];

  @ManyToMany(() => Recipe, (recipe) => recipe.user_favoris, { eager: true })
  @JoinTable({
    name: 'favoris',
    joinColumn: {
      name: 'id_user',
      referencedColumnName: 'id_user',
    },
    inverseJoinColumn: {
      name: 'id_recipe',
      referencedColumnName: 'id_recipe',
    },
  })
  recipe_favoris?: Recipe[];
}
