import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './users/entities/user.entity';
import { UsersModule } from './users/users.module';
import { AuthModule } from './auth/auth.module';
import { RecipesModule } from './recipes/recipes.module';
import { PhotosModule } from './photos/photos.module';
import { FavorisModule } from './favoris/favoris.module';
import { IngredientsModule } from './ingredients/ingredients.module';
import { PreparationStepsModule } from './preparation_steps/preparation_steps.module';
import { Recipe } from './recipes/entities/recipe.entity';
import { PreparationStep } from './preparation_steps/entities/preparation_step.entity';
import { Photo } from './photos/entities/photo.entity';
import { Ingredient } from './ingredients/entities/ingredient.entity';
import { Favoris } from './favoris/entities/favoris.entity';

@Module({
  imports: [
    ConfigModule.forRoot({ envFilePath: [`.env`] }),
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: process.env.POSTGRES_HOST,
      port: +process.env.POSTGRES_PORT,
      username: process.env.POSTGRES_USER,
      password: process.env.POSTGRES_PASSWORD,
      database: process.env.POSTGRES_DATABASE,
      entities: [User, Recipe, PreparationStep, Photo, Ingredient, Favoris],
      synchronize: false,
      logging: false,
    }),

    UsersModule,
    AuthModule,
    RecipesModule,
    PhotosModule,
    FavorisModule,
    IngredientsModule,
    PreparationStepsModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
