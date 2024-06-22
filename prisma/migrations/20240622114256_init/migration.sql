/*
  Warnings:

  - You are about to drop the `Post` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Post" DROP CONSTRAINT "Post_authorId_fkey";

-- DropTable
DROP TABLE "Post";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "Menu" (
    "menuId" SERIAL NOT NULL,
    "menuName" TEXT NOT NULL,

    CONSTRAINT "Menu_pkey" PRIMARY KEY ("menuId")
);

-- CreateTable
CREATE TABLE "Group" (
    "groupId" TEXT NOT NULL,
    "groupName" TEXT NOT NULL,
    "order" INTEGER NOT NULL,
    "menuId" INTEGER NOT NULL,

    CONSTRAINT "Group_pkey" PRIMARY KEY ("groupId")
);

-- CreateTable
CREATE TABLE "Item" (
    "itemId" TEXT NOT NULL,
    "itemName" TEXT NOT NULL,

    CONSTRAINT "Item_pkey" PRIMARY KEY ("itemId")
);

-- CreateTable
CREATE TABLE "Modifier" (
    "modifierId" TEXT NOT NULL,
    "modifierName" TEXT NOT NULL,
    "ingredientIngredientId" TEXT,

    CONSTRAINT "Modifier_pkey" PRIMARY KEY ("modifierId")
);

-- CreateTable
CREATE TABLE "Ingredient" (
    "ingredientId" TEXT NOT NULL,
    "ingredientName" TEXT NOT NULL,

    CONSTRAINT "Ingredient_pkey" PRIMARY KEY ("ingredientId")
);

-- CreateTable
CREATE TABLE "GroupItem" (
    "groupId" TEXT NOT NULL,
    "itemId" TEXT NOT NULL,

    CONSTRAINT "GroupItem_pkey" PRIMARY KEY ("groupId","itemId")
);

-- CreateTable
CREATE TABLE "ItemModifier" (
    "itemId" TEXT NOT NULL,
    "modifierId" TEXT NOT NULL,

    CONSTRAINT "ItemModifier_pkey" PRIMARY KEY ("itemId","modifierId")
);

-- CreateTable
CREATE TABLE "ModifierIngredient" (
    "modifierId" TEXT NOT NULL,
    "ingredientId" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "ModifierIngredient_pkey" PRIMARY KEY ("modifierId","ingredientId")
);

-- CreateTable
CREATE TABLE "_GroupToItem" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_ItemToModifier" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Group_menuId_order_key" ON "Group"("menuId", "order");

-- CreateIndex
CREATE UNIQUE INDEX "_GroupToItem_AB_unique" ON "_GroupToItem"("A", "B");

-- CreateIndex
CREATE INDEX "_GroupToItem_B_index" ON "_GroupToItem"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ItemToModifier_AB_unique" ON "_ItemToModifier"("A", "B");

-- CreateIndex
CREATE INDEX "_ItemToModifier_B_index" ON "_ItemToModifier"("B");

-- AddForeignKey
ALTER TABLE "Group" ADD CONSTRAINT "Group_menuId_fkey" FOREIGN KEY ("menuId") REFERENCES "Menu"("menuId") ON DELETE RESTRICT ON UPDATE CASCADE;

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
