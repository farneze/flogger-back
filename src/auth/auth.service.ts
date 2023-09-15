import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';
import { ForbiddenException, Injectable } from '@nestjs/common';
import { AuthSigninDto, AuthSignupDto } from './dto/index';
import { PrismaService } from 'src/prisma/prisma.service';
import * as argon from 'argon2';

@Injectable()
export class AuthService {
  constructor(private db: PrismaService) {}

  async signup(dto: AuthSignupDto) {
    const hash = await argon.hash(dto.password, {
      // TODO - verificar
      // timeCost: 2,
      // parallelism: 1,
      // type: argon.argon2id,
      // memoryCost: 2 ** 20,
      // hashLength: 50,
    });
    //OWASP - minimum configuration of 19 MiB of memory, an iteration count of 2, and 1 degree of parallelism.
    console.log(dto);
    try {
      const user = await this.db.main_users.create({
        data: {
          login: dto.login,
          hash,
          firstname: dto.firstname,
          lastname: dto.lastname,
          nickname: dto.nickname,
          email: dto.email,
        },
      });

      delete user.hash;

      return user;
    } catch (error) {
      if (error instanceof PrismaClientKnownRequestError) {
        if (error.code === 'P2002') {
          throw new ForbiddenException('Email already exists!');
        }
      }

      throw error;
    }
  }

  async signin(dto: AuthSigninDto) {
    const user = await this.db.main_users.findUnique({
      where: {
        login: dto.login,
      },
    });

    if (!user) throw new ForbiddenException('Incorrect credentials');

    const pwMatches = await argon.verify(user.hash, dto.password);

    if (!pwMatches) throw new ForbiddenException('Incorrect credentials');

    delete user.hash;

    return user;
  }
}
