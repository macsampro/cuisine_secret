import { Module } from '@nestjs/common';
import { FavorisService } from './favoris.service';
import { FavorisController } from './favoris.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Favoris } from './entities/favoris.entity';
import { User } from 'src/users/entities/user.entity';
import { Recipe } from 'src/recipes/entities/recipe.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Favoris, User, Recipe])],

  controllers: [FavorisController],
  providers: [FavorisService],
})
export class FavorisModule {}
