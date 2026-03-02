# GroundZero — Gym Management System

## Overview

GroundZero is a gym management platform built around three components: a .NET 8.0 REST API as the central backend, a Flutter mobile app for gym members, and a Flutter desktop app for administrators. The system handles everything from user registration and supplement shopping to workout tracking, appointment scheduling, and gamification through gym visit tracking.

---

## System Actors

### Administrator
Operates exclusively through the desktop app. Manages the entire gym operation — users, staff, products, inventory, orders, appointments, check-in/check-out, and business reporting. The admin account is pre-configured and cannot be registered through the app.

### User (Member)
Registers and operates through the mobile app. Can shop for supplements, book appointments with trainers and nutritionists, track workouts, leave reviews, and participate in the gamification/leaderboard system.

### Staff (Trainers & Nutritionists)
Data entities managed by the administrator. Staff members do not have app access — they are created and maintained by the admin and serve as bookable resources for appointments.

---

## Modules

### 1. Authentication & User Management

The system uses JWT authentication with short-lived access tokens and long-lived refresh tokens. Users register through the mobile app with email and password. The admin logs in with pre-seeded credentials (`desktop` / `test`).

**User capabilities:**
- Register with email, first name, last name, and password
- Log in and receive JWT access + refresh tokens
- Refresh expired access tokens without re-entering credentials
- Log out (revokes the refresh token)
- View and update profile information
- Upload and change profile picture

**Admin capabilities:**
- View all registered users (paginated, searchable)
- View individual user details
- Deactivate user accounts (soft delete)

---

### 2. Staff Management

Administrators create and manage staff profiles for trainers and nutritionists. Staff members are the backbone of the appointment system — users browse staff profiles when booking sessions.

**Admin capabilities:**
- Create, update, and deactivate staff members
- Upload staff profile images
- Assign staff type (Trainer or Nutritionist)

**Public access (mobile app):**
- Browse available staff (filterable by type)
- View staff details including bio and specialization

---

### 3. Product Catalog & Categories

The supplement shop is organized by categories. The admin manages the full product lifecycle — creation, pricing, stock levels, and images. Users browse and purchase through the mobile app.

**Admin capabilities:**
- Full CRUD on product categories (Proteini, Kreatin, Aminokiseline, Vitamini, Pre-workout, etc.)
- Full CRUD on products with image upload
- Manage stock quantities

**User capabilities:**
- Browse products with pagination
- Filter by category, search by name, filter by price range
- View product details

---

### 4. Orders & Payments

Users place orders for supplements through the mobile app. Payment is processed via Stripe (PaymentIntent flow). The admin manages order fulfillment by updating order statuses.

**Order statuses:** Pending → Confirmed → Shipped → Delivered (or Cancelled at any point)

**User capabilities:**
- Add products to an order with quantities
- Pay via Stripe
- View order history and order details

**Admin capabilities:**
- View all orders (filterable by status, user, date)
- Update order status through the fulfillment pipeline
- View order details with line items

---

### 5. Appointments & Scheduling

Users book sessions with trainers for workout guidance or with nutritionists for diet consultations. The system prevents double-booking — a staff member cannot have overlapping appointments.

**Appointment statuses:** Pending → Confirmed → Completed (or Cancelled)

**User capabilities:**
- Book an appointment with a specific staff member at a chosen date/time
- View upcoming and past appointments
- Cancel an appointment

**Admin capabilities:**
- View all appointments (filterable by status, staff, user, date)
- Confirm pending appointments
- Mark appointments as completed
- Cancel appointments

---

### 6. Reviews & Ratings

Users can leave reviews on two types of entities: products they have purchased and appointments they have completed. Each review includes a 1–5 star rating and an optional text comment.

**User capabilities:**
- Review a purchased product
- Review a completed appointment
- Edit or delete own reviews

**Public visibility:**
- Product detail pages display reviews with average rating
- Staff profiles show appointment reviews and average rating

---

### 7. Workout Tracking

Users create structured workout plans organized by days of the week. Each day contains exercises pulled from a pre-seeded library of 45+ exercises across 9 muscle groups (Chest, Back, Shoulders, Biceps, Triceps, Legs, Core, Cardio, Full Body).

**User capabilities:**
- Create named workout plans (e.g., "Push/Pull/Legs", "Upper/Lower Split")
- Add days to a plan and assign exercises with sets, reps, weight, rest time, and order
- View the weekly schedule
- Log completed workouts with timestamps and notes
- Browse workout history

**Exercise library includes:** Bench Press, Squat, Deadlift, Pull-Ups, Overhead Press, Barbell Curl, and 39 more — all pre-loaded in the database.

---

### 8. Gamification & Leaderboard

The gamification system rewards consistent gym attendance. The admin checks users in and out at the gym entrance. Visit duration is converted to XP, which drives level progression and leaderboard rankings.

**10 levels:** Početnik → Rekreativac → Vježbač → Sportista → Atlet → Warrior → Titan → Elite → Champion → Legend

**How it works:**
1. Admin checks a user in when they arrive at the gym
2. Admin checks the user out when they leave
3. The system calculates visit duration and awards XP
4. When a user's XP crosses a level threshold, they automatically level up

**User capabilities:**
- View current level, XP, total gym minutes
- View position on the leaderboard
- Browse the leaderboard (top users by level and XP)

**Admin capabilities:**
- Check users in and out
- View gym visit history

---

### 9. Product Recommendations

The system provides product recommendations using collaborative filtering — "Users who bought X also bought Y". Recommendations are computed in real-time from order history using pure database queries, with no external ML service.

**Two recommendation types:**

**Product-based** — shown on product detail pages. The system finds all orders containing that product, extracts other products from those same orders, ranks them by co-purchase frequency, and returns the top results. Out-of-stock products are excluded.

**User-based** — shown on the mobile app home screen as "Recommended for you". The system looks at everything the user has purchased, finds co-purchased products across all matching orders, excludes products the user already owns, and ranks by frequency.

Only orders with valid statuses (Confirmed, Shipped, Delivered) contribute to recommendations. Cancelled and Pending orders are ignored.

---

### 10. Business Reports & Export

The admin has access to a reporting module with export capabilities. All reports support date range filtering and are generated server-side — the API produces the file and the desktop app downloads it.

**Report types:**

| Report | What it covers |
|--------|---------------|
| Revenue | Monthly/quarterly/yearly revenue from product sales and appointments |
| Products | Best sellers, current stock levels, low inventory alerts |
| Users | Registration trends, active users, retention metrics |
| Appointments | Most booked staff, peak hours, cancellation rates |
| Gamification | User engagement, average gym time, leaderboard statistics |

**Export formats:**
- **PDF** — formatted, printable reports with tables
- **Excel (.xlsx)** — raw data with sheets, filterable, suitable for further analysis

---

## API Design

The API follows strict REST conventions:

- `GET /api/{resource}` — paginated list with filters
- `GET /api/{resource}/{id}` — single resource
- `POST /api/{resource}` — create (returns 201)
- `PUT /api/{resource}/{id}` — full update (returns 200)
- `DELETE /api/{resource}/{id}` — soft delete (returns 204)

All list endpoints support pagination (`pageNumber`, `pageSize`) and text search. Entity-specific filters are available where relevant (e.g., category filter on products, status filter on orders, staff type filter).

No response wrapper is used — successful requests return the raw data, errors return `{ errors, statusCode }`.

All endpoints require authentication except login, registration, and token refresh. Role-based authorization is enforced at the business logic layer, not at the controller level.

---

## Technical Stack

| Component | Technology |
|-----------|-----------|
| Backend | .NET 8.0 Web API |
| Database | SQL Server |
| ORM | Entity Framework Core 8 |
| Auth | JWT + Refresh Tokens (BCrypt password hashing) |
| Payments | Stripe (PaymentIntent flow) |
| PDF Export | QuestPDF |
| Excel Export | ClosedXML |
| CQRS | MediatR |
| Validation | FluentValidation |
| Mobile App | Flutter |
| Desktop App | Flutter |

---

## Test Accounts

| Role | Email | Password | Platform |
|------|-------|----------|----------|
| Admin | `desktop` | `test` | Desktop App |
| User | `user@test.com` | `test` | Mobile App |

Additional test users: `amir@test.com`, `lejla@test.com`, `edin@test.com`, `selma@test.com`, `kenan@test.com` — all with password `test`.
