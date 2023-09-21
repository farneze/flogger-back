import { Test } from '@nestjs/testing';
import { AppModule } from '../src/app.module';
import * as pactum from 'pactum';
import { INestApplication } from '@nestjs/common';
import { ValidationPipe } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { AuthSigninDto, AuthSignupDto } from 'src/auth/dto';

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
      const dto: AuthSignupDto = {
        login: 'Tutucuruco',
        password: 'Test123',
        email: 'a@b.com',
        firstname: 'Arnthor',
        lastname: 'Heyn',
        nickname: 'Tutu',
      };

      pactum.stash.addDataTemplate(dto);

      it('should signup user', async () => {
        return await pactum
          .spec()
          .post('/auth/signup')
          .withBody(dto)
          .expectStatus(201);
      });

      // SignUp Errors
      it.todo('should throw error if login field is empty');
      it.todo('should throw error if password field is empty');
      it.todo('should throw error if nickname field is empty');
      it.todo('should throw error if login is already taken');
      it.todo('should throw error if email doesnt match pattern');
      it.todo('should throw error if password doesnt match pattern');
    });

    describe('SignIn', () => {
      it('should sign in user and get access token', async () => {
        const dto: AuthSigninDto = {
          login: 'Tutucuruco',
          password: 'Test123',
        };

        return await pactum
          .spec()
          .get('/auth/signin')
          // .withQueryParams('gender', 'male')
          .withBody(dto)
          .expectStatus(200)
          .stores('userToken', 'access_token');
        // .expectJsonLike({
        //   "results": [
        //     {
        //       "gender": "male"
        //     }
        //   ]
        // })
      });

      // SignIn Errors
      it.todo('should throw error if password field is empty');
      it.todo('should throw error if account doesnt exist');
      it.todo('should throw error if login or password doesnt match');
    });
  });

  describe('Users', () => {
    describe('Current user', () => {
      it.todo('should return all users');

      it('should Get current user data', async () => {
        return await pactum
          .spec()
          .get('/app/users/me')
          .withHeaders({
            Authorization: 'Bearer $S{userToken}',
          })
          .expectStatus(200)
          .stores('userId', 'id');
      });

      it('should Edit user', async () => {
        return await pactum
          .spec()
          .post('/app/users/$S{userId}')
          .withHeaders({
            Authorization: 'Bearer $S{userToken}',
          })
          .withBody({ email: 'art@bert.com' })
          .expectStatus(200)
          .inspect();
      });

      it.todo('should Delete user');

      // Current user Errors
    });

    // describe('Friends', () => {
    //   it.todo('should Get list of users based on filters');
    //   it.todo('should Get user profile');
    //   it.todo('should Edit friend');
    //   it.todo('should Delete friend');

    //   // Friends Errors
    // });

    describe('Weight', () => {
      // it('should Get list of weight based on filter', async () => {
      //   return await pactum
      //     .spec()
      //     .get('/app/user/add-weight')
      //     .withHeaders({
      //       Authorization: 'Bearer $S{userToken}',
      //     })
      //     .expectStatus(200);
      // });

      it.todo('should Add weight');
      it.todo('should Edit weight');
      it.todo('should Remove weight');

      // Weight Errors
    });

    describe('Goal', () => {
      it.todo('should Get list of goal based on filter');
      it.todo('should Add goal');
      it.todo('should Edit goal');
      it.todo('should Remove goal');

      // Goal Errors
    });
  });

  describe('Core', () => {
    describe('Food', () => {
      it.todo('Get list of food based on filter');
      it.todo('Return food data');
      it.todo('Add food');
      it.todo('Edit food');
      it.todo('Remove food');

      // Goal Errors
    });

    describe('Dish', () => {
      it.todo('Get list of dish based on filter');
      it.todo('Return dish data');
      it.todo('Add dish');
      it.todo('Edit dish');
      it.todo('Remove dish');

      // Goal Errors
    });

    describe('Building dishes', () => {
      it.todo('Add food to dish');
      it.todo('Remove food from dish');

      // Goal Errors
    });

    describe('Consumed', () => {
      it.todo('Get list of consumed dishes');
      it.todo('Add consumed dish');
      it.todo('Edit consumed dish');
      it.todo('Remove consumed dish');

      // Goal Errors
    });
  });
});
