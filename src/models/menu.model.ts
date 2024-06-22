import prisma from "../client";
import { Prisma } from "@prisma/client";
export class MenuModel {
  async findMany(options?: Prisma.MenuFindManyArgs) {
    return await prisma.menu.findMany(options);
  }
  async findOne(options: Prisma.MenuFindUniqueArgs) {
    return await prisma.menu.findUnique(options);
  }
  async create(data: Prisma.MenuCreateInput) {
    return await prisma.menu.create({ data });
  }
  async update(
    options: Prisma.MenuWhereUniqueInput,
    data: Prisma.MenuUpdateInput
  ) {
    return await prisma.menu.update({ where: options, data });
  }
  async delete(options: Prisma.MenuWhereUniqueInput) {
    return await prisma.menu.delete({ where: options });
  }
}
