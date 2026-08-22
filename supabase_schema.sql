-- ==========================================
-- RESTAURANT APP DATABASE SCHEMA FOR SUPABASE
-- ==========================================

-- تفعيل إضافات قاعدة البيانات المطلوبة
create extension if not exists "uuid-ossp";

-- تنظيف الجداول القديمة إذا كانت موجودة لتمكين إعادة التشغيل الآمن
drop trigger if exists on_auth_user_created on auth.users;
drop function if exists public.handle_new_user();
drop table if exists public.order_items cascade;
drop table if exists public.orders cascade;
drop table if exists public.favorites cascade;
drop table if exists public.profiles cascade;
drop table if exists public.products cascade;
drop table if exists public.categories cascade;

-- ==========================================
-- 1. جدول الأقسام (Categories)
-- ==========================================
create table public.categories (
    id uuid primary key default gen_random_uuid(),
    name text not null,
    image_url text not null,
    created_at timestamptz default now() not null
);

-- ==========================================
-- 2. جدول المنتجات (Products)
-- ==========================================
create table public.products (
    id uuid primary key default gen_random_uuid(),
    name text not null,
    description text default '' not null,
    price numeric not null check (price >= 0),
    image_url text not null,
    category_id uuid references public.categories(id) on delete set null,
    rating numeric default 0 check (rating >= 0 and rating <= 5),
    is_best_seller boolean default false not null,
    is_recommended boolean default false not null,
    created_at timestamptz default now() not null
);

-- ==========================================
-- 3. جدول بيانات المستخدمين (Profiles)
-- ==========================================
create table public.profiles (
    id uuid primary key references auth.users(id) on delete cascade,
    name text default '' not null,
    phone_number text default '',
    avatar_url text default '',
    created_at timestamptz default now() not null,
    updated_at timestamptz default now() not null
);

-- ==========================================
-- 4. جدول المفضلة (Favorites)
-- ==========================================
create table public.favorites (
    id uuid primary key default gen_random_uuid(),
    user_id uuid references auth.users(id) on delete cascade not null,
    product_id uuid references public.products(id) on delete cascade not null,
    created_at timestamptz default now() not null,
    constraint unique_user_product unique (user_id, product_id)
);

-- ==========================================
-- 5. جدول الطلبات (Orders)
-- ==========================================
create table public.orders (
    id uuid primary key default gen_random_uuid(),
    user_id uuid references auth.users(id) on delete cascade not null,
    order_number text unique not null,
    status text default 'Active' not null check (status in ('Active', 'Completed', 'Cancelled')),
    subtotal numeric not null check (subtotal >= 0),
    tax_and_fees numeric default 0.0 not null check (tax_and_fees >= 0),
    delivery_fee numeric default 0.0 not null check (delivery_fee >= 0),
    total numeric not null check (total >= 0),
    shipping_address text not null,
    created_at timestamptz default now() not null
);

-- ==========================================
-- 6. جدول عناصر الطلب (Order Items)
-- ==========================================
create table public.order_items (
    id uuid primary key default gen_random_uuid(),
    order_id uuid references public.orders(id) on delete cascade not null,
    product_id uuid references public.products(id) on delete set null,
    quantity integer default 1 not null check (quantity > 0),
    price numeric not null check (price >= 0),
    created_at timestamptz default now() not null
);

-- ==========================================
-- تفعيل حماية البيانات (Row Level Security - RLS)
-- ==========================================
alter table public.categories enable row level security;
alter table public.products enable row level security;
alter table public.profiles enable row level security;
alter table public.favorites enable row level security;
alter table public.orders enable row level security;
alter table public.order_items enable row level security;

-- ==========================================
-- سياسات الأمان (RLS Policies)
-- ==========================================

-- سياسات الأقسام (Categories)
create policy "Categories: Allow public read access" 
    on public.categories for select using (true);

create policy "Categories: Allow full access for service role only" 
    on public.categories for all using (auth.role() = 'service_role');

-- سياسات المنتجات (Products)
create policy "Products: Allow public read access" 
    on public.products for select using (true);

create policy "Products: Allow full access for service role only" 
    on public.products for all using (auth.role() = 'service_role');

-- سياسات الملف الشخصي (Profiles)
create policy "Profiles: Allow users to view their own profile" 
    on public.profiles for select using (auth.uid() = id);

create policy "Profiles: Allow users to update their own profile" 
    on public.profiles for update using (auth.uid() = id);

-- سياسات المفضلة (Favorites)
create policy "Favorites: Allow users to view their own favorites" 
    on public.favorites for select using (auth.uid() = user_id);

create policy "Favorites: Allow users to insert their own favorites" 
    on public.favorites for insert with check (auth.uid() = user_id);

create policy "Favorites: Allow users to delete their own favorites" 
    on public.favorites for delete using (auth.uid() = user_id);

-- سياسات الطلبات (Orders)
create policy "Orders: Allow users to view their own orders" 
    on public.orders for select using (auth.uid() = user_id);

create policy "Orders: Allow users to create their own orders" 
    on public.orders for insert with check (auth.uid() = user_id);

-- سياسات تفاصيل الطلبات (Order Items)
create policy "Order Items: Allow users to view their own order items" 
    on public.order_items for select using (
        exists (
            select 1 from public.orders 
            where orders.id = order_items.order_id 
            and orders.user_id = auth.uid()
        )
    );

create policy "Order Items: Allow users to insert their own order items" 
    on public.order_items for insert with check (
        exists (
            select 1 from public.orders 
            where orders.id = order_items.order_id 
            and orders.user_id = auth.uid()
        )
    );

-- ==========================================
-- Triggers لإنشاء الملف الشخصي تلقائياً عند التسجيل
-- ==========================================
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, name, avatar_url, phone_number)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'name', new.raw_user_meta_data->>'full_name', split_part(new.email, '@', 1)),
    coalesce(new.raw_user_meta_data->>'avatar_url', ''),
    coalesce(new.raw_user_meta_data->>'phone_number', '')
  );
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- ==========================================
-- إدخال البيانات التجريبية (Seed Data)
-- ==========================================

-- 1. إضافة الأقسام
insert into public.categories (id, name, image_url) values
('c7e2b178-0cb9-4a7b-a36c-2f9f8c6b71f2', 'Pizza', 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=200&auto=format&fit=crop&q=60'),
('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 'Burger', 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=200&auto=format&fit=crop&q=60'),
('b2c3d4e5-f6a7-8b9c-0d1e-2f3a4b5c6d7e', 'Beverages', 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=200&auto=format&fit=crop&q=60'),
('c3d4e5f6-a7b8-9c0d-1e2f-3a4b5c6d7e8f', 'Dessert', 'https://images.unsplash.com/photo-1551024601-bec78aea704b?w=200&auto=format&fit=crop&q=60'),
('d4e5f6a7-b8c9-0d1e-2f3a-4b5c6d7e8f9a', 'Mexican', 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=200&auto=format&fit=crop&q=60');

-- 2. إضافة المنتجات التجريبية (متوافقة تماماً مع التصميم)
insert into public.products (id, name, description, price, image_url, category_id, rating, is_best_seller, is_recommended) values
-- وجبة مكسيكية مقبلات (Mexican Appetizer)
('e5f6a7b8-c9d0-1e2f-3a4b-5c6d7e8f9a0b', 'Mexican Appetizer', 'Tortilla Chips With Sauce', 15.00, 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=500&auto=format&fit=crop&q=60', 'd4e5f6a7-b8c9-0d1e-2f3a-4b5c6d7e8f9a', 4.5, true, true),

-- مشروب الفراولة المخفوق (Strawberry Shake)
('f6a7b8c9-d0e1-2f3a-4b5c-6d7e8f9a0b1c', 'Strawberry Shake', 'Fresh strawberry milkshake with whipped cream', 8.50, 'https://images.unsplash.com/photo-1579954115545-a95591f28bfc?w=500&auto=format&fit=crop&q=60', 'b2c3d4e5-f6a7-8b9c-0d1e-2f3a4b5c6d7e', 4.8, true, false),

-- بيتزا دوبا (Duba Pizza)
('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'Duba Pizza', 'Classic cheese and tomato pizza with thin crust', 22.00, 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500&auto=format&fit=crop&q=60', 'c7e2b178-0cb9-4a7b-a36c-2f9f8c6b71f2', 4.3, false, true),

-- لازانيا البروكلي (Broccoli Lasagna)
('b8c9d0e1-f2a3-4b5c-6d7e-8f9a0b1c2d3e', 'Broccoli Lasagna', 'Baked layers of pasta, broccoli, and rich cheese sauce', 18.00, 'https://images.unsplash.com/photo-1574894709920-11b28e7367e3?w=500&auto=format&fit=crop&q=60', 'c7e2b178-0cb9-4a7b-a36c-2f9f8c6b71f2', 4.6, true, false),

-- كاري الدجاج (Chicken Curry)
('c9d0e1f2-a3b4-5c6d-7e8f-9a0b1c2d3e4f', 'Chicken Curry', 'Spicy chicken curry with rice', 20.00, 'https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=500&auto=format&fit=crop&q=60', 'd4e5f6a7-b8c9-0d1e-2f3a-4b5c6d7e8f9a', 4.4, false, true),

-- سوشي رول (Sushi Roll)
('d0e1f2a3-b4c5-6d7e-8f9a-0b1c2d3e4f5a', 'Sushi Roll', 'Premium fresh sushi rolls with soy sauce', 25.00, 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=500&auto=format&fit=crop&q=60', 'c3d4e5f6-a7b8-9c0d-1e2f-3a4b5c6d7e8f', 4.7, true, false),

-- شاي التوت والفواكه (Fruit and Berry Tea)
('e1f2a3b4-c5d6-7e8f-9a0b-1c2d3e4f5a6b', 'Fruit and Berry Tea', 'Hot herbal tea with fresh fruits and berries', 6.00, 'https://images.unsplash.com/photo-1576092768241-dec231879fc3?w=500&auto=format&fit=crop&q=60', 'b2c3d4e5-f6a7-8b9c-0d1e-2f3a4b5c6d7e', 4.9, false, true),

-- دبل تشيز برجر (Double Cheese Burger)
('f0a1b2c3-d4e5-6f7a-8b9c-0d1e2f3a4b5c', 'Double Cheese Burger', 'Juicy double beef patty with melted cheddar cheese', 12.00, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500&auto=format&fit=crop&q=60', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 4.8, true, true),

-- كيكة اللافا بالشوكولاتة (Chocolate Lava Cake)
('0a1b2c3d-4e5f-6a7b-8c9d-0e1f2a3b4c5d', 'Chocolate Lava Cake', 'Warm chocolate cake with a molten chocolate center', 9.50, 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=500&auto=format&fit=crop&q=60', 'c3d4e5f6-a7b8-9c0d-1e2f-3a4b5c6d7e8f', 4.9, true, true),

-- توست الأفوكادو (Avocado Toast)
('1b2c3d4e-5f6a-7b8c-9d0e-1f2a3b4c5d6e', 'Avocado Toast', 'Toasted sourdough with mashed avocado and cherry tomatoes', 11.00, 'https://images.unsplash.com/photo-1541532713592-79a0317b6b77?w=500&auto=format&fit=crop&q=60', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 4.5, false, true),

-- ماكياتو كراميل مثلج (Iced Caramel Macchiato)
('2c3d4e5f-6a7b-8c9d-0e1f-2a3b4c5d6e7f', 'Iced Caramel Macchiato', 'Cold espresso drink with milk, vanilla syrup, and caramel drizzle', 7.00, 'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500&auto=format&fit=crop&q=60', 'b2c3d4e5-f6a7-8b9c-0d1e-2f3a4b5c6d7e', 4.7, true, true);
