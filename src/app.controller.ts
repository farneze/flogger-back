import { Body, Controller, Post } from '@nestjs/common';
import { PostUserBody } from './dtos/user-dto';
import { UserRepository } from './repositories/user-repository';

@Controller('app')
export class AppController {
  // constructor(private prisma: PrismaService) {}
  constructor(private userRepository: UserRepository) {}

  // @Get('get-user')
  // async getUser(@Body() body: GetUserBody) {
  //   const { id } = body;

  //   await this.userRepository.create(id);
  //   // const users = await this.prisma.users.findFirst({
  //   //   where: {
  //   //     id,
  //   //   },
  //   // });

  //   return { users };
  // }

  @Post('create-user')
  async postUser(@Body() body: PostUserBody) {
    const { first_name, last_name, nickname, age } = body;

    await this.userRepository.create(first_name, last_name, nickname, age);
  }
}
