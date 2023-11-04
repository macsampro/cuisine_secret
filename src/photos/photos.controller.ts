import {
  Controller,
  Get,
  Post,
  Param,
  UseInterceptors,
  UploadedFile,
  StreamableFile,
  Res,
} from '@nestjs/common';
import { PhotosService } from './photos.service';

import { FileInterceptor } from '@nestjs/platform-express';

@Controller('photos')
export class PhotosController {
  constructor(private readonly photosService: PhotosService) {}

  @Post()
  @UseInterceptors(FileInterceptor('monFichier'))
  uploadImage(@UploadedFile() file: Express.Multer.File) {
    return this.photosService.create(file);
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
}
