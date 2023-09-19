import { PrismaClient } from '@prisma/client';
import * as argon from 'argon2';

const prisma = new PrismaClient();

async function main() {
  const hash = await argon.hash('Testing123');

  const arnthor = await prisma.users.upsert({
    where: { login: 'arnthor' },
    update: {},
    create: {
      email: 'arnthor@test.io',
      firstname: 'Arnthor',
      lastname: 'Heynson',
      nickname: 'tutucuruco',
      login: 'arnthor',
      hash: hash,
      birthdate: '1991-05-05T03:44:23.451Z',
      lastlogin: '2023-09-16T19:20:30.451Z',
      goal: {
        create: [
          {
            goal: 1900.01,
            date: '2023-09-16T19:20:30.451Z',
          },
          {
            goal: 2000.01,
            date: '2023-08-16T19:20:30.451Z',
          },
          {
            goal: 2100.01,
            date: '2023-07-16T19:20:30.451Z',
          },
        ],
      },
      weight: {
        create: [
          {
            weight: 110.01,
            date: '2023-09-16T19:20:30.451Z',
          },
          {
            weight: 120.01,
            date: '2023-08-16T19:20:30.451Z',
          },
          {
            weight: 130.01,
            date: '2023-07-16T19:20:30.451Z',
          },
        ],
      },
      foods: {
        create: [
          {
            name: 'batata',
            description: 'uma simples batata',
            image: '',
            calories: 5,
            carbohydrates: 6,
            protein: 7,
            fat: 8,
            sugar: 9,
            portiontype: 'unit',
            constructortype: 'builder',
            portionquantity: 10,
            price: 1,
            unit: 1,
          },
          {
            name: 'ovo',
            description: 'um simples ovo',
            image: '',
            calories: 1,
            carbohydrates: 2,
            protein: 3,
            fat: 4,
            sugar: 5,
            portiontype: 'grams',
            constructortype: 'energy_foods',
            portionquantity: 11,
            price: 2,
            unit: 1,
          },
          {
            name: 'leite',
            description: 'um simples leite',
            image: '',
            calories: 3,
            carbohydrates: 2,
            protein: 4,
            fat: 1,
            sugar: 5,
            portiontype: 'mililiter',
            constructortype: 'regulatory',
            portionquantity: 81,
            price: 20,
            unit: 17,
          },
        ],
      },
      dish: {
        create: [
          {
            name: 'batata com ovo',
            description: 'um prato de batata com ovo',
            createdat: '2023-09-14T19:20:30.451Z',
            dishhasfoods: {
              create: [
                {
                  idfood: 1,
                  quantity: 1,
                  createdat: '2023-09-14T19:20:30.451Z',
                },
                {
                  idfood: 2,
                  quantity: 2,
                  createdat: '2023-09-14T19:20:30.451Z',
                },
              ],
            },
            consumed: {
              create: [
                {
                  iduser: 1,
                  quantity: 1,
                  eatenat: '2023-09-14T19:20:30.451Z',
                },
              ],
            },
          },
          {
            name: 'ovo com leite',
            description: 'um prato de ovo com leite',
            createdat: '2023-09-14T19:20:30.451Z',
            dishhasfoods: {
              create: [
                {
                  idfood: 2,
                  quantity: 3,
                  createdat: '2023-09-14T19:20:30.451Z',
                },
                {
                  idfood: 3,
                  quantity: 4,
                  createdat: '2023-09-14T19:20:30.451Z',
                },
              ],
            },
          },
          {
            name: 'leite com batata',
            description: 'um prato de leite com batata',
            createdat: '2023-09-14T19:20:30.451Z',
            dishhasfoods: {
              create: [
                {
                  idfood: 2,
                  quantity: 5,
                  createdat: '2023-09-14T19:20:30.451Z',
                },
                {
                  idfood: 1,
                  quantity: 6,
                  createdat: '2023-09-14T19:20:30.451Z',
                },
              ],
            },
            consumed: {
              create: [
                {
                  iduser: 1,
                  quantity: 2,
                  eatenat: '2023-09-14T19:20:30.451Z',
                },
                {
                  iduser: 1,
                  quantity: 3,
                  eatenat: '2023-09-14T19:20:30.451Z',
                },
              ],
            },
          },
          {
            name: 'batata',
            description: 'um prato contendo duas batatas',
            createdat: '2023-09-14T19:20:30.451Z',
            dishhasfoods: {
              create: [
                {
                  idfood: 1,
                  quantity: 2,
                  createdat: '2023-09-14T19:20:30.451Z',
                },
              ],
            },
          },
        ],
      },
    },
  });

  console.log({ arnthor });
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
