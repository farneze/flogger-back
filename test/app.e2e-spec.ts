import { Test } from '@nestjs/testing';
import { AppModule } from '../src/app.module';
import * as pactum from 'pactum';
import { INestApplication } from '@nestjs/common';
import { ValidationPipe } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { AuthSignupDto } from 'src/auth/dto';

describe('test 123', () => {
  let app: INestApplication;
  let prisma: PrismaService;

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

    await app.init();
    await app.listen(3333);

    prisma = app.get(PrismaService);

    await prisma.cleanDb();

    pactum.request.setBaseUrl('http://localhost:3333');
  });

  afterAll(() => {
    app.close();
  });

  describe('Auth', () => {
    describe('SignUp', () => {
      // it.todo('Should create new user');

      it.todo('should throw error if');

      it('should signup user', () => {
        const dto: AuthSignupDto = {
          login: 'Tutucuruco',
          password: 'Test123',
          email: 'a@b.com',
          firstname: 'Arnthor',
          lastname: 'Heyn',
          nickname: 'Tutu',
        };

        return pactum
          .spec()
          .post('/auth/signup')
          .withBody(dto)
          .expectStatus(201);
        // .inspect();
      });
    });

    describe('SignIn', () => {
      it('should sign in user and get access token', () => {
        const dto: AuthSignupDto = {
          login: 'Tutucuruco',
          password: 'Test123',
        };

        return pactum
          .spec()
          .get('/auth/signin')
          .withBody(dto)
          .expectStatus(200)
          .stores('userToken', 'access_token');
      });
    });
  });

  describe('User', () => {
    describe('Get current user', () => {
      it('should get current user data', () => {
        return pactum
          .spec()
          .get('/app/user/me')
          .withHeaders({
            Authorization: 'Bearer $S{userToken}',
          })
          .expectStatus(200);
      });
      //it.todo('should pass');
    });
    // describe('Get any user', () => {});
  });
});
