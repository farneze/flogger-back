import { IsNotEmpty, IsString } from 'class-validator';

export class AuthSigninDto {
  @IsNotEmpty()
  @IsString()
  login: string;

  @IsNotEmpty()
  @IsString()
  password: string;
}
