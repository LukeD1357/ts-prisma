import { RequestHandler } from "../types/expressTypes";
import { ItemModel } from "../models/item.model";
import { Item } from "@prisma/client";

const itemModel = new ItemModel();

export const getItems: RequestHandler = async (req, res) => {
  const items = await itemModel.findMany();
  return res.json({ items });
};

export const getItem: RequestHandler = async (req, res) => {
  const { itemId: id } = req.params;
  const item = await itemModel.findOne({ where: { itemId: Number(id) } });
  if (!item) {
    return res.status(404).json({ message: "Item not found" });
  }
  return res.json({ item });
};

type CreateItemRequest = Omit<Item, "itemId">;

export const createItem: RequestHandler = async (req, res) => {
  const newItem = await itemModel.create(req.body as CreateItemRequest);
  return res.json({ item: newItem });
};

type UpdateItemRequest = Omit<Partial<Item>, "itemId">;

export const updateItem: RequestHandler = async (req, res) => {
  const { itemId } = req.params;
  const { itemName, price, description }: UpdateItemRequest = req.body;
  const updatedItem = await itemModel.update(
    { itemId: Number(itemId) },
    { itemName, price, description }
  );
  return res.json({ item: updatedItem });
};
