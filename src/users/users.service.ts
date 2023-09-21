import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';
import { ForbiddenException, Injectable } from '@nestjs/common';
import { UserDto } from './dto/user.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class UsersService {
  constructor(private db: PrismaService) {}

  async findAll() {
    try {
      const users = await this.db.users.findMany({});

      return users;
    } catch (error) {
      if (error instanceof PrismaClientKnownRequestError) {
        if (error.code === 'P2002') {
          throw new ForbiddenException('Error!');
        }
      }

      throw error;
    }
  }

  async findOne(id: number) {
    try {
      const user = await this.db.users.findFirst({
        where: {
          id,
        },
      });

      return user;
    } catch (error) {
      if (error instanceof PrismaClientKnownRequestError) {
        if (error.code === 'P2002') {
          throw new ForbiddenException('Error!');
        }
      }

      throw error;
    }
  }

  async find(search?: string) {
    const pattern: any = {
      contains: search,
      mode: 'insensitive',
    };

    console.log(pattern);
    try {
      const users = await this.db.users.findMany({
        where: {
          OR: [
            { firstname: pattern },
            { lastname: pattern },
            { nickname: pattern },
          ],
        },
      });

      return users;
    } catch (error) {
      if (error instanceof PrismaClientKnownRequestError) {
        if (error.code === 'P2002') {
          throw new ForbiddenException('Error!');
        }
      }

      throw error;
    }
  }

  async update(id: number, userDto: UserDto) {
    try {
      const user = await this.db.users.update({
        where: { id },
        data: userDto,
      });

      return user;
    } catch (error) {
      if (error instanceof PrismaClientKnownRequestError) {
        if (error.code === 'P2002') {
          throw new ForbiddenException('Error!');
        }
      }

      throw error;
    }
  }

  async remove(id: number) {
    try {
      const users = await this.db.users.delete({
        where: {
          id: id,
        },
      });

      return users;
    } catch (error) {
      if (error instanceof PrismaClientKnownRequestError) {
        if (error.code === 'P2002') {
          throw new ForbiddenException('Error!');
        }
      }

      throw error;
    }
  }
}
