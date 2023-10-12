import { ApiProperty } from '@nestjs/swagger';

export class CreateUserDto {
  @ApiProperty()
  username: string;

  @ApiProperty()
  password_hash: string;

  @ApiProperty()
  email: string;
}
