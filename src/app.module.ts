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
import { QuantityIngredientsModule } from './quantity_ingredients/quantity_ingredients.module';
import { QuantityIngredient } from './quantity_ingredients/entities/quantity_ingredient.entity';
import { ServeStaticModule } from '@nestjs/serve-static';
import { join } from 'path';

@Module({
  imports: [
    ServeStaticModule.forRoot({
      rootPath: join(__dirname, '..', 'uploads'), // 'uploads' est le dossier où vous stockez les fichiers
    }),
    ConfigModule.forRoot({ envFilePath: [`.env`] }),
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: process.env.POSTGRES_HOST,
      port: +process.env.POSTGRES_PORT,
      username: process.env.POSTGRES_USER,
      password: process.env.POSTGRES_PASSWORD,
      database: process.env.POSTGRES_DATABASE,
      entities: [
        User,
        Recipe,
        QuantityIngredient,
        PreparationStep,
        Photo,
        Ingredient,
        Favoris,
      ],
      synchronize: false,
      logging: false,
    }),

    UsersModule,
    AuthModule,
    RecipesModule,
    PhotosModule,
    FavorisModule,
    QuantityIngredientsModule,
    IngredientsModule,
    PreparationStepsModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
