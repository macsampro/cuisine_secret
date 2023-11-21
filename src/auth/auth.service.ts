import {
  BadRequestException,
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

    // Valider que le mot de passe est fourni
    if (!password_hash) {
      throw new BadRequestException('Le mot de passe est requis');
    }

    // hashage du mot de passe
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password_hash, salt);

    // Création de l'utilisateur
    const user = this.userRepository.create({
      username,
      password_hash: hashedPassword,
      email,
    });

    try {
      // Enregistrement de l'utilisateur
      const createdUser = await this.userRepository.save(user);
      delete createdUser.password_hash; // Retirer le hash du mot de passe avant de retourner l'utilisateur
      return createdUser;
    } catch (error) {
      // Gestion des erreurs de base de données
      if (error.code === '23505') {
        throw new ConflictException('username already exists');
      } else {
        throw new InternalServerErrorException();
      }
    }
  }

  async login(loginDto: LoginDto) {
    console.log(loginDto);
    // Recherche de l'utilisateur par le nom d'utilisateur
    const user = await this.userRepository.findOne({
      where: { username: loginDto.username },
    });
    const resultcompart = await bcrypt.compare(
      loginDto.password_hash,
      user.password_hash,
    );

    // Si l'utilisateur existe et que le mot de passe correspond
    if (user && resultcompart) {
      console.log('11');

      const payload = {
        username: user.username,
        id_user: user.id_user,
        // sub: user.username,
      };
      const accessToken = this.jwtService.sign(payload); // Génération du token JWT
      return { accessToken, user_id: user.id_user, username: user.username };
    } else {
      // Lève une exception si l'authentification échoue
      throw new UnauthorizedException('identification incorecte');
    }
  }
}
