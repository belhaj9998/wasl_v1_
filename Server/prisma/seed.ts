import dotenv from "dotenv";
import  prisma from "../src/Configs/prisma";
dotenv.config();


const permissionSeeds = [
  {
    code: "catalog.view",
    module: "catalog",
    action: "view",
    description: "View categories, products, variants, and catalog structure.",
  },
  {
    code: "categories.manage",
    module: "categories",
    action: "manage",
    description: "Create, update, and archive categories.",
  },
  {
    code: "products.view",
    module: "products",
    action: "view",
    description: "View products and product details.",
  },
  {
    code: "products.create",
    module: "products",
    action: "create",
    description: "Create new products.",
  },
  {
    code: "products.update",
    module: "products",
    action: "update",
    description: "Edit products and publishing settings.",
  },
  {
    code: "products.delete",
    module: "products",
    action: "delete",
    description: "Archive or delete products.",
  },
  {
    code: "variants.manage",
    module: "variants",
    action: "manage",
    description: "Manage product variants and option combinations.",
  },
  {
    code: "inventory.view",
    module: "inventory",
    action: "view",
    description: "View stock levels and inventory movements.",
  },
  {
    code: "inventory.adjust",
    module: "inventory",
    action: "adjust",
    description: "Adjust stock quantities and reservations.",
  },
  {
    code: "customers.view",
    module: "customers",
    action: "view",
    description: "View customer profiles and order history.",
  },
  {
    code: "customers.manage",
    module: "customers",
    action: "manage",
    description: "Create, edit, block, or archive customers.",
  },
  {
    code: "orders.view",
    module: "orders",
    action: "view",
    description: "View orders and order details.",
  },
  {
    code: "orders.create",
    module: "orders",
    action: "create",
    description: "Create manual orders from the admin side.",
  },
  {
    code: "orders.update",
    module: "orders",
    action: "update",
    description: "Edit notes and order metadata.",
  },
  {
    code: "orders.manage_status",
    module: "orders",
    action: "manage_status",
    description: "Advance or change order workflow states.",
  },
  {
    code: "payments.view",
    module: "payments",
    action: "view",
    description: "View payment transactions and payment state.",
  },
  {
    code: "shipments.manage",
    module: "shipments",
    action: "manage",
    description: "Create shipments, tracking data, and delivery updates.",
  },
  {
    code: "coupons.manage",
    module: "coupons",
    action: "manage",
    description: "Create and manage discount coupons.",
  },
  {
    code: "analytics.view",
    module: "analytics",
    action: "view",
    description: "View reports and store performance analytics.",
  },
  {
    code: "staff.manage",
    module: "staff",
    action: "manage",
    description: "Invite staff and assign roles and permissions.",
  },
  {
    code: "settings.manage",
    module: "settings",
    action: "manage",
    description: "Manage store settings, domains, and branding.",
  },
] as const;

const subscriptionPlans = [
  {
    code: "starter",
    name: "Starter",
    price_monthly: "39",
    price_yearly: "390",
    max_stores: 1,
    max_products: 500,
    max_staff: 5,
  },
  {
    code: "growth",
    name: "Growth",
    price_monthly: "99",
    price_yearly: "990",
    max_stores: 3,
    max_products: 5000,
    max_staff: 20,
  },
  {
    code: "scale",
    name: "Scale",
    price_monthly: "249",
    price_yearly: "2490",
    max_stores: 10,
    max_products: 50000,
    max_staff: 100,
  },
] as const;

const defaultRoleTemplates = [
  {
    name: "Owner",
    slug: "owner",
    description: "Full control over the store, staff, and settings.",
    is_protected: true,
    permissions: permissionSeeds.map((permission) => permission.code),
  },
  {
    name: "Admin",
    slug: "admin",
    description: "Runs daily store operations except ownership-level decisions.",
    is_protected: true,
    permissions: [
      "catalog.view",
      "categories.manage",
      "products.view",
      "products.create",
      "products.update",
      "products.delete",
      "variants.manage",
      "inventory.view",
      "inventory.adjust",
      "customers.view",
      "customers.manage",
      "orders.view",
      "orders.create",
      "orders.update",
      "orders.manage_status",
      "payments.view",
      "shipments.manage",
      "coupons.manage",
      "analytics.view",
      "staff.manage",
      "settings.manage",
    ],
  },
  {
    name: "Catalog Manager",
    slug: "catalog-manager",
    description: "Owns products, categories, and publishing.",
    is_protected: false,
    permissions: [
      "catalog.view",
      "categories.manage",
      "products.view",
      "products.create",
      "products.update",
      "products.delete",
      "variants.manage",
      "inventory.view",
    ],
  },
  {
    name: "Order Manager",
    slug: "order-manager",
    description: "Owns the order lifecycle from review to shipment updates.",
    is_protected: false,
    permissions: [
      "orders.view",
      "orders.create",
      "orders.update",
      "orders.manage_status",
      "customers.view",
      "customers.manage",
      "payments.view",
      "shipments.manage",
    ],
  },

  {
    name: "Inventory Manager",
    slug: "inventory-manager",
    description: "Controls stock adjustments and inventory visibility.",
    is_protected: false,
    permissions: [
      "products.view",
      "inventory.view",
      "inventory.adjust",
      "orders.view",
    ],
  },
  {
    name: "Staff",
    slug: "staff",
    description: "Read-heavy access for day-to-day support tasks.",
    is_protected: false,
    permissions: [
      "catalog.view",
      "products.view",
      "inventory.view",
      "customers.view",
      "orders.view",
      "payments.view",
    ],
  },
] as const;

async function seedPermissions() {
  for (const permission of permissionSeeds) {
    await prisma.permission.upsert({
      where: { code: permission.code },
      update: {
        module: permission.module,
        action: permission.action,
        description: permission.description,
      },
      create: permission,
    });
  }
}

async function seedSubscriptionPlans() {
  for (const plan of subscriptionPlans) {
    await prisma.subscriptionPlan.upsert({
      where: { code: plan.code },
      update: {
        name: plan.name,
        price_monthly: plan.price_monthly,
        price_yearly: plan.price_yearly,
        max_stores: plan.max_stores,
        max_products: plan.max_products,
        max_staff: plan.max_staff,
      },
      create: plan,
    });
  }
}
async function seedDemoStore() {
  // إنشاء متجر تجريبي لكي نتمكن من اختبار ربط الصلاحيات به
  await prisma.store.upsert({
    where: { domain: 'demo' },
    update: {},
    create: {
      name: 'متجر وصل التجريبي',
      domain: 'demo',
      // ضع هنا أي حقول إجبارية أخرى يطلبها منك نموذج الـ Store
    },
  });
}
async function seedDefaultRolesForExistingStores() {
  const stores = await prisma.store.findMany({
    select: { id: true },
  });

  for (const store of stores) {
    for (const roleTemplate of defaultRoleTemplates) {
      const existingRole = await prisma.storeRole.findUnique({
        where: {
          store_id_slug: {
            store_id: store.id,
            slug: roleTemplate.slug,
          },
        },
      });

      if (existingRole) {
        continue;
      }

      await prisma.storeRole.create({
        data: {
          store_id: store.id,
          name: roleTemplate.name,
          slug: roleTemplate.slug,
          description: roleTemplate.description,
          is_default: true,
          is_protected: roleTemplate.is_protected,
          permissions: {
            create: roleTemplate.permissions.map((permissionCode) => ({
              permission: {
                connect: {
                  code: permissionCode,
                },
              },
            })),
          },
        },
      });
    }
  }
}

async function main() {
  await seedPermissions();
  await seedSubscriptionPlans();
  
  // 1. ننشئ المتجر أولاً
  await seedDemoStore(); 
  
  // 2. الآن هذه الدالة ستجد متجراً لتزرع فيه الصلاحيات!
  await seedDefaultRolesForExistingStores();
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (error) => {
    console.error("Seed failed:", error);
    await prisma.$disconnect();
    process.exit(1);
  });
