/*
  Warnings:

  - The primary key for the `Group` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `groupId` column on the `Group` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `GroupItem` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Ingredient` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `ingredientId` column on the `Ingredient` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `Item` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `itemId` column on the `Item` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `ItemModifier` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Modifier` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `modifierId` column on the `Modifier` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `ingredientIngredientId` column on the `Modifier` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `ModifierIngredient` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - Changed the type of `groupId` on the `GroupItem` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `itemId` on the `GroupItem` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `itemId` on the `ItemModifier` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `modifierId` on the `ItemModifier` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `modifierId` on the `ModifierIngredient` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `ingredientId` on the `ModifierIngredient` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `A` on the `_GroupToItem` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `B` on the `_GroupToItem` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `A` on the `_ItemToModifier` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `B` on the `_ItemToModifier` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- DropForeignKey
ALTER TABLE "GroupItem" DROP CONSTRAINT "GroupItem_groupId_fkey";

-- DropForeignKey
ALTER TABLE "GroupItem" DROP CONSTRAINT "GroupItem_itemId_fkey";

-- DropForeignKey
ALTER TABLE "ItemModifier" DROP CONSTRAINT "ItemModifier_itemId_fkey";

-- DropForeignKey
ALTER TABLE "ItemModifier" DROP CONSTRAINT "ItemModifier_modifierId_fkey";

-- DropForeignKey
ALTER TABLE "Modifier" DROP CONSTRAINT "Modifier_ingredientIngredientId_fkey";

-- DropForeignKey
ALTER TABLE "ModifierIngredient" DROP CONSTRAINT "ModifierIngredient_ingredientId_fkey";

-- DropForeignKey
ALTER TABLE "ModifierIngredient" DROP CONSTRAINT "ModifierIngredient_modifierId_fkey";

-- DropForeignKey
ALTER TABLE "_GroupToItem" DROP CONSTRAINT "_GroupToItem_A_fkey";

-- DropForeignKey
ALTER TABLE "_GroupToItem" DROP CONSTRAINT "_GroupToItem_B_fkey";

-- DropForeignKey
ALTER TABLE "_ItemToModifier" DROP CONSTRAINT "_ItemToModifier_A_fkey";

-- DropForeignKey
ALTER TABLE "_ItemToModifier" DROP CONSTRAINT "_ItemToModifier_B_fkey";

-- AlterTable
ALTER TABLE "Group" DROP CONSTRAINT "Group_pkey",
DROP COLUMN "groupId",
ADD COLUMN     "groupId" SERIAL NOT NULL,
ADD CONSTRAINT "Group_pkey" PRIMARY KEY ("groupId");

-- AlterTable
ALTER TABLE "GroupItem" DROP CONSTRAINT "GroupItem_pkey",
DROP COLUMN "groupId",
ADD COLUMN     "groupId" INTEGER NOT NULL,
DROP COLUMN "itemId",
ADD COLUMN     "itemId" INTEGER NOT NULL,
ADD CONSTRAINT "GroupItem_pkey" PRIMARY KEY ("groupId", "itemId");

-- AlterTable
ALTER TABLE "Ingredient" DROP CONSTRAINT "Ingredient_pkey",
DROP COLUMN "ingredientId",
ADD COLUMN     "ingredientId" SERIAL NOT NULL,
ADD CONSTRAINT "Ingredient_pkey" PRIMARY KEY ("ingredientId");

-- AlterTable
ALTER TABLE "Item" DROP CONSTRAINT "Item_pkey",
DROP COLUMN "itemId",
ADD COLUMN     "itemId" SERIAL NOT NULL,
ADD CONSTRAINT "Item_pkey" PRIMARY KEY ("itemId");

-- AlterTable
ALTER TABLE "ItemModifier" DROP CONSTRAINT "ItemModifier_pkey",
DROP COLUMN "itemId",
ADD COLUMN     "itemId" INTEGER NOT NULL,
DROP COLUMN "modifierId",
ADD COLUMN     "modifierId" INTEGER NOT NULL,
ADD CONSTRAINT "ItemModifier_pkey" PRIMARY KEY ("itemId", "modifierId");

-- AlterTable
ALTER TABLE "Modifier" DROP CONSTRAINT "Modifier_pkey",
DROP COLUMN "modifierId",
ADD COLUMN     "modifierId" SERIAL NOT NULL,
DROP COLUMN "ingredientIngredientId",
ADD COLUMN     "ingredientIngredientId" INTEGER,
ADD CONSTRAINT "Modifier_pkey" PRIMARY KEY ("modifierId");

-- AlterTable
ALTER TABLE "ModifierIngredient" DROP CONSTRAINT "ModifierIngredient_pkey",
DROP COLUMN "modifierId",
ADD COLUMN     "modifierId" INTEGER NOT NULL,
DROP COLUMN "ingredientId",
ADD COLUMN     "ingredientId" INTEGER NOT NULL,
ADD CONSTRAINT "ModifierIngredient_pkey" PRIMARY KEY ("modifierId", "ingredientId");

-- AlterTable
ALTER TABLE "_GroupToItem" DROP COLUMN "A",
ADD COLUMN     "A" INTEGER NOT NULL,
DROP COLUMN "B",
ADD COLUMN     "B" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "_ItemToModifier" DROP COLUMN "A",
ADD COLUMN     "A" INTEGER NOT NULL,
DROP COLUMN "B",
ADD COLUMN     "B" INTEGER NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "_GroupToItem_AB_unique" ON "_GroupToItem"("A", "B");

-- CreateIndex
CREATE INDEX "_GroupToItem_B_index" ON "_GroupToItem"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ItemToModifier_AB_unique" ON "_ItemToModifier"("A", "B");

-- CreateIndex
CREATE INDEX "_ItemToModifier_B_index" ON "_ItemToModifier"("B");

-- AddForeignKey
ALTER TABLE "Modifier" ADD CONSTRAINT "Modifier_ingredientIngredientId_fkey" FOREIGN KEY ("ingredientIngredientId") REFERENCES "Ingredient"("ingredientId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GroupItem" ADD CONSTRAINT "GroupItem_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Group"("groupId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GroupItem" ADD CONSTRAINT "GroupItem_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "Item"("itemId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ItemModifier" ADD CONSTRAINT "ItemModifier_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "Item"("itemId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ItemModifier" ADD CONSTRAINT "ItemModifier_modifierId_fkey" FOREIGN KEY ("modifierId") REFERENCES "Modifier"("modifierId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ModifierIngredient" ADD CONSTRAINT "ModifierIngredient_modifierId_fkey" FOREIGN KEY ("modifierId") REFERENCES "Modifier"("modifierId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ModifierIngredient" ADD CONSTRAINT "ModifierIngredient_ingredientId_fkey" FOREIGN KEY ("ingredientId") REFERENCES "Ingredient"("ingredientId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GroupToItem" ADD CONSTRAINT "_GroupToItem_A_fkey" FOREIGN KEY ("A") REFERENCES "Group"("groupId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GroupToItem" ADD CONSTRAINT "_GroupToItem_B_fkey" FOREIGN KEY ("B") REFERENCES "Item"("itemId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ItemToModifier" ADD CONSTRAINT "_ItemToModifier_A_fkey" FOREIGN KEY ("A") REFERENCES "Item"("itemId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ItemToModifier" ADD CONSTRAINT "_ItemToModifier_B_fkey" FOREIGN KEY ("B") REFERENCES "Modifier"("modifierId") ON DELETE CASCADE ON UPDATE CASCADE;
