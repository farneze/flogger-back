import { PrismaService } from 'src/database/prisma.service';
import { UserRepository } from '../user-repository';
import { Injectable } from '@nestjs/common';

@Injectable()
export class PrismaUserRepository implements UserRepository {
  constructor(private prisma: PrismaService) {}

  async create(
    first_name: string,
    last_name: string,
    nickname: string,
    age: number,
  ): Promise<void> {
    await this.prisma.users.create({
      data: {
        first_name,
        last_name,
        nickname,
        age,
      },
    });
  }
}
