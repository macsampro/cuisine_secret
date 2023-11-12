import { Injectable, NotFoundException, StreamableFile } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Photo } from './entities/photo.entity';
import { Repository } from 'typeorm';
import { join } from 'path';
import { createReadStream } from 'fs';

@Injectable()
export class PhotosService {
  constructor(
    @InjectRepository(Photo) private photoRepository: Repository<Photo>,
  ) {}

  create(img: Express.Multer.File) {
    console.log('notre img' + img.originalname);
    return this.photoRepository.save({
      name: img.filename,
      mimetype: img.mimetype,
      size: img.size,
      description: img.originalname,
    });
  }

  async getPhotos(res): Promise<StreamableFile> {
    const result = await this.photoRepository.find();
    console.log(result);
    let imageFile;
    const imageTab = [];
    // const lastResult = result[result.length - 1];
    // console.log(lastResult);
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
    const result = await this.photoRepository.findOneBy({ id_photo });
    if (!result) {
      throw new NotFoundException(`The photo ${id_photo} is not found !`);
    }
    const imageFile = createReadStream(
      join(process.cwd(), 'uploads', result.name),
    );
    res.set('Content-Type', result.mimetype);
    console.log('mon image', imageFile);
    return new StreamableFile(imageFile);
  }

  async findPhotoByRecipeId(recipeId: number): Promise<Photo> {
    const photo = await this.photoRepository.findOne({
      where: { id_recipe: recipeId },
    });
    return photo;
  }
}
