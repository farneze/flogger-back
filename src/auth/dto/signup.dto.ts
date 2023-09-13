import { Type } from 'class-transformer';
import {
  IsNotEmpty,
  IsOptional,
  IsString,
  IsEmail,
  IsInt,
} from 'class-validator';

export class AuthSignupDto {
  @IsEmail()
  @IsString()
  email: string;

  @IsOptional()
  @IsString()
  firstname?: string;

  @IsOptional()
  @IsString()
  lastname?: string;

  @IsNotEmpty()
  @IsString()
  nickname: string;

  @IsNotEmpty()
  @IsString()
  password: string;

  @IsNotEmpty()
  @Type(() => Number)
  @IsInt()
  age: number;
}
