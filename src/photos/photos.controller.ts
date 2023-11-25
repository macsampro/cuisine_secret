import {
  Controller,
  Get,
  Post,
  Param,
  UseInterceptors,
  UploadedFile,
  StreamableFile,
  Res,
  NotFoundException,
  Req,
  Body,
} from '@nestjs/common';
import { Response } from 'express';
import { PhotosService } from './photos.service';
import { join } from 'path'; // Import pour accéder aux chemins de fichiers
import { createReadStream } from 'fs'; // Import pour créer un stream de fichier
import { FileInterceptor } from '@nestjs/platform-express';

@Controller('photos')
export class PhotosController {
  constructor(private readonly photosService: PhotosService) {}

  @Post()
  @UseInterceptors(FileInterceptor('monFichier'))
  async uploadImage(
    @UploadedFile() file: Express.Multer.File,
    @Req() req,
    @Body('recipeId') recipeId: number,
  ) {
    console.log('id de la recette', recipeId);

    // console.log(
    //   'ce que je cherche ',
    //   await this.photosService.create(file, recipeId),
    // );

    if (!recipeId) {
      throw new NotFoundException('ID de recette non fourni');
    }
    console.log('ID de recette reçu:', recipeId);

    return await this.photosService.create(file, recipeId);
  }

  @Get()
  // @UseGuards(AuthGuard('jwt'))
  async getPhotos(@Res({ passthrough: true }) res): Promise<StreamableFile> {
    return this.photosService.getPhotos(res);
  }

  @Get(':id')
  // @UseGuards(AuthGuard('jwt'))
  getPhotoById(
    @Param('id') id: string,
    @Res({ passthrough: true }) res,
  ): Promise<StreamableFile> {
    return this.photosService.getPhotoById(+id, res);
  }

  @Get('/recipes/:recipeId')
  async getPhotoByRecipeId(
    @Param('recipeId') recipeId: number,
    @Res({ passthrough: true }) res: Response, // Utilisez le décorateur @Res() pour injecter la réponse express
  ): Promise<StreamableFile> {
    const photo = await this.photosService.findPhotoByRecipeId(recipeId);
    if (!photo) {
      throw new NotFoundException('Photo not found');
    }
    // Utilisez le chemin du répertoire de travail actuel et le nom du fichier pour créer un chemin complet
    const file = createReadStream(join(process.cwd(), 'uploads', photo.name));
    // Définissez les en-têtes de la réponse pour indiquer le type de contenu et un nom de fichier
    res.set({
      'Content-Type': photo.mimetype,
      'Content-Disposition': `attachment; filename="${photo.name}"`,
    });
    // Retournez un StreamableFile qui permettra au client de télécharger ou d'afficher l'image
    return new StreamableFile(file);
  }
}
