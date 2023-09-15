import { AuthRepository } from '../../auth/repositories/auth.repository';
import { PrismaService } from '../prisma.service';
import { Injectable } from '@nestjs/common';

@Injectable()
export class PrismaAuthRepository implements AuthRepository {
  constructor(private prisma: PrismaService) {}

  async create(
    login: string,
    password: string,
    firstname?: string,
    lastname?: string,
    nickname?: string,
    email?: string,
  ): Promise<void> {
    await this.prisma.main_users.create({
      data: {
        login,
        hash: password,
        firstname,
        lastname,
        nickname,
        email,
      },
    });
  }
}
