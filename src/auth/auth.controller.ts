import { Controller, Post, Body, HttpCode, HttpStatus } from '@nestjs/common';
import { AuthService } from './auth.service';
import { CreateAuthDto } from './dto/create-auth.dto';
import { LoginDto } from './dto/loging.dot';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('register')
  @HttpCode(HttpStatus.CREATED) // Spécifi le code de statut HTTP pour la création réussie
  create(@Body() createAuthDto: CreateAuthDto) {
    // Appele le service pour enregistrer un nouvel utilisateur
    return this.authService.register(createAuthDto);
  }

  @Post('login')
  @HttpCode(HttpStatus.OK) // Spécifi le code de statut HTTP pour une réponse réussie
  login(@Body() loginDto: LoginDto): Promise<{ accessToken: string }> {
    // Appel le service pour connecter un utilisateur
    return this.authService.login(loginDto);
  }
}
