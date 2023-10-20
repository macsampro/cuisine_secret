import {
  ConflictException,
  Injectable,
  InternalServerErrorException,
  UnauthorizedException,
} from '@nestjs/common';
import { CreateAuthDto } from './dto/create-auth.dto';
import * as bcrypt from 'bcrypt';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/users/entities/user.entity';
import { Repository } from 'typeorm';
import { LoginDto } from './dto/loging.dot';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(User)
    private userRepository: Repository<User>,
    private jwtService: JwtService,
  ) {}

  async register(createAuthDto: CreateAuthDto) {
    const { username, password_hash, email } = createAuthDto;

    // hashage du mot de passe
    const salt = await bcrypt.genSalt();
    const hashedPassword = await bcrypt.hash(password_hash, salt);

    // création d'une entité user
    const user = this.userRepository.create({
      username,
      password_hash: hashedPassword,
      email,
    });

    try {
      // enregistrement de l'entité user
      const createdUser = await this.userRepository.save(user);
      delete createdUser.password_hash;
      return createdUser;
    } catch (error) {
      // gestion des erreurs
      if (error.code === '23505') {
        throw new ConflictException('username already exists');
      } else {
        throw new InternalServerErrorException();
      }
    }
  }

  async login(loginDto: LoginDto) {
    console.log(loginDto);
    // const { username, password_hash } = loginDto;
    const user = await this.userRepository.findOne({
      where: { username: loginDto.username },
    });
    console.log(user);
    console.log(loginDto.password_hash);
    console.log(user.password_hash);
    const resultcompart = await bcrypt.compare(
      loginDto.password_hash,
      user.password_hash,
    );

    if (user && resultcompart) {
      console.log('11');

      const payload = {
        username: user.username,
        id_user: user.id_user,
        // sub: user.username,
      };
      const accessToken = this.jwtService.sign(payload);
      return { accessToken, user_id: user.id_user, username: user.username };
    } else {
      throw new UnauthorizedException('identification incorecte');
    }
  }
}
