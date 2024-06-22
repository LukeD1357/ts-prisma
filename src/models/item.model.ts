import prisma from "../client";
import { Prisma } from "@prisma/client";
export class ItemModel {
  async findMany(options?: Prisma.ItemFindManyArgs) {
    return await prisma.item.findMany(options);
  }
  async findOne(options: Prisma.ItemFindUniqueArgs) {
    return await prisma.item.findUnique(options);
  }
  async create(data: Prisma.ItemCreateInput) {
    return await prisma.item.create({ data });
  }
  async createMany(data: Prisma.ItemCreateManyInput) {
    return await prisma.item.createMany({ data });
  }
  async update(
    options: Prisma.ItemWhereUniqueInput,
    data: Prisma.ItemUpdateInput
  ) {
    return await prisma.item.update({ where: options, data });
  }
  async delete(options: Prisma.ItemWhereUniqueInput) {
    return await prisma.item.delete({ where: options });
  }
}
