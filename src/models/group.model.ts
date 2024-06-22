import prisma from "../client";
import { Prisma, Group } from "@prisma/client";
export class GroupModel {
  async findMany(options?: Prisma.GroupFindManyArgs) {
    return await prisma.group.findMany(options);
  }
  async findOne(options: Prisma.GroupFindUniqueArgs) {
    return await prisma.group.findUnique(options);
  }
  async create(data: Prisma.GroupCreateInput) {
    return await prisma.group.create({ data });
  }
  async createMany(data: Prisma.GroupCreateManyInput) {
    return await prisma.group.createMany({ data });
  }
  async update(
    options: Prisma.GroupWhereUniqueInput,
    data: Prisma.GroupUpdateInput,
    include?: Prisma.GroupInclude
  ) {
    return await prisma.group.update({ where: options, data, include });
  }

  async bulkUpdate(menuId: number, groups: Group[]) {
    const transactions = groups.map((group: Group) => {
      return prisma.group.update({
        where: { groupId: group.groupId, menuId: Number(menuId) },
        data: { order: group.order },
      });
    });
    await prisma.$transaction(transactions);
    return this.findMany({
      where: { menuId, groupId: { in: groups.map((group) => group.groupId) } },
    });
  }

  async delete(options: Prisma.GroupWhereUniqueInput) {
    return await prisma.group.delete({ where: options });
  }
}
