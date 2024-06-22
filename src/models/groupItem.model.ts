import prisma from "../client";
import { Prisma } from "@prisma/client";
export class GroupItemModel {
  async findMany(options?: Prisma.GroupItemFindManyArgs) {
    return await prisma.groupItem.findMany(options);
  }
  async findOne(options: Prisma.GroupItemFindUniqueArgs) {
    return await prisma.groupItem.findUnique(options);
  }
  async create(data: Prisma.GroupItemCreateInput) {
    return await prisma.groupItem.create({
      data,
      include: {
        item: true,
        group: { include: { items: { include: { group: true } } } },
      },
    });
  }
  async createMany(data: Prisma.GroupItemCreateManyInput[]) {
    return await prisma.groupItem.createMany({ data });
  }
  async update(
    options: Prisma.GroupItemWhereUniqueInput,
    data: Prisma.GroupItemUpdateInput,
    include?: Prisma.GroupItemInclude
  ) {
    return await prisma.groupItem.update({ where: options, data, include });
  }

  async delete(options: Prisma.GroupItemWhereUniqueInput) {
    return await prisma.groupItem.delete({ where: options });
  }
}
