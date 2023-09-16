import {
  Body,
  Controller,
  Post,
  Get,
  // HttpCode,
  // HttpStatus,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthSignupDto, AuthSigninDto } from './dto/index';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  // @HttpCode(HttpStatus.OK)
  @Get('signin')
  signin(@Body() dto: AuthSigninDto) {
    return this.authService.signin(dto);
  }

  @Post('signup')
  signup(@Body() dto: AuthSignupDto) {
    return this.authService.signup(dto);
  }
}
