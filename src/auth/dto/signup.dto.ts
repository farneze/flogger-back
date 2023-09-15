import { IsNotEmpty, IsOptional, IsString, IsEmail } from 'class-validator';

export class AuthSignupDto {
  @IsNotEmpty()
  @IsString()
  login: string;

  @IsNotEmpty()
  @IsString()
  password: string;

  @IsOptional()
  @IsString()
  firstname?: string;

  @IsOptional()
  @IsString()
  lastname?: string;

  @IsOptional()
  @IsString()
  nickname?: string;

  @IsOptional()
  @IsEmail()
  @IsString()
  email?: string;
}
