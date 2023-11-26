import { Recipe } from 'src/recipes/entities/recipe.entity';
import { Column, Entity, JoinColumn, ManyToOne, PrimaryColumn } from 'typeorm';

@Entity({ name: 'photos' })
export class Photo {
  @PrimaryColumn()
  id_photo: number;

  @Column()
  name: string;

  @Column()
  description: string;

  @Column()
  size: number;

  @Column()
  mimetype: string;

  // @Column()
  // id_recipe: number;

  @ManyToOne(() => Recipe, (recipe) => recipe.id_photo, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'id_recipe', referencedColumnName: 'id_recipe' })
  recipe: Recipe;
}
