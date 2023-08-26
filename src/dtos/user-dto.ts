import { IsNotEmpty, IsNumber, IsOptional, IsString } from 'class-validator';

export class GetUserBody {
  @IsNotEmpty({
    message: 'ID usuário não pode ser vazio!',
  })
  @IsNumber(
    { allowNaN: false, allowInfinity: false },
    {
      message: 'ID usuário deve ser um número!',
    },
  )
  id: number;
}

export class PostUserBody {
  @IsOptional()
  @IsString({
    message: 'Primeiro nome do usuário deve ser string!',
  })
  first_name?: string;

  @IsOptional()
  @IsString({
    message: 'Último nome do usuário deve ser string!',
  })
  last_name?: string;

  // @IsNotEmpty({
  //   message: 'Apelido do usuário não pode ser vazio!',
  // })
  // @IsString({
  //   message: 'Apelido do usuário deve ser string!',
  // })
  nickname: string;

  // @IsNotEmpty({
  //   message: 'Idade do usuário não pode ser vazio!',
  // })
  // @IsNumber(
  //   { allowNaN: false, allowInfinity: false },
  //   {
  //     message: 'Idade do usuário deve ser um número!',
  //   },
  // )
  age: number;

  // @IsDate({
  //   message: 'Último login do usuário deve ser uma data!',
  // })
  // last_login: Date;

  // @IsDate({
  //   message: 'Último login do usuário deve ser uma data!',
  // })
  // updated_at: Date;
}
