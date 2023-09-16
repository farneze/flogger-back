import { Injectable, OnModuleInit } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit {
  constructor(config: ConfigService) {
    super({
      datasources: {
        db: {
          url:
            'postgresql://' +
            config.get('DB_USER') +
            ':' +
            config.get('DB_PASSWORD') +
            '@' +
            config.get('DB_HOST') +
            ':' +
            config.get('DB_PORT') +
            '/' +
            config.get('DB_NAME') +
            '?schema=' +
            config.get('DB_SCHEMA'),
        },
      },
    });
  }

  async onModuleInit() {
    await this.$connect();
  }
}
