import { Controller, Get, Param, Delete, Post, Body } from '@nestjs/common';
import { FavorisService } from './favoris.service';
import { CreateFavorisDto } from './dto/create-favoris.dto';

@Controller('favoris')
export class FavorisController {
  constructor(private readonly favorisService: FavorisService) {}

  @Post()
  create(@Body() createFavorisDto: CreateFavorisDto) {
    return this.favorisService.create(createFavorisDto);
  }
  @Get()
  findAll() {
    return this.favorisService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.favorisService.findOne(+id);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.favorisService.remove(+id);
  }
}
