/*
  Warnings:

  - You are about to drop the column `admin_notes` on the `Customer` table. All the data in the column will be lost.
  - The `gender` column on the `Customer` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `movement_type` on the `InventoryMovement` table. All the data in the column will be lost.
  - You are about to drop the column `order_status` on the `Order` table. All the data in the column will be lost.
  - You are about to drop the column `payment_status` on the `Order` table. All the data in the column will be lost.
  - You are about to drop the column `created_at` on the `OrderHistory` table. All the data in the column will be lost.
  - You are about to drop the column `discount_type` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `primary_image` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `status` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `favicon` on the `Store` table. All the data in the column will be lost.
  - You are about to drop the column `owner_id` on the `Store` table. All the data in the column will be lost.
  - You are about to drop the column `plan_id` on the `Store` table. All the data in the column will be lost.
  - You are about to drop the column `role` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `_CategoryToProduct` table. If the table is not empty, all the data it contains will be lost.
  - Made the column `phone` on table `Customer` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `movement_slug` to the `InventoryMovement` table without a default value. This is not possible if the table is not empty.
  - Added the required column `payment_slug` to the `Order` table without a default value. This is not possible if the table is not empty.
  - Added the required column `status_slug` to the `Order` table without a default value. This is not possible if the table is not empty.
  - Added the required column `product_name` to the `OrderItem` table without a default value. This is not possible if the table is not empty.
  - Added the required column `status_slug` to the `Product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `role_slug` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Inventory" DROP CONSTRAINT "Inventory_variant_id_fkey";

-- DropForeignKey
ALTER TABLE "InventoryMovement" DROP CONSTRAINT "InventoryMovement_store_id_fkey";

-- DropForeignKey
ALTER TABLE "OrderAddress" DROP CONSTRAINT "OrderAddress_order_id_fkey";

-- DropForeignKey
ALTER TABLE "OrderHistory" DROP CONSTRAINT "OrderHistory_order_id_fkey";

-- DropForeignKey
ALTER TABLE "OrderItem" DROP CONSTRAINT "OrderItem_order_id_fkey";

-- DropForeignKey
ALTER TABLE "OrderPayment" DROP CONSTRAINT "OrderPayment_order_id_fkey";

-- DropForeignKey
ALTER TABLE "OrderShipment" DROP CONSTRAINT "OrderShipment_order_id_fkey";

-- DropForeignKey
ALTER TABLE "ProductVariant" DROP CONSTRAINT "ProductVariant_product_id_fkey";

-- DropForeignKey
ALTER TABLE "Store" DROP CONSTRAINT "Store_owner_id_fkey";

-- DropForeignKey
ALTER TABLE "_CategoryToProduct" DROP CONSTRAINT "_CategoryToProduct_A_fkey";

-- DropForeignKey
ALTER TABLE "_CategoryToProduct" DROP CONSTRAINT "_CategoryToProduct_B_fkey";

-- DropIndex
DROP INDEX "OrderPayment_transaction_id_key";

-- DropIndex
DROP INDEX "Product_slug_key";

-- AlterTable
ALTER TABLE "Customer" DROP COLUMN "admin_notes",
ADD COLUMN     "admin_notes_to_client" TEXT,
DROP COLUMN "gender",
ADD COLUMN     "gender" TEXT,
ALTER COLUMN "phone" SET NOT NULL;

-- AlterTable
ALTER TABLE "InventoryMovement" DROP COLUMN "movement_type",
ADD COLUMN     "movement_slug" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Order" DROP COLUMN "order_status",
DROP COLUMN "payment_status",
ADD COLUMN     "payment_slug" TEXT NOT NULL,
ADD COLUMN     "status_slug" TEXT NOT NULL,
ALTER COLUMN "discount_amount" SET DATA TYPE DECIMAL(65,30),
ALTER COLUMN "grand_total" SET DATA TYPE DECIMAL(65,30),
ALTER COLUMN "shipping_cost" SET DATA TYPE DECIMAL(65,30),
ALTER COLUMN "sub_total" SET DATA TYPE DECIMAL(65,30);

-- AlterTable
ALTER TABLE "OrderHistory" DROP COLUMN "created_at",
ADD COLUMN     "created_action_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "OrderItem" ADD COLUMN     "product_name" TEXT NOT NULL,
ALTER COLUMN "price" SET DATA TYPE DECIMAL(65,30),
ALTER COLUMN "total" SET DATA TYPE DECIMAL(65,30);

-- AlterTable
ALTER TABLE "Product" DROP COLUMN "discount_type",
DROP COLUMN "primary_image",
DROP COLUMN "status",
ADD COLUMN     "status_slug" TEXT NOT NULL,
ALTER COLUMN "cost_price" SET DATA TYPE DECIMAL(65,30),
ALTER COLUMN "discount_value" SET DATA TYPE DECIMAL(65,30),
ALTER COLUMN "regular_price" SET DATA TYPE DECIMAL(65,30);

-- AlterTable
ALTER TABLE "ProductVariant" ALTER COLUMN "price" SET DATA TYPE DECIMAL(65,30);

-- AlterTable
ALTER TABLE "Store" DROP COLUMN "favicon",
DROP COLUMN "owner_id",
DROP COLUMN "plan_id";

-- AlterTable
ALTER TABLE "User" DROP COLUMN "role",
ADD COLUMN     "role_slug" TEXT NOT NULL;

-- DropTable
DROP TABLE "_CategoryToProduct";

-- DropEnum
DROP TYPE "DiscountType";

-- DropEnum
DROP TYPE "Gender";

-- DropEnum
DROP TYPE "MovementType";

-- DropEnum
DROP TYPE "OrderStatus";

-- DropEnum
DROP TYPE "PaymentStatus";

-- DropEnum
DROP TYPE "ProductStatus";

-- DropEnum
DROP TYPE "UserRole";

-- CreateTable
CREATE TABLE "Role" (
    "slug" TEXT NOT NULL,
    "name_ar" TEXT NOT NULL,
    "name_en" TEXT NOT NULL,

    CONSTRAINT "Role_pkey" PRIMARY KEY ("slug")
);

-- CreateTable
CREATE TABLE "ProductStatus" (
    "slug" TEXT NOT NULL,
    "name_ar" TEXT NOT NULL,
    "name_en" TEXT NOT NULL,

    CONSTRAINT "ProductStatus_pkey" PRIMARY KEY ("slug")
);

-- CreateTable
CREATE TABLE "OrderStatus" (
    "slug" TEXT NOT NULL,
    "name_ar" TEXT NOT NULL,
    "name_en" TEXT NOT NULL,
    "color_code" TEXT,

    CONSTRAINT "OrderStatus_pkey" PRIMARY KEY ("slug")
);

-- CreateTable
CREATE TABLE "PaymentStatus" (
    "slug" TEXT NOT NULL,
    "name_ar" TEXT NOT NULL,
    "name_en" TEXT NOT NULL,

    CONSTRAINT "PaymentStatus_pkey" PRIMARY KEY ("slug")
);

-- CreateTable
CREATE TABLE "MovementType" (
    "slug" TEXT NOT NULL,
    "name_ar" TEXT NOT NULL,
    "name_en" TEXT NOT NULL,

    CONSTRAINT "MovementType_pkey" PRIMARY KEY ("slug")
);

-- CreateTable
CREATE TABLE "StoreUser" (
    "user_id" BIGINT NOT NULL,
    "store_id" INTEGER NOT NULL,
    "role_slug" TEXT NOT NULL,

    CONSTRAINT "StoreUser_pkey" PRIMARY KEY ("user_id","store_id")
);

-- CreateTable
CREATE TABLE "ProductCategory" (
    "product_id" INTEGER NOT NULL,
    "category_id" BIGINT NOT NULL,

    CONSTRAINT "ProductCategory_pkey" PRIMARY KEY ("product_id","category_id")
);

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_role_slug_fkey" FOREIGN KEY ("role_slug") REFERENCES "Role"("slug") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StoreUser" ADD CONSTRAINT "StoreUser_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StoreUser" ADD CONSTRAINT "StoreUser_store_id_fkey" FOREIGN KEY ("store_id") REFERENCES "Store"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StoreUser" ADD CONSTRAINT "StoreUser_role_slug_fkey" FOREIGN KEY ("role_slug") REFERENCES "Role"("slug") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_status_slug_fkey" FOREIGN KEY ("status_slug") REFERENCES "ProductStatus"("slug") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductCategory" ADD CONSTRAINT "ProductCategory_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductCategory" ADD CONSTRAINT "ProductCategory_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductVariant" ADD CONSTRAINT "ProductVariant_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Inventory" ADD CONSTRAINT "Inventory_variant_id_fkey" FOREIGN KEY ("variant_id") REFERENCES "ProductVariant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryMovement" ADD CONSTRAINT "InventoryMovement_movement_slug_fkey" FOREIGN KEY ("movement_slug") REFERENCES "MovementType"("slug") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_status_slug_fkey" FOREIGN KEY ("status_slug") REFERENCES "OrderStatus"("slug") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_payment_slug_fkey" FOREIGN KEY ("payment_slug") REFERENCES "PaymentStatus"("slug") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderItem" ADD CONSTRAINT "OrderItem_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderAddress" ADD CONSTRAINT "OrderAddress_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderPayment" ADD CONSTRAINT "OrderPayment_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderHistory" ADD CONSTRAINT "OrderHistory_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderShipment" ADD CONSTRAINT "OrderShipment_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
