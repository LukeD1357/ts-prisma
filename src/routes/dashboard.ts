import express from "express";
const dashboard = express.Router();
import { createMenu, getMenu } from "../endpoints/menu.endpoint";
import {
  createGroup,
  deleteGroup,
  updateGroup,
  updateGroupOrder,
  createGroupItem,
} from "../endpoints/group.endpoint";
import {
  createItem,
  getItems,
  getItem,
  updateItem,
} from "../endpoints/item.endpoint";
import {
  postMenuSchema,
  postGroupSchema,
  patchGroupSchema,
  patchGroupOrderSchema,
  patchItemSchema,
  postItemSchema,
  postGroupItemSchema,
} from "../validators/dashboard";
import { validate } from "express-validation";

//menu
dashboard.post("/menu", validate(postMenuSchema), createMenu);
dashboard.get("/menu/:menuId", getMenu);

//menu groups
dashboard.post("/menu/:menuId/group", validate(postGroupSchema), createGroup);
dashboard.patch(
  "/menu/:menuId/group",
  validate(patchGroupOrderSchema),
  updateGroupOrder
);
dashboard.patch(
  "/menu/:menuId/group/:groupId",
  validate(patchGroupSchema),
  updateGroup
);
dashboard.delete("/menu/:menuId/group/:groupId", deleteGroup);

//menu group items
dashboard.post(
  "/menu/:menuId/group/:groupId/item",
  validate(postGroupItemSchema),
  createGroupItem
);

//items
dashboard.get("/item", getItems);
dashboard.get("/item/:itemId", getItem);
dashboard.post("/item", validate(postItemSchema), createItem);
dashboard.patch("/item/:itemId", validate(patchItemSchema), updateItem);

export default dashboard;
