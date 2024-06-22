/*
  Warnings:

  - You are about to drop the `Ingredient` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Modifier` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ModifierIngredient` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_GroupToItem` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_ItemToModifier` table. If the table is not empty, all the data it contains will be lost.

*/
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

-- DropTable
DROP TABLE "Ingredient";

-- DropTable
DROP TABLE "Modifier";

-- DropTable
DROP TABLE "ModifierIngredient";

-- DropTable
DROP TABLE "_GroupToItem";

-- DropTable
DROP TABLE "_ItemToModifier";

-- CreateTable
CREATE TABLE "_GroupItems" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_GroupItems_AB_unique" ON "_GroupItems"("A", "B");

-- CreateIndex
CREATE INDEX "_GroupItems_B_index" ON "_GroupItems"("B");

-- AddForeignKey
ALTER TABLE "_GroupItems" ADD CONSTRAINT "_GroupItems_A_fkey" FOREIGN KEY ("A") REFERENCES "Group"("groupId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GroupItems" ADD CONSTRAINT "_GroupItems_B_fkey" FOREIGN KEY ("B") REFERENCES "Item"("itemId") ON DELETE CASCADE ON UPDATE CASCADE;
