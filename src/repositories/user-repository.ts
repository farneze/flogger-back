export abstract class UserRepository {
  abstract create(
    first_name: string,
    last_name: string,
    nickname: string,
    age: number, // dish: dish,// foods: foods,
  ): Promise<void>;
}
