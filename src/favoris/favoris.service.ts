import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Favoris } from './entities/favoris.entity';
import { CreateFavorisDto } from './dto/create-favoris.dto';

@Injectable()
export class FavorisService {
  constructor(
    @InjectRepository(Favoris)
    private favorisRepository: Repository<Favoris>,
  ) {}

  async create(createFavorisDto: CreateFavorisDto) {
    const newFavoris = this.favorisRepository.create(createFavorisDto);
    const result = await this.favorisRepository.save(newFavoris);
    return result;
  }

  findAll() {
    return this.favorisRepository.find();
  }

  findOne(id: number) {
    return `This action returns a #${id} favoris`;
  }

  remove(id: number) {
    return `This action removes a #${id} favoris`;
  }
}
