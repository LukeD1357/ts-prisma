/*
  Warnings:

  - You are about to drop the `ItemModifier` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_GroupItems` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "GroupItem" DROP CONSTRAINT "GroupItem_groupId_fkey";

-- DropForeignKey
ALTER TABLE "GroupItem" DROP CONSTRAINT "GroupItem_itemId_fkey";

-- DropForeignKey
ALTER TABLE "ItemModifier" DROP CONSTRAINT "ItemModifier_itemId_fkey";

-- DropForeignKey
ALTER TABLE "_GroupItems" DROP CONSTRAINT "_GroupItems_A_fkey";

-- DropForeignKey
ALTER TABLE "_GroupItems" DROP CONSTRAINT "_GroupItems_B_fkey";

-- DropTable
DROP TABLE "ItemModifier";

-- DropTable
DROP TABLE "_GroupItems";

-- AddForeignKey
ALTER TABLE "GroupItem" ADD CONSTRAINT "GroupItem_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Group"("groupId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GroupItem" ADD CONSTRAINT "GroupItem_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "Item"("itemId") ON DELETE CASCADE ON UPDATE CASCADE;
