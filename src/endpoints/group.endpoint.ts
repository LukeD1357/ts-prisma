import { RequestHandler } from "../types/expressTypes";
import { MenuModel } from "../models/menu.model";
import { GroupModel } from "../models/group.model";
import { GroupItemModel } from "../models/groupItem.model";
import { ItemModel } from "../models/item.model";
import { Group, GroupItem } from "@prisma/client";

const groupModel = new GroupModel();
const groupItemModel = new GroupItemModel();
const menuModel = new MenuModel();
const itemModel = new ItemModel();

export const createGroup: RequestHandler = async (req, res) => {
  const { menuId } = req.params;
  const { groupName, order } = req.body;
  const menu = await menuModel.findOne({ where: { menuId: Number(menuId) } });
  if (!menu) {
    return res.status(404).json({ message: "Menu not found" });
  }
  const newGroup = await groupModel.create({
    groupName,
    order,
    menu: { connect: { menuId: Number(menuId) } },
  });

  return res.json({ group: newGroup });
};

type UpdateGroupRequest = Pick<Group, "groupName">;

export const updateGroup: RequestHandler = async (req, res) => {
  const { menuId, groupId } = req.params;
  const { groupName }: UpdateGroupRequest = req.body;
  const group = await groupModel.findOne({
    where: { groupId: Number(groupId), menuId: Number(menuId) },
  });
  if (!group) {
    return res.status(404).json({ message: "Group not found" });
  }

  const updatedGroup = await groupModel.update(
    { groupId: Number(groupId), menuId: Number(menuId) },
    {
      groupName,
    },
    {
      items: true,
    }
  );
  return res.json({ group: updatedGroup });
};

export const updateGroupOrder: RequestHandler = async (req, res) => {
  const { groups } = req.body;
  const { menuId } = req.params;
  const update = await groupModel.bulkUpdate(Number(menuId), groups);
  return res.json({ groups: update });
};

type CreateGroupItemRequest = Pick<GroupItem, "itemId">;

export const createGroupItem: RequestHandler = async (req, res) => {
  const { menuId, groupId } = req.params;
  const { itemId }: CreateGroupItemRequest = req.body;
  const group = await groupModel.findOne({
    where: { groupId: Number(groupId), menuId: Number(menuId) },
  });
  if (!group) {
    return res.status(404).json({ message: "Group not found" });
  }
  const item = await itemModel.findOne({ where: { itemId } });
  if (!item) {
    return res.status(404).json({ message: "Item not found" });
  }

  const groupItem = await groupItemModel.create({
    group: { connect: { groupId: Number(groupId) } },
    item: { connect: { itemId } },
  });
  return res.json({ groupItem });
};

export const deleteGroup: RequestHandler = async (req, res) => {
  const { menuId, groupId } = req.params;
  const group = await groupModel.findOne({
    where: { groupId: Number(groupId), menuId: Number(menuId) },
  });
  if (!group) {
    return res.status(404).json({ message: "Group not found" });
  }
  await groupModel.delete({ groupId: Number(groupId), menuId: Number(menuId) });
  return res.json({ message: "Group deleted" });
};
