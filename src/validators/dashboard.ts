import * as Joi from "joi";
export const postMenuSchema = {
  body: Joi.object({
    menuName: Joi.string().required(),
  }),
};

export const postGroupSchema = {
  body: Joi.object({
    groupName: Joi.string().required(),
    order: Joi.number().required(),
  }),
};

export const patchGroupSchema = {
  body: Joi.object({
    groupName: Joi.string().required(),
    items: Joi.array().items(Joi.number().required()).optional(),
  }),
};

export const patchGroupOrderSchema = {
  body: Joi.object({
    groups: Joi.array().items(
      Joi.object({
        groupId: Joi.number().required(),
        order: Joi.number().required(),
      })
    ),
  }),
};

export const postItemSchema = {
  body: Joi.object({
    itemName: Joi.string().required(),
    description: Joi.string().required(),
    price: Joi.number().required(),
  }),
};

export const patchItemSchema = {
  body: Joi.object({
    itemName: Joi.string().optional(),
    description: Joi.string().optional(),
    price: Joi.number().optional(),
  }),
};

export const postGroupItemSchema = {
  body: Joi.object({
    itemId: Joi.number().required(),
  }),
};
