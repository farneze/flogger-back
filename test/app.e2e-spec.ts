import { Test } from '@nestjs/testing';
import { AppModule } from '../src/app.module';
import { INestApplication } from '@nestjs/common';
import { ValidationPipe } from '@nestjs/common';

describe('test 123', () => {
  let app: INestApplication;

  beforeAll(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleRef.createNestApplication();

    app.setGlobalPrefix('app', {
      exclude: ['auth(.*)'],
    });

    app.useGlobalPipes(
      new ValidationPipe({
        whitelist: true,
      }),
    );
  });

  afterAll(() => {
    app.close();
  });

  it.todo('should pass');
});
