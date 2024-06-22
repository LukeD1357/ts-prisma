import { RequestHandler } from "../types/expressTypes";
import { MenuModel } from "../models/menu.model";
import { Menu, Group, Item } from "@prisma/client";
const menuModel = new MenuModel();

export const createMenu: RequestHandler = async (req, res) => {
  const { menuName } = req.body;
  const newMenu = await menuModel.create({ menuName });
  return res.json({ menu: newMenu });
};

interface GroupWithItems extends Group {
  items: {
    item: Item;
  }[];
}
interface CompiledMenu extends Menu {
  groups: GroupWithItems[];
}

export const getMenu: RequestHandler = async (req, res) => {
  const { menuId: id } = req.params;
  const menu = await menuModel.findOne({
    where: { menuId: Number(id) },
    include: {
      groups: {
        include: { items: { select: { item: true } } },
      },
    },
  });
  if (!menu) {
    return res.status(404).json({ message: "Menu not found" });
  }

  const formattedMenu = {
    ...menu,
    groups: (menu as CompiledMenu).groups.map((group) => {
      return {
        ...group,
        items: group.items.map((groupItem) => groupItem.item),
      };
    }),
  };
  return res.json({ menu: formattedMenu });
};
