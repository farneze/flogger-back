import { Body, Controller, Get } from '@nestjs/common';
import { PrismaService } from './database/prisma.service';
import { GetUserBody } from './dtos/get-user';

@Controller('app')
export class AppController {
  constructor(private prisma: PrismaService) {}

  @Get('get-user')
  async getUser(@Body() body: GetUserBody) {
    const { id } = body;

    const users = await this.prisma.users.findFirst({
      where: {
        id,
      },
    });

    return { users };
  }
}
