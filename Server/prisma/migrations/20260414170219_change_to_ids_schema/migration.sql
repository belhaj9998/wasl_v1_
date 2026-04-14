/*
  Warnings:

  - You are about to drop the column `movement_slug` on the `InventoryMovement` table. All the data in the column will be lost.
  - The primary key for the `MovementType` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `name_ar` on the `MovementType` table. All the data in the column will be lost.
  - You are about to drop the column `name_en` on the `MovementType` table. All the data in the column will be lost.
  - You are about to drop the column `slug` on the `MovementType` table. All the data in the column will be lost.
  - You are about to drop the column `payment_slug` on the `Order` table. All the data in the column will be lost.
  - You are about to drop the column `status_slug` on the `Order` table. All the data in the column will be lost.
  - The primary key for the `OrderStatus` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `name_ar` on the `OrderStatus` table. All the data in the column will be lost.
  - You are about to drop the column `name_en` on the `OrderStatus` table. All the data in the column will be lost.
  - You are about to drop the column `slug` on the `OrderStatus` table. All the data in the column will be lost.
  - The primary key for the `PaymentStatus` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `name_ar` on the `PaymentStatus` table. All the data in the column will be lost.
  - You are about to drop the column `name_en` on the `PaymentStatus` table. All the data in the column will be lost.
  - You are about to drop the column `slug` on the `PaymentStatus` table. All the data in the column will be lost.
  - You are about to drop the column `status_slug` on the `Product` table. All the data in the column will be lost.
  - The primary key for the `ProductStatus` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `name_ar` on the `ProductStatus` table. All the data in the column will be lost.
  - You are about to drop the column `name_en` on the `ProductStatus` table. All the data in the column will be lost.
  - You are about to drop the column `slug` on the `ProductStatus` table. All the data in the column will be lost.
  - The primary key for the `Role` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `name_ar` on the `Role` table. All the data in the column will be lost.
  - You are about to drop the column `name_en` on the `Role` table. All the data in the column will be lost.
  - You are about to drop the column `slug` on the `Role` table. All the data in the column will be lost.
  - You are about to drop the column `role_slug` on the `StoreUser` table. All the data in the column will be lost.
  - You are about to drop the column `role_slug` on the `User` table. All the data in the column will be lost.
  - Added the required column `movement_id` to the `InventoryMovement` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `MovementType` table without a default value. This is not possible if the table is not empty.
  - Added the required column `payment_id` to the `Order` table without a default value. This is not possible if the table is not empty.
  - Added the required column `status_id` to the `Order` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `OrderStatus` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `PaymentStatus` table without a default value. This is not possible if the table is not empty.
  - Added the required column `status_id` to the `Product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `ProductStatus` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `Role` table without a default value. This is not possible if the table is not empty.
  - Added the required column `role_id` to the `StoreUser` table without a default value. This is not possible if the table is not empty.
  - Added the required column `role_id` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "InventoryMovement" DROP CONSTRAINT "InventoryMovement_movement_slug_fkey";

-- DropForeignKey
ALTER TABLE "Order" DROP CONSTRAINT "Order_payment_slug_fkey";

-- DropForeignKey
ALTER TABLE "Order" DROP CONSTRAINT "Order_status_slug_fkey";

-- DropForeignKey
ALTER TABLE "Product" DROP CONSTRAINT "Product_status_slug_fkey";

-- DropForeignKey
ALTER TABLE "StoreUser" DROP CONSTRAINT "StoreUser_role_slug_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_role_slug_fkey";

-- AlterTable
ALTER TABLE "InventoryMovement" DROP COLUMN "movement_slug",
ADD COLUMN     "movement_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "MovementType" DROP CONSTRAINT "MovementType_pkey",
DROP COLUMN "name_ar",
DROP COLUMN "name_en",
DROP COLUMN "slug",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "name" TEXT NOT NULL,
ADD CONSTRAINT "MovementType_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Order" DROP COLUMN "payment_slug",
DROP COLUMN "status_slug",
ADD COLUMN     "payment_id" INTEGER NOT NULL,
ADD COLUMN     "status_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "OrderStatus" DROP CONSTRAINT "OrderStatus_pkey",
DROP COLUMN "name_ar",
DROP COLUMN "name_en",
DROP COLUMN "slug",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "name" TEXT NOT NULL,
ADD CONSTRAINT "OrderStatus_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "PaymentStatus" DROP CONSTRAINT "PaymentStatus_pkey",
DROP COLUMN "name_ar",
DROP COLUMN "name_en",
DROP COLUMN "slug",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "name" TEXT NOT NULL,
ADD CONSTRAINT "PaymentStatus_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Product" DROP COLUMN "status_slug",
ADD COLUMN     "status_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "ProductStatus" DROP CONSTRAINT "ProductStatus_pkey",
DROP COLUMN "name_ar",
DROP COLUMN "name_en",
DROP COLUMN "slug",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "name" TEXT NOT NULL,
ADD CONSTRAINT "ProductStatus_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Role" DROP CONSTRAINT "Role_pkey",
DROP COLUMN "name_ar",
DROP COLUMN "name_en",
DROP COLUMN "slug",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "name" TEXT NOT NULL,
ADD CONSTRAINT "Role_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "StoreUser" DROP COLUMN "role_slug",
ADD COLUMN     "role_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "role_slug",
ADD COLUMN     "role_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "Role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StoreUser" ADD CONSTRAINT "StoreUser_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "Role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_status_id_fkey" FOREIGN KEY ("status_id") REFERENCES "ProductStatus"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryMovement" ADD CONSTRAINT "InventoryMovement_movement_id_fkey" FOREIGN KEY ("movement_id") REFERENCES "MovementType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_status_id_fkey" FOREIGN KEY ("status_id") REFERENCES "OrderStatus"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_payment_id_fkey" FOREIGN KEY ("payment_id") REFERENCES "PaymentStatus"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
