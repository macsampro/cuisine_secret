import { Injectable, NotFoundException, StreamableFile } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Photo } from './entities/photo.entity';
import { Repository } from 'typeorm';
import { join } from 'path';
import { createReadStream } from 'fs';
import { Recipe } from 'src/recipes/entities/recipe.entity';

@Injectable()
export class PhotosService {
  constructor(
    @InjectRepository(Photo) private photoRepository: Repository<Photo>,
    @InjectRepository(Recipe) private recipeRepository: Repository<Recipe>,
  ) {}

  create(img: Express.Multer.File, id: number) {
    console.log('notre img' + img);
    return this.photoRepository.save({
      name: img.filename,
      mimetype: img.mimetype,
      size: img.size,
      description: img.originalname,
      recipe: { id_recipe: id },
    });
  }

  async getPhotos(res): Promise<StreamableFile> {
    const result = await this.photoRepository.find();
    console.log(result);
    let imageFile;
    const imageTab = [];
    for (let i = 0; i < result.length; i++) {
      imageFile = createReadStream(
        join(process.cwd(), 'uploads', result[i].name),
      );
      res.set('Content-Type', result[i].mimetype);
      imageTab.push(imageFile);
    }
    console.log(imageTab[imageFile]);
    return new StreamableFile(imageFile);
  }

  async getPhotoById(id_photo: number, res): Promise<StreamableFile> {
    // Cherche la photo dans la base de données par son ID.
    const photo = await this.photoRepository.findOneBy({ id_photo });
    // Si la photo n'est pas trouvée, lance une exception 'NotFoundException'.
    if (!photo) {
      throw new NotFoundException(`The photo ${id_photo} is not found !`);
    }
    // Construit le chemin complet du fichier image.
    const filePath = join(process.cwd(), 'uploads', photo.name);
    // Crée un flux de lecture pour le fichier image.
    const imageFile = createReadStream(filePath);
    // Définit le type de contenu de la réponse basé sur le mimetype de l'image.
    res.set('Content-Type', photo.mimetype);
    // Retourne le fichier image en tant que StreamableFile.
    return new StreamableFile(imageFile);
  }
  async findPhotoByRecipeId(recipeId: number): Promise<Photo> {
    const photo = await this.photoRepository.findOne({
      where: { recipe: { id_recipe: recipeId } },
    });
    return photo;
  }
}
