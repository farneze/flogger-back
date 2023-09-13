import { AuthRepository } from '../../auth/repositories/auth.repository';
import { PrismaService } from '../prisma.service';
import { Injectable } from '@nestjs/common';

@Injectable()
export class PrismaAuthRepository implements AuthRepository {
  constructor(private prisma: PrismaService) {}

  async create(
    email: string,
    hash: string,
    nickname: string,
    age: number,
    firstname?: string,
    lastname?: string,
  ): Promise<void> {
    await this.prisma.users.create({
      data: {
        email,
        hash,
        nickname,
        age,
        firstname,
        lastname,
      },
    });
  }
}
