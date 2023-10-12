import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

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
}
