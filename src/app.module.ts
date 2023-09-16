import { ConfigModule } from '@nestjs/config';

import { PrismaModule } from './prisma/prisma.module';
import { AppController } from './app.controller';
import { AuthModule } from './auth/auth.module';
import { Module } from '@nestjs/common';
import { AuthRepository } from './auth/repositories/auth.repository';
import { PrismaAuthRepository } from './prisma/repositories/prisma-auth.repository';
import { UserController } from './user/user.controller';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    AuthModule,
    PrismaModule,
  ],
  controllers: [AppController, UserController],
  providers: [
    {
      provide: AuthRepository,
      useClass: PrismaAuthRepository,
    },
  ],
})
export class AppModule {}
