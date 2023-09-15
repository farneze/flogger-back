import { IsNotEmpty, IsString, Max } from 'class-validator';

export class AuthSigninDto {
  @IsNotEmpty()
  @IsString()
  @Max(20)
  login: string;

  @IsNotEmpty()
  @IsString()
  @Max(50)
  password: string;
}
