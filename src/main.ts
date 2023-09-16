import { ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // Utilizes app prefix for all routes except for auth
  app.setGlobalPrefix('app', {
    exclude: ['auth(.*)'],
  });

  // Doesn't allow a key to pass through a request if its not specified in the DTO
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
    }),
  );

  await app.listen(3333);
}
bootstrap();
