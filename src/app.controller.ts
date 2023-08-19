import { Controller, Get } from '@nestjs/common';
// import { AppService } from './app.service';
import { PrismaService } from './database/prisma.service';

@Controller()
export class AppController {
  // constructor(private readonly appService: AppService) {}
  constructor(private prisma: PrismaService) {}

  @Get()
  async getHello(): Promise<any> {
    const user = await this.prisma.users.findFirst({
      where: {
        id: 1,
      },
    });

    return user;
    // return this.appService.getHello();
  }
}
