export abstract class AuthRepository {
  abstract create(
    email: string,
    nickname: string,
    password: string,
    age: number,
    firstname?: string,
    lastname?: string,
  ): Promise<void>;
}
