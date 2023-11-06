import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { User } from './entities/user.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Recipe } from 'src/recipes/entities/recipe.entity';
import { Favoris } from 'src/favoris/entities/favoris.entity';
import { PreparationStep } from 'src/preparation_steps/entities/preparation_step.entity';

@Module({
  imports: [TypeOrmModule.forFeature([User, Recipe, Favoris, PreparationStep])],

  controllers: [UsersController],
  providers: [UsersService],
  exports: [TypeOrmModule.forFeature([User])],
})
export class UsersModule {}
