export abstract class AuthRepository {
  abstract create(
    login: string,
    password: string,
    firstname?: string,
    lastname?: string,
    nickname?: string,
    email?: string,
  ): Promise<void>;
}
