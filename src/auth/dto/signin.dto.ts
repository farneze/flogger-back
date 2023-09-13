import { IsEmail, IsNotEmpty, IsString } from 'class-validator';

export class AuthSigninDto {
  @IsEmail()
  @IsString()
  email: string;

  @IsNotEmpty()
  @IsString()
  password: string;
}
