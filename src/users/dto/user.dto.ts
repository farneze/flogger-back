import { IsOptional, IsString, IsEmail } from 'class-validator';

export class UserDto {
  @IsOptional()
  @IsString()
  login?: string;

  @IsOptional()
  @IsString()
  password?: string;

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

  @IsOptional()
  @IsEmail()
  @IsString()
  birthdate?: string;

  @IsOptional()
  @IsEmail()
  @IsString()
  lastLogin?: string;
}
