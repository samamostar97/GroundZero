using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Infrastructure.Data;

public static class DataSeeder
{
    public static async Task SeedAsync(ApplicationDbContext context)
    {
        await SeedAdminAsync(context);
        await SeedExercisesAsync(context);
        await SeedLevelsAsync(context);
        await SeedTestDataAsync(context);
        await SeedMembershipPlansAsync(context);
        await SeedTestMembershipsAsync(context);
    }

    private static async Task SeedAdminAsync(ApplicationDbContext context)
    {
        if (await context.Users.AnyAsync(u => u.Role == Role.Admin))
            return;

        var adminUsername = Environment.GetEnvironmentVariable("ADMIN_USERNAME") ?? "desktop";
        var adminPassword = Environment.GetEnvironmentVariable("ADMIN_PASSWORD") ?? "test";

        var admin = new User
        {
            FirstName = "Admin",
            LastName = "Admin",
            Email = adminUsername,
            PasswordHash = BCrypt.Net.BCrypt.HashPassword(adminPassword),
            Role = Role.Admin,
            CreatedAt = DateTime.UtcNow
        };

        await context.Users.AddAsync(admin);
        await context.SaveChangesAsync();
    }

    private static async Task SeedExercisesAsync(ApplicationDbContext context)
    {
        if (await context.Exercises.AnyAsync())
            return;

        var exercises = new List<Exercise>
        {
            // Chest
            new() { Name = "Bench Press", MuscleGroup = MuscleGroup.Chest, Description = "Barbell bench press on flat bench" },
            new() { Name = "Incline Bench Press", MuscleGroup = MuscleGroup.Chest, Description = "Barbell press on incline bench" },
            new() { Name = "Decline Bench Press", MuscleGroup = MuscleGroup.Chest, Description = "Barbell press on decline bench" },
            new() { Name = "Dumbbell Flyes", MuscleGroup = MuscleGroup.Chest, Description = "Dumbbell flyes on flat bench" },
            new() { Name = "Cable Crossover", MuscleGroup = MuscleGroup.Chest, Description = "Cable crossover for chest isolation" },
            new() { Name = "Push-Ups", MuscleGroup = MuscleGroup.Chest, Description = "Bodyweight push-ups" },
            new() { Name = "Chest Dips", MuscleGroup = MuscleGroup.Chest, Description = "Dips targeting chest muscles" },

            // Back
            new() { Name = "Deadlift", MuscleGroup = MuscleGroup.Back, Description = "Conventional barbell deadlift" },
            new() { Name = "Pull-Ups", MuscleGroup = MuscleGroup.Back, Description = "Bodyweight pull-ups" },
            new() { Name = "Barbell Row", MuscleGroup = MuscleGroup.Back, Description = "Bent-over barbell row" },
            new() { Name = "Lat Pulldown", MuscleGroup = MuscleGroup.Back, Description = "Cable lat pulldown" },
            new() { Name = "Seated Cable Row", MuscleGroup = MuscleGroup.Back, Description = "Seated cable row for mid-back" },
            new() { Name = "T-Bar Row", MuscleGroup = MuscleGroup.Back, Description = "T-bar row for back thickness" },

            // Shoulders
            new() { Name = "Overhead Press", MuscleGroup = MuscleGroup.Shoulders, Description = "Standing barbell overhead press" },
            new() { Name = "Dumbbell Lateral Raise", MuscleGroup = MuscleGroup.Shoulders, Description = "Lateral raises for side delts" },
            new() { Name = "Front Raise", MuscleGroup = MuscleGroup.Shoulders, Description = "Dumbbell front raises" },
            new() { Name = "Face Pull", MuscleGroup = MuscleGroup.Shoulders, Description = "Cable face pulls for rear delts" },
            new() { Name = "Arnold Press", MuscleGroup = MuscleGroup.Shoulders, Description = "Dumbbell Arnold press" },

            // Biceps
            new() { Name = "Barbell Curl", MuscleGroup = MuscleGroup.Biceps, Description = "Standing barbell curl" },
            new() { Name = "Dumbbell Curl", MuscleGroup = MuscleGroup.Biceps, Description = "Standing dumbbell curl" },
            new() { Name = "Hammer Curl", MuscleGroup = MuscleGroup.Biceps, Description = "Dumbbell hammer curls" },
            new() { Name = "Preacher Curl", MuscleGroup = MuscleGroup.Biceps, Description = "Preacher bench curl" },

            // Triceps
            new() { Name = "Tricep Pushdown", MuscleGroup = MuscleGroup.Triceps, Description = "Cable tricep pushdown" },
            new() { Name = "Overhead Tricep Extension", MuscleGroup = MuscleGroup.Triceps, Description = "Overhead dumbbell tricep extension" },
            new() { Name = "Skull Crushers", MuscleGroup = MuscleGroup.Triceps, Description = "Lying barbell tricep extension" },
            new() { Name = "Close-Grip Bench Press", MuscleGroup = MuscleGroup.Triceps, Description = "Close-grip barbell bench press" },

            // Legs
            new() { Name = "Squat", MuscleGroup = MuscleGroup.Legs, Description = "Barbell back squat" },
            new() { Name = "Front Squat", MuscleGroup = MuscleGroup.Legs, Description = "Barbell front squat" },
            new() { Name = "Leg Press", MuscleGroup = MuscleGroup.Legs, Description = "Machine leg press" },
            new() { Name = "Romanian Deadlift", MuscleGroup = MuscleGroup.Legs, Description = "Romanian deadlift for hamstrings" },
            new() { Name = "Leg Curl", MuscleGroup = MuscleGroup.Legs, Description = "Machine leg curl" },
            new() { Name = "Leg Extension", MuscleGroup = MuscleGroup.Legs, Description = "Machine leg extension" },
            new() { Name = "Calf Raise", MuscleGroup = MuscleGroup.Legs, Description = "Standing calf raise" },
            new() { Name = "Bulgarian Split Squat", MuscleGroup = MuscleGroup.Legs, Description = "Single-leg split squat" },
            new() { Name = "Lunges", MuscleGroup = MuscleGroup.Legs, Description = "Walking or stationary lunges" },

            // Core
            new() { Name = "Plank", MuscleGroup = MuscleGroup.Core, Description = "Isometric plank hold" },
            new() { Name = "Crunches", MuscleGroup = MuscleGroup.Core, Description = "Abdominal crunches" },
            new() { Name = "Hanging Leg Raise", MuscleGroup = MuscleGroup.Core, Description = "Hanging leg raises for lower abs" },
            new() { Name = "Russian Twist", MuscleGroup = MuscleGroup.Core, Description = "Seated Russian twist for obliques" },
            new() { Name = "Ab Rollout", MuscleGroup = MuscleGroup.Core, Description = "Ab wheel rollout" },

            // Cardio
            new() { Name = "Treadmill Running", MuscleGroup = MuscleGroup.Cardio, Description = "Running on treadmill" },
            new() { Name = "Cycling", MuscleGroup = MuscleGroup.Cardio, Description = "Stationary bike cycling" },
            new() { Name = "Rowing Machine", MuscleGroup = MuscleGroup.Cardio, Description = "Rowing machine cardio" },
            new() { Name = "Jump Rope", MuscleGroup = MuscleGroup.Cardio, Description = "Jump rope cardio" },

            // FullBody
            new() { Name = "Burpees", MuscleGroup = MuscleGroup.FullBody, Description = "Full body burpee exercise" },
            new() { Name = "Clean and Press", MuscleGroup = MuscleGroup.FullBody, Description = "Barbell clean and press" },
            new() { Name = "Kettlebell Swing", MuscleGroup = MuscleGroup.FullBody, Description = "Two-hand kettlebell swing" },
            new() { Name = "Thrusters", MuscleGroup = MuscleGroup.FullBody, Description = "Barbell front squat to overhead press" }
        };

        await context.Exercises.AddRangeAsync(exercises);
        await context.SaveChangesAsync();
    }

    private static async Task SeedLevelsAsync(ApplicationDbContext context)
    {
        if (await context.Levels.AnyAsync())
            return;

        var levels = new List<Level>
        {
            new() { Name = "Početnik", MinXP = 0, MaxXP = 99 },
            new() { Name = "Rekreativac", MinXP = 100, MaxXP = 249 },
            new() { Name = "Vježbač", MinXP = 250, MaxXP = 499 },
            new() { Name = "Sportista", MinXP = 500, MaxXP = 999 },
            new() { Name = "Atlet", MinXP = 1000, MaxXP = 1999 },
            new() { Name = "Warrior", MinXP = 2000, MaxXP = 3499 },
            new() { Name = "Titan", MinXP = 3500, MaxXP = 5499 },
            new() { Name = "Elite", MinXP = 5500, MaxXP = 7999 },
            new() { Name = "Champion", MinXP = 8000, MaxXP = 11999 },
            new() { Name = "Legend", MinXP = 12000, MaxXP = int.MaxValue }
        };

        await context.Levels.AddRangeAsync(levels);
        await context.SaveChangesAsync();
    }

    private static async Task SeedTestDataAsync(ApplicationDbContext context)
    {
        // Guard: only seed once — check if test users already exist
        if (await context.Users.AnyAsync(u => u.Role == Role.User))
            return;

        var now = DateTime.UtcNow;

        // ──────────────────────────────────────────────
        // USERS (6 members + admin already exists)
        // ──────────────────────────────────────────────
        var users = new List<User>
        {
            new()
            {
                FirstName = "Amir", LastName = "Hadžić", Email = "amir@test.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("test"),
                Role = Role.User, Level = 3, XP = 320, TotalGymMinutes = 2400,
                CreatedAt = now.AddDays(-90)
            },
            new()
            {
                FirstName = "Lejla", LastName = "Kovačević", Email = "lejla@test.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("test"),
                Role = Role.User, Level = 5, XP = 1100, TotalGymMinutes = 5800,
                CreatedAt = now.AddDays(-180)
            },
            new()
            {
                FirstName = "Edin", LastName = "Begović", Email = "edin@test.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("test"),
                Role = Role.User, Level = 2, XP = 150, TotalGymMinutes = 1200,
                CreatedAt = now.AddDays(-45)
            },
            new()
            {
                FirstName = "Selma", LastName = "Mujić", Email = "selma@test.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("test"),
                Role = Role.User, Level = 4, XP = 600, TotalGymMinutes = 3600,
                CreatedAt = now.AddDays(-120)
            },
            new()
            {
                FirstName = "Kenan", LastName = "Delić", Email = "kenan@test.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("test"),
                Role = Role.User, Level = 1, XP = 50, TotalGymMinutes = 400,
                CreatedAt = now.AddDays(-14)
            },
            new()
            {
                // Generic test user for mobile app
                FirstName = "Test", LastName = "User", Email = "user@test.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("test"),
                Role = Role.User, Level = 2, XP = 180, TotalGymMinutes = 900,
                CreatedAt = now.AddDays(-60)
            }
        };

        await context.Users.AddRangeAsync(users);
        await context.SaveChangesAsync();

        // ──────────────────────────────────────────────
        // STAFF (4 trainers + 2 nutritionists)
        // ──────────────────────────────────────────────
        var staff = new List<Staff>
        {
            new()
            {
                FirstName = "Mirza", LastName = "Terzić", Email = "mirza@groundzero.ba",
                Phone = "+38761111111", StaffType = StaffType.Trainer, IsActive = true,
                Bio = "Certificirani personal trainer sa 8 godina iskustva u funkcionalnom treningu.",
                ProfileImageUrl = "/seed/mirza.jpg",
                CreatedAt = now.AddDays(-200)
            },
            new()
            {
                FirstName = "Amila", LastName = "Bašić", Email = "amila@groundzero.ba",
                Phone = "+38761222222", StaffType = StaffType.Trainer, IsActive = true,
                Bio = "Specijalistkinja za snagu i kondiciju, bivša reprezentativka u atletici.",
                ProfileImageUrl = "/seed/amila.jpg",
                CreatedAt = now.AddDays(-180)
            },
            new()
            {
                FirstName = "Haris", LastName = "Čolić", Email = "haris@groundzero.ba",
                Phone = "+38761333333", StaffType = StaffType.Trainer, IsActive = true,
                Bio = "Bodybuilding trener sa fokusom na hipertrofiju i pripremu za takmičenja.",
                ProfileImageUrl = "/seed/haris.jpg",
                CreatedAt = now.AddDays(-150)
            },
            new()
            {
                FirstName = "Dženan", LastName = "Imamović", Email = "dzenan@groundzero.ba",
                Phone = "+38761444444", StaffType = StaffType.Trainer, IsActive = false,
                Bio = "Crossfit i HIIT trener. Trenutno na pauziranju.",
                ProfileImageUrl = "/seed/dzenan.jpg",
                CreatedAt = now.AddDays(-300)
            },
            new()
            {
                FirstName = "Naida", LastName = "Softić", Email = "naida@groundzero.ba",
                Phone = "+38761555555", StaffType = StaffType.Nutritionist, IsActive = true,
                Bio = "Diplomirana nutricionistkinja sa specijalizacijom u sportskoj ishrani.",
                ProfileImageUrl = "/seed/naida.jpg",
                CreatedAt = now.AddDays(-160)
            },
            new()
            {
                FirstName = "Faruk", LastName = "Hodžić", Email = "faruk@groundzero.ba",
                Phone = "+38761666666", StaffType = StaffType.Nutritionist, IsActive = true,
                Bio = "Nutricionista sa fokusom na planove ishrane za mršavljenje i dobijanje mase.",
                ProfileImageUrl = "/seed/faruk.jpg",
                CreatedAt = now.AddDays(-100)
            }
        };

        await context.Staff.AddRangeAsync(staff);
        await context.SaveChangesAsync();

        // ──────────────────────────────────────────────
        // PRODUCT CATEGORIES (5)
        // ──────────────────────────────────────────────
        var categories = new List<ProductCategory>
        {
            new() { Name = "Proteini", Description = "Whey, casein, biljni proteini i proteinske mješavine", CreatedAt = now.AddDays(-200) },
            new() { Name = "Kreatin", Description = "Kreatin monohidrat i druge forme kreatina", CreatedAt = now.AddDays(-200) },
            new() { Name = "Aminokiseline", Description = "BCAA, EAA, glutamin i ostale aminokiseline", CreatedAt = now.AddDays(-200) },
            new() { Name = "Vitamini i minerali", Description = "Multivitamini, vitamin D, cink, magnezij i ostali mikronutrijenti", CreatedAt = now.AddDays(-200) },
            new() { Name = "Pre-workout", Description = "Pre-workout formule za energiju i fokus tokom treninga", CreatedAt = now.AddDays(-200) }
        };

        await context.ProductCategories.AddRangeAsync(categories);
        await context.SaveChangesAsync();

        // ──────────────────────────────────────────────
        // PRODUCTS (20)
        // ──────────────────────────────────────────────
        var proteini = categories[0].Id;
        var kreatin = categories[1].Id;
        var amino = categories[2].Id;
        var vitamini = categories[3].Id;
        var preworkout = categories[4].Id;

        var products = new List<Product>
        {
            // Proteini (6)
            new() { Name = "Whey Gold Standard 2.27kg", Description = "Optimum Nutrition 100% Whey Gold Standard, čokolada", Price = 89.90m, StockQuantity = 25, CategoryId = proteini, ImageUrl = "/seed/protein_powder_1.jpg", CreatedAt = now.AddDays(-180) },
            new() { Name = "Whey Gold Standard 900g", Description = "Optimum Nutrition 100% Whey Gold Standard, vanilija", Price = 45.90m, StockQuantity = 40, CategoryId = proteini, ImageUrl = "/seed/protein_powder_2.jpg", CreatedAt = now.AddDays(-180) },
            new() { Name = "Casein Gold Standard 1.8kg", Description = "Optimum Nutrition Gold Standard Casein, čokolada", Price = 79.90m, StockQuantity = 15, CategoryId = proteini, ImageUrl = "/seed/protein_powder_3.jpg", CreatedAt = now.AddDays(-170) },
            new() { Name = "ISO 100 Hydrolyzed 2.27kg", Description = "Dymatize ISO100 hidrolizirani whey izolat, cookies & cream", Price = 99.90m, StockQuantity = 12, CategoryId = proteini, ImageUrl = "/seed/protein_powder_4.jpg", CreatedAt = now.AddDays(-160) },
            new() { Name = "Vegan Protein 750g", Description = "BioTechUSA Vegan Protein mješavina, čokolada-cimet", Price = 35.90m, StockQuantity = 20, CategoryId = proteini, ImageUrl = "/seed/protein_powder_5.jpg", CreatedAt = now.AddDays(-90) },
            new() { Name = "Mass Gainer 5kg", Description = "Serious Mass gainer sa 1250 kalorija po servingu", Price = 69.90m, StockQuantity = 8, CategoryId = proteini, ImageUrl = "/seed/protein_powder_6.jpg", CreatedAt = now.AddDays(-150) },

            // Kreatin (3)
            new() { Name = "Kreatin Monohidrat 500g", Description = "Čisti mikronizovani kreatin monohidrat, unflavoured", Price = 29.90m, StockQuantity = 50, CategoryId = kreatin, ImageUrl = "/seed/creatine.jpg", CreatedAt = now.AddDays(-180) },
            new() { Name = "Kreatin HCL 120 caps", Description = "Kreatin hidrohlorid u kapsulama, bez potrebe za loading fazom", Price = 34.90m, StockQuantity = 30, CategoryId = kreatin, ImageUrl = "/seed/capsules_1.jpg", CreatedAt = now.AddDays(-120) },
            new() { Name = "Creatine Monohydrate 1kg", Description = "MyProtein kreatin monohidrat, veće pakovanje", Price = 44.90m, StockQuantity = 18, CategoryId = kreatin, ImageUrl = "/seed/creatine.jpg", CreatedAt = now.AddDays(-100) },

            // Aminokiseline (4)
            new() { Name = "BCAA 2:1:1 400g", Description = "Xtend BCAA u prahu, mango", Price = 39.90m, StockQuantity = 35, CategoryId = amino, ImageUrl = "/seed/pre_workout.jpg", CreatedAt = now.AddDays(-160) },
            new() { Name = "EAA 350g", Description = "Esencijalne aminokiseline u prahu, limun", Price = 42.90m, StockQuantity = 22, CategoryId = amino, ImageUrl = "/seed/protein_powder_5.jpg", CreatedAt = now.AddDays(-130) },
            new() { Name = "Glutamin 500g", Description = "Čisti L-glutamin u prahu za oporavak", Price = 27.90m, StockQuantity = 28, CategoryId = amino, ImageUrl = "/seed/protein_powder_4.jpg", CreatedAt = now.AddDays(-140) },
            new() { Name = "BCAA Mega Caps 150 caps", Description = "Olimp BCAA u kapsulama, praktično za putovanja", Price = 24.90m, StockQuantity = 0, CategoryId = amino, ImageUrl = "/seed/capsules_2.jpg", CreatedAt = now.AddDays(-110) }, // Out of stock

            // Vitamini i minerali (4)
            new() { Name = "Multivitamin Daily 60 tabs", Description = "Kompletan multivitamin za svakodnevnu upotrebu", Price = 19.90m, StockQuantity = 60, CategoryId = vitamini, ImageUrl = "/seed/vitamin_bottle.jpg", CreatedAt = now.AddDays(-180) },
            new() { Name = "Vitamin D3 2000IU 120 caps", Description = "Vitamin D3 za imunitet i zdravlje kostiju", Price = 14.90m, StockQuantity = 45, CategoryId = vitamini, ImageUrl = "/seed/capsules_1.jpg", CreatedAt = now.AddDays(-150) },
            new() { Name = "ZMA 90 caps", Description = "Cink, magnezij i vitamin B6 za oporavak i san", Price = 22.90m, StockQuantity = 35, CategoryId = vitamini, ImageUrl = "/seed/capsules_2.jpg", CreatedAt = now.AddDays(-130) },
            new() { Name = "Omega 3 Fish Oil 120 caps", Description = "Riblje ulje sa EPA i DHA masnim kiselinama", Price = 17.90m, StockQuantity = 40, CategoryId = vitamini, ImageUrl = "/seed/fish_oil.jpg", CreatedAt = now.AddDays(-120) },

            // Pre-workout (3)
            new() { Name = "C4 Original 30 servings", Description = "Cellucor C4 pre-workout, fruit punch", Price = 37.90m, StockQuantity = 20, CategoryId = preworkout, ImageUrl = "/seed/pre_workout.jpg", CreatedAt = now.AddDays(-160) },
            new() { Name = "Total War 30 servings", Description = "Redcon1 Total War pre-workout, rainbow candy", Price = 44.90m, StockQuantity = 15, CategoryId = preworkout, ImageUrl = "/seed/protein_powder_1.jpg", CreatedAt = now.AddDays(-130) },
            new() { Name = "Pump Non-Stim 300g", Description = "Pre-workout bez kofeina za pump i fokus", Price = 32.90m, StockQuantity = 18, CategoryId = preworkout, ImageUrl = "/seed/protein_powder_2.jpg", CreatedAt = now.AddDays(-90) }
        };

        await context.Products.AddRangeAsync(products);
        await context.SaveChangesAsync();

        // ──────────────────────────────────────────────
        // ORDERS (12 orders across multiple users, overlapping products for recommendations)
        // ──────────────────────────────────────────────
        var amir = users[0].Id;
        var lejla = users[1].Id;
        var edin = users[2].Id;
        var selma = users[3].Id;
        var kenan = users[4].Id;
        var testUser = users[5].Id;

        var p = products; // shorthand

        var orders = new List<Order>
        {
            // Amir: Whey + Kreatin + BCAA (classic stack)
            new()
            {
                UserId = amir, Status = OrderStatus.Delivered, CreatedAt = now.AddDays(-75),
                TotalAmount = p[0].Price + p[6].Price + p[9].Price,
                Items = new List<OrderItem>
                {
                    new() { ProductId = p[0].Id, Quantity = 1, UnitPrice = p[0].Price },  // Whey Gold 2.27kg
                    new() { ProductId = p[6].Id, Quantity = 1, UnitPrice = p[6].Price },  // Kreatin 500g
                    new() { ProductId = p[9].Id, Quantity = 1, UnitPrice = p[9].Price }   // BCAA
                }
            },
            // Amir: Whey + Multivitamin
            new()
            {
                UserId = amir, Status = OrderStatus.Delivered, CreatedAt = now.AddDays(-30),
                TotalAmount = p[1].Price + p[13].Price,
                Items = new List<OrderItem>
                {
                    new() { ProductId = p[1].Id, Quantity = 1, UnitPrice = p[1].Price },  // Whey Gold 900g
                    new() { ProductId = p[13].Id, Quantity = 1, UnitPrice = p[13].Price }  // Multivitamin
                }
            },
            // Lejla: Whey + Kreatin + C4 Pre-workout + ZMA
            new()
            {
                UserId = lejla, Status = OrderStatus.Delivered, CreatedAt = now.AddDays(-150),
                TotalAmount = p[0].Price + p[6].Price + p[17].Price + p[15].Price,
                Items = new List<OrderItem>
                {
                    new() { ProductId = p[0].Id, Quantity = 1, UnitPrice = p[0].Price },  // Whey Gold 2.27kg
                    new() { ProductId = p[6].Id, Quantity = 1, UnitPrice = p[6].Price },  // Kreatin 500g
                    new() { ProductId = p[17].Id, Quantity = 1, UnitPrice = p[17].Price }, // C4 Pre-workout
                    new() { ProductId = p[15].Id, Quantity = 1, UnitPrice = p[15].Price }  // ZMA
                }
            },
            // Lejla: ISO 100 + EAA + Omega 3
            new()
            {
                UserId = lejla, Status = OrderStatus.Shipped, CreatedAt = now.AddDays(-20),
                TotalAmount = p[3].Price + p[10].Price + p[16].Price,
                Items = new List<OrderItem>
                {
                    new() { ProductId = p[3].Id, Quantity = 1, UnitPrice = p[3].Price },   // ISO 100
                    new() { ProductId = p[10].Id, Quantity = 1, UnitPrice = p[10].Price },  // EAA
                    new() { ProductId = p[16].Id, Quantity = 1, UnitPrice = p[16].Price }   // Omega 3
                }
            },
            // Edin: Whey + Kreatin (same combo — boosts recommendation score)
            new()
            {
                UserId = edin, Status = OrderStatus.Confirmed, CreatedAt = now.AddDays(-35),
                TotalAmount = p[0].Price + p[6].Price,
                Items = new List<OrderItem>
                {
                    new() { ProductId = p[0].Id, Quantity = 1, UnitPrice = p[0].Price },  // Whey Gold 2.27kg
                    new() { ProductId = p[6].Id, Quantity = 1, UnitPrice = p[6].Price }   // Kreatin 500g
                }
            },
            // Edin: BCAA + Glutamin + Multivitamin
            new()
            {
                UserId = edin, Status = OrderStatus.Delivered, CreatedAt = now.AddDays(-10),
                TotalAmount = p[9].Price + p[11].Price + p[13].Price,
                Items = new List<OrderItem>
                {
                    new() { ProductId = p[9].Id, Quantity = 1, UnitPrice = p[9].Price },   // BCAA
                    new() { ProductId = p[11].Id, Quantity = 1, UnitPrice = p[11].Price },  // Glutamin
                    new() { ProductId = p[13].Id, Quantity = 1, UnitPrice = p[13].Price }   // Multivitamin
                }
            },
            // Selma: Vegan Protein + Vitamin D + Omega 3 + Pump Non-Stim
            new()
            {
                UserId = selma, Status = OrderStatus.Delivered, CreatedAt = now.AddDays(-100),
                TotalAmount = p[4].Price + p[14].Price + p[16].Price + p[19].Price,
                Items = new List<OrderItem>
                {
                    new() { ProductId = p[4].Id, Quantity = 1, UnitPrice = p[4].Price },   // Vegan Protein
                    new() { ProductId = p[14].Id, Quantity = 1, UnitPrice = p[14].Price },  // Vitamin D
                    new() { ProductId = p[16].Id, Quantity = 1, UnitPrice = p[16].Price },  // Omega 3
                    new() { ProductId = p[19].Id, Quantity = 1, UnitPrice = p[19].Price }   // Pump Non-Stim
                }
            },
            // Selma: Whey 900g + Kreatin + ZMA
            new()
            {
                UserId = selma, Status = OrderStatus.Shipped, CreatedAt = now.AddDays(-15),
                TotalAmount = p[1].Price + p[6].Price + p[15].Price,
                Items = new List<OrderItem>
                {
                    new() { ProductId = p[1].Id, Quantity = 1, UnitPrice = p[1].Price },  // Whey Gold 900g
                    new() { ProductId = p[6].Id, Quantity = 1, UnitPrice = p[6].Price },  // Kreatin 500g
                    new() { ProductId = p[15].Id, Quantity = 1, UnitPrice = p[15].Price }  // ZMA
                }
            },
            // Kenan: Kreatin + Total War Pre-workout
            new()
            {
                UserId = kenan, Status = OrderStatus.Confirmed, CreatedAt = now.AddDays(-7),
                TotalAmount = p[6].Price + p[18].Price,
                Items = new List<OrderItem>
                {
                    new() { ProductId = p[6].Id, Quantity = 1, UnitPrice = p[6].Price },   // Kreatin 500g
                    new() { ProductId = p[18].Id, Quantity = 1, UnitPrice = p[18].Price }   // Total War
                }
            },
            // Test User: Whey + Kreatin + Multivitamin (overlaps with Amir, Edin, Lejla)
            new()
            {
                UserId = testUser, Status = OrderStatus.Delivered, CreatedAt = now.AddDays(-40),
                TotalAmount = p[0].Price + p[6].Price + p[13].Price,
                Items = new List<OrderItem>
                {
                    new() { ProductId = p[0].Id, Quantity = 1, UnitPrice = p[0].Price },  // Whey Gold 2.27kg
                    new() { ProductId = p[6].Id, Quantity = 1, UnitPrice = p[6].Price },  // Kreatin 500g
                    new() { ProductId = p[13].Id, Quantity = 1, UnitPrice = p[13].Price }  // Multivitamin
                }
            },
            // Test User: C4 Pre-workout + BCAA
            new()
            {
                UserId = testUser, Status = OrderStatus.Delivered, CreatedAt = now.AddDays(-12),
                TotalAmount = p[17].Price + p[9].Price,
                Items = new List<OrderItem>
                {
                    new() { ProductId = p[17].Id, Quantity = 1, UnitPrice = p[17].Price },  // C4 Pre-workout
                    new() { ProductId = p[9].Id, Quantity = 1, UnitPrice = p[9].Price }     // BCAA
                }
            },
            // A cancelled order (should NOT count in recommendations)
            new()
            {
                UserId = amir, Status = OrderStatus.Cancelled, CreatedAt = now.AddDays(-50),
                TotalAmount = p[18].Price + p[3].Price,
                Items = new List<OrderItem>
                {
                    new() { ProductId = p[18].Id, Quantity = 1, UnitPrice = p[18].Price },
                    new() { ProductId = p[3].Id, Quantity = 1, UnitPrice = p[3].Price }
                }
            }
        };

        await context.Orders.AddRangeAsync(orders);
        await context.SaveChangesAsync();

        // ──────────────────────────────────────────────
        // APPOINTMENTS (10 — mix of statuses)
        // ──────────────────────────────────────────────
        var trainers = staff.Where(s => s.StaffType == StaffType.Trainer && s.IsActive).ToList();
        var nutritionists = staff.Where(s => s.StaffType == StaffType.Nutritionist).ToList();

        var appointments = new List<Appointment>
        {
            // Past — completed
            new()
            {
                UserId = amir, StaffId = trainers[0].Id, ScheduledAt = now.AddDays(-60).Date.AddHours(10),
                DurationMinutes = 60, Status = AppointmentStatus.Completed,
                Notes = "Inicijalni trening plan i procjena forme", CreatedAt = now.AddDays(-65)
            },
            new()
            {
                UserId = lejla, StaffId = trainers[1].Id, ScheduledAt = now.AddDays(-45).Date.AddHours(14),
                DurationMinutes = 60, Status = AppointmentStatus.Completed,
                Notes = "Program snage - gornji dio tijela", CreatedAt = now.AddDays(-50)
            },
            new()
            {
                UserId = selma, StaffId = nutritionists[0].Id, ScheduledAt = now.AddDays(-30).Date.AddHours(11),
                DurationMinutes = 60, Status = AppointmentStatus.Completed,
                Notes = "Konsultacija o ishrani za mršavljenje", CreatedAt = now.AddDays(-35)
            },
            new()
            {
                UserId = testUser, StaffId = trainers[0].Id, ScheduledAt = now.AddDays(-20).Date.AddHours(9),
                DurationMinutes = 60, Status = AppointmentStatus.Completed,
                Notes = "Uvodni trening sa demonstracijom vježbi", CreatedAt = now.AddDays(-25)
            },
            new()
            {
                UserId = edin, StaffId = nutritionists[1].Id, ScheduledAt = now.AddDays(-15).Date.AddHours(16),
                DurationMinutes = 60, Status = AppointmentStatus.Completed,
                Notes = "Plan ishrane za dobijanje mišićne mase", CreatedAt = now.AddDays(-20)
            },
            // Past — cancelled
            new()
            {
                UserId = kenan, StaffId = trainers[2].Id, ScheduledAt = now.AddDays(-10).Date.AddHours(8),
                DurationMinutes = 60, Status = AppointmentStatus.Cancelled,
                Notes = "Otkazano zbog bolesti", CreatedAt = now.AddDays(-15)
            },
            // Upcoming — confirmed
            new()
            {
                UserId = amir, StaffId = trainers[1].Id, ScheduledAt = now.AddDays(2).Date.AddHours(10),
                DurationMinutes = 60, Status = AppointmentStatus.Confirmed,
                Notes = "Follow-up trening — noge i core", CreatedAt = now.AddDays(-3)
            },
            new()
            {
                UserId = testUser, StaffId = nutritionists[0].Id, ScheduledAt = now.AddDays(3).Date.AddHours(13),
                DurationMinutes = 60, Status = AppointmentStatus.Confirmed,
                Notes = "Konsultacija o suplementaciji", CreatedAt = now.AddDays(-2)
            },
            // Upcoming — pending
            new()
            {
                UserId = lejla, StaffId = trainers[0].Id, ScheduledAt = now.AddDays(5).Date.AddHours(15),
                DurationMinutes = 60, Status = AppointmentStatus.Pending,
                Notes = "Napredni program — periodizacija", CreatedAt = now.AddDays(-1)
            },
            new()
            {
                UserId = selma, StaffId = trainers[2].Id, ScheduledAt = now.AddDays(7).Date.AddHours(11),
                DurationMinutes = 60, Status = AppointmentStatus.Pending,
                Notes = "Priprema za 5K trku", CreatedAt = now
            }
        };

        await context.Appointments.AddRangeAsync(appointments);
        await context.SaveChangesAsync();

        // ──────────────────────────────────────────────
        // REVIEWS (12 — products and appointments)
        // ──────────────────────────────────────────────
        var completedAppointments = appointments.Where(a => a.Status == AppointmentStatus.Completed).ToList();

        var reviews = new List<Review>
        {
            // Product reviews
            new()
            {
                UserId = amir, Rating = 5, Comment = "Najbolji whey protein, odličan ukus čokolade!",
                ReviewType = ReviewType.Product, ProductId = p[0].Id, CreatedAt = now.AddDays(-70)
            },
            new()
            {
                UserId = lejla, Rating = 4, Comment = "Kvalitetan protein, miješa se lako. Ukus mogao biti bolji.",
                ReviewType = ReviewType.Product, ProductId = p[0].Id, CreatedAt = now.AddDays(-140)
            },
            new()
            {
                UserId = edin, Rating = 5, Comment = "Kreatin radi posao, primjetio sam razliku u snazi nakon 2 sedmice.",
                ReviewType = ReviewType.Product, ProductId = p[6].Id, CreatedAt = now.AddDays(-25)
            },
            new()
            {
                UserId = selma, Rating = 3, Comment = "Vegan protein je ok, ali tekstura je malo praškasta.",
                ReviewType = ReviewType.Product, ProductId = p[4].Id, CreatedAt = now.AddDays(-85)
            },
            new()
            {
                UserId = testUser, Rating = 4, Comment = "C4 pre-workout daje dobru energiju, ali malo previše picka.",
                ReviewType = ReviewType.Product, ProductId = p[17].Id, CreatedAt = now.AddDays(-8)
            },
            new()
            {
                UserId = kenan, Rating = 5, Comment = "Total War je najjači pre-workout koji sam probao!",
                ReviewType = ReviewType.Product, ProductId = p[18].Id, CreatedAt = now.AddDays(-5)
            },
            new()
            {
                UserId = amir, Rating = 4, Comment = "BCAA imaju dobar ukus manga, koristan za duže treninge.",
                ReviewType = ReviewType.Product, ProductId = p[9].Id, CreatedAt = now.AddDays(-65)
            },

            // Appointment reviews (only for completed appointments)
            new()
            {
                UserId = amir, Rating = 5, Comment = "Mirza je odličan trener, objašnjava sve detaljno.",
                ReviewType = ReviewType.Appointment, AppointmentId = completedAppointments[0].Id, CreatedAt = now.AddDays(-58)
            },
            new()
            {
                UserId = lejla, Rating = 5, Comment = "Amila je fantastična! Program snage je tačno ono što mi je trebalo.",
                ReviewType = ReviewType.Appointment, AppointmentId = completedAppointments[1].Id, CreatedAt = now.AddDays(-43)
            },
            new()
            {
                UserId = selma, Rating = 4, Comment = "Naida je dala korisne savjete o ishrani, preporučujem.",
                ReviewType = ReviewType.Appointment, AppointmentId = completedAppointments[2].Id, CreatedAt = now.AddDays(-28)
            },
            new()
            {
                UserId = testUser, Rating = 4, Comment = "Dobar uvodni trening, sada znam kako raditi vježbe pravilno.",
                ReviewType = ReviewType.Appointment, AppointmentId = completedAppointments[3].Id, CreatedAt = now.AddDays(-18)
            },
            new()
            {
                UserId = edin, Rating = 5, Comment = "Faruk je napravio odličan plan ishrane, lako se pridržavati.",
                ReviewType = ReviewType.Appointment, AppointmentId = completedAppointments[4].Id, CreatedAt = now.AddDays(-13)
            }
        };

        await context.Reviews.AddRangeAsync(reviews);
        await context.SaveChangesAsync();

        // ──────────────────────────────────────────────
        // GYM VISITS (25 — spread across users over the last 2 months)
        // ──────────────────────────────────────────────
        var gymVisits = new List<GymVisit>
        {
            // Amir — regular (3x/week-ish)
            new() { UserId = amir, CheckInAt = now.AddDays(-60).Date.AddHours(7), CheckOutAt = now.AddDays(-60).Date.AddHours(8).AddMinutes(30), DurationMinutes = 90, CreatedAt = now.AddDays(-60) },
            new() { UserId = amir, CheckInAt = now.AddDays(-57).Date.AddHours(7), CheckOutAt = now.AddDays(-57).Date.AddHours(8).AddMinutes(15), DurationMinutes = 75, CreatedAt = now.AddDays(-57) },
            new() { UserId = amir, CheckInAt = now.AddDays(-54).Date.AddHours(17), CheckOutAt = now.AddDays(-54).Date.AddHours(18).AddMinutes(30), DurationMinutes = 90, CreatedAt = now.AddDays(-54) },
            new() { UserId = amir, CheckInAt = now.AddDays(-20).Date.AddHours(7), CheckOutAt = now.AddDays(-20).Date.AddHours(8).AddMinutes(20), DurationMinutes = 80, CreatedAt = now.AddDays(-20) },
            new() { UserId = amir, CheckInAt = now.AddDays(-3).Date.AddHours(6).AddMinutes(30), CheckOutAt = now.AddDays(-3).Date.AddHours(8), DurationMinutes = 90, CreatedAt = now.AddDays(-3) },

            // Lejla — very active (5x/week)
            new() { UserId = lejla, CheckInAt = now.AddDays(-50).Date.AddHours(6), CheckOutAt = now.AddDays(-50).Date.AddHours(7).AddMinutes(30), DurationMinutes = 90, CreatedAt = now.AddDays(-50) },
            new() { UserId = lejla, CheckInAt = now.AddDays(-48).Date.AddHours(6), CheckOutAt = now.AddDays(-48).Date.AddHours(7).AddMinutes(45), DurationMinutes = 105, CreatedAt = now.AddDays(-48) },
            new() { UserId = lejla, CheckInAt = now.AddDays(-46).Date.AddHours(17), CheckOutAt = now.AddDays(-46).Date.AddHours(18).AddMinutes(30), DurationMinutes = 90, CreatedAt = now.AddDays(-46) },
            new() { UserId = lejla, CheckInAt = now.AddDays(-10).Date.AddHours(6), CheckOutAt = now.AddDays(-10).Date.AddHours(7).AddMinutes(30), DurationMinutes = 90, CreatedAt = now.AddDays(-10) },
            new() { UserId = lejla, CheckInAt = now.AddDays(-2).Date.AddHours(6), CheckOutAt = now.AddDays(-2).Date.AddHours(7).AddMinutes(15), DurationMinutes = 75, CreatedAt = now.AddDays(-2) },

            // Edin — moderate
            new() { UserId = edin, CheckInAt = now.AddDays(-40).Date.AddHours(18), CheckOutAt = now.AddDays(-40).Date.AddHours(19).AddMinutes(15), DurationMinutes = 75, CreatedAt = now.AddDays(-40) },
            new() { UserId = edin, CheckInAt = now.AddDays(-35).Date.AddHours(18), CheckOutAt = now.AddDays(-35).Date.AddHours(19).AddMinutes(30), DurationMinutes = 90, CreatedAt = now.AddDays(-35) },
            new() { UserId = edin, CheckInAt = now.AddDays(-5).Date.AddHours(18), CheckOutAt = now.AddDays(-5).Date.AddHours(19), DurationMinutes = 60, CreatedAt = now.AddDays(-5) },

            // Selma — consistent
            new() { UserId = selma, CheckInAt = now.AddDays(-55).Date.AddHours(9), CheckOutAt = now.AddDays(-55).Date.AddHours(10).AddMinutes(15), DurationMinutes = 75, CreatedAt = now.AddDays(-55) },
            new() { UserId = selma, CheckInAt = now.AddDays(-52).Date.AddHours(9), CheckOutAt = now.AddDays(-52).Date.AddHours(10).AddMinutes(30), DurationMinutes = 90, CreatedAt = now.AddDays(-52) },
            new() { UserId = selma, CheckInAt = now.AddDays(-25).Date.AddHours(9), CheckOutAt = now.AddDays(-25).Date.AddHours(10).AddMinutes(15), DurationMinutes = 75, CreatedAt = now.AddDays(-25) },
            new() { UserId = selma, CheckInAt = now.AddDays(-8).Date.AddHours(16), CheckOutAt = now.AddDays(-8).Date.AddHours(17).AddMinutes(15), DurationMinutes = 75, CreatedAt = now.AddDays(-8) },

            // Kenan — newbie, just started
            new() { UserId = kenan, CheckInAt = now.AddDays(-12).Date.AddHours(19), CheckOutAt = now.AddDays(-12).Date.AddHours(20), DurationMinutes = 60, CreatedAt = now.AddDays(-12) },
            new() { UserId = kenan, CheckInAt = now.AddDays(-9).Date.AddHours(19), CheckOutAt = now.AddDays(-9).Date.AddHours(19).AddMinutes(45), DurationMinutes = 45, CreatedAt = now.AddDays(-9) },
            new() { UserId = kenan, CheckInAt = now.AddDays(-4).Date.AddHours(19), CheckOutAt = now.AddDays(-4).Date.AddHours(20).AddMinutes(10), DurationMinutes = 70, CreatedAt = now.AddDays(-4) },

            // Test User
            new() { UserId = testUser, CheckInAt = now.AddDays(-45).Date.AddHours(10), CheckOutAt = now.AddDays(-45).Date.AddHours(11).AddMinutes(15), DurationMinutes = 75, CreatedAt = now.AddDays(-45) },
            new() { UserId = testUser, CheckInAt = now.AddDays(-30).Date.AddHours(10), CheckOutAt = now.AddDays(-30).Date.AddHours(11).AddMinutes(30), DurationMinutes = 90, CreatedAt = now.AddDays(-30) },
            new() { UserId = testUser, CheckInAt = now.AddDays(-15).Date.AddHours(17), CheckOutAt = now.AddDays(-15).Date.AddHours(18).AddMinutes(15), DurationMinutes = 75, CreatedAt = now.AddDays(-15) },
            new() { UserId = testUser, CheckInAt = now.AddDays(-6).Date.AddHours(10), CheckOutAt = now.AddDays(-6).Date.AddHours(11), DurationMinutes = 60, CreatedAt = now.AddDays(-6) },
            // One active visit (checked in, not yet checked out)
            new() { UserId = testUser, CheckInAt = now.AddHours(-1), CheckOutAt = null, DurationMinutes = null, CreatedAt = now }
        };

        await context.GymVisits.AddRangeAsync(gymVisits);
        await context.SaveChangesAsync();

        // ──────────────────────────────────────────────
        // WORKOUT PLANS + DAYS + EXERCISES (2 plans)
        // ──────────────────────────────────────────────
        var exercises = await context.Exercises.ToListAsync();
        var benchPress = exercises.First(e => e.Name == "Bench Press");
        var inclineBench = exercises.First(e => e.Name == "Incline Bench Press");
        var dbFlyes = exercises.First(e => e.Name == "Dumbbell Flyes");
        var squat = exercises.First(e => e.Name == "Squat");
        var legPress = exercises.First(e => e.Name == "Leg Press");
        var legCurl = exercises.First(e => e.Name == "Leg Curl");
        var calfRaise = exercises.First(e => e.Name == "Calf Raise");
        var deadlift = exercises.First(e => e.Name == "Deadlift");
        var barbellRow = exercises.First(e => e.Name == "Barbell Row");
        var latPulldown = exercises.First(e => e.Name == "Lat Pulldown");
        var overheadPress = exercises.First(e => e.Name == "Overhead Press");
        var lateralRaise = exercises.First(e => e.Name == "Dumbbell Lateral Raise");
        var barbellCurl = exercises.First(e => e.Name == "Barbell Curl");
        var tricepPushdown = exercises.First(e => e.Name == "Tricep Pushdown");
        var plank = exercises.First(e => e.Name == "Plank");

        // Plan 1: Amir — Push/Pull/Legs
        var amirPlan = new WorkoutPlan
        {
            UserId = amir, Name = "Push/Pull/Legs", Description = "Klasični PPL split za 3 dana",
            CreatedAt = now.AddDays(-55),
            Days = new List<WorkoutDay>
            {
                new()
                {
                    DayOfWeek = DayOfWeek.Monday, Name = "Push Day",
                    CreatedAt = now.AddDays(-55),
                    Exercises = new List<WorkoutExercise>
                    {
                        new() { ExerciseId = benchPress.Id, Sets = 4, Reps = 8, Weight = 80, RestSeconds = 120, OrderIndex = 1, CreatedAt = now.AddDays(-55) },
                        new() { ExerciseId = inclineBench.Id, Sets = 3, Reps = 10, Weight = 60, RestSeconds = 90, OrderIndex = 2, CreatedAt = now.AddDays(-55) },
                        new() { ExerciseId = overheadPress.Id, Sets = 3, Reps = 10, Weight = 40, RestSeconds = 90, OrderIndex = 3, CreatedAt = now.AddDays(-55) },
                        new() { ExerciseId = lateralRaise.Id, Sets = 3, Reps = 15, Weight = 10, RestSeconds = 60, OrderIndex = 4, CreatedAt = now.AddDays(-55) },
                        new() { ExerciseId = tricepPushdown.Id, Sets = 3, Reps = 12, Weight = 25, RestSeconds = 60, OrderIndex = 5, CreatedAt = now.AddDays(-55) }
                    }
                },
                new()
                {
                    DayOfWeek = DayOfWeek.Wednesday, Name = "Pull Day",
                    CreatedAt = now.AddDays(-55),
                    Exercises = new List<WorkoutExercise>
                    {
                        new() { ExerciseId = deadlift.Id, Sets = 4, Reps = 6, Weight = 120, RestSeconds = 180, OrderIndex = 1, CreatedAt = now.AddDays(-55) },
                        new() { ExerciseId = barbellRow.Id, Sets = 4, Reps = 8, Weight = 70, RestSeconds = 120, OrderIndex = 2, CreatedAt = now.AddDays(-55) },
                        new() { ExerciseId = latPulldown.Id, Sets = 3, Reps = 10, Weight = 55, RestSeconds = 90, OrderIndex = 3, CreatedAt = now.AddDays(-55) },
                        new() { ExerciseId = barbellCurl.Id, Sets = 3, Reps = 12, Weight = 25, RestSeconds = 60, OrderIndex = 4, CreatedAt = now.AddDays(-55) }
                    }
                },
                new()
                {
                    DayOfWeek = DayOfWeek.Friday, Name = "Leg Day",
                    CreatedAt = now.AddDays(-55),
                    Exercises = new List<WorkoutExercise>
                    {
                        new() { ExerciseId = squat.Id, Sets = 4, Reps = 8, Weight = 100, RestSeconds = 150, OrderIndex = 1, CreatedAt = now.AddDays(-55) },
                        new() { ExerciseId = legPress.Id, Sets = 3, Reps = 12, Weight = 180, RestSeconds = 120, OrderIndex = 2, CreatedAt = now.AddDays(-55) },
                        new() { ExerciseId = legCurl.Id, Sets = 3, Reps = 12, Weight = 40, RestSeconds = 90, OrderIndex = 3, CreatedAt = now.AddDays(-55) },
                        new() { ExerciseId = calfRaise.Id, Sets = 4, Reps = 15, Weight = 60, RestSeconds = 60, OrderIndex = 4, CreatedAt = now.AddDays(-55) },
                        new() { ExerciseId = plank.Id, Sets = 3, Reps = 1, Weight = null, RestSeconds = 60, OrderIndex = 5, CreatedAt = now.AddDays(-55) }
                    }
                }
            }
        };

        // Plan 2: Test User — Upper/Lower
        var testUserPlan = new WorkoutPlan
        {
            UserId = testUser, Name = "Upper/Lower Split", Description = "Jednostavni 2-dnevni split za početnike",
            CreatedAt = now.AddDays(-18),
            Days = new List<WorkoutDay>
            {
                new()
                {
                    DayOfWeek = DayOfWeek.Tuesday, Name = "Upper Body",
                    CreatedAt = now.AddDays(-18),
                    Exercises = new List<WorkoutExercise>
                    {
                        new() { ExerciseId = benchPress.Id, Sets = 3, Reps = 10, Weight = 50, RestSeconds = 120, OrderIndex = 1, CreatedAt = now.AddDays(-18) },
                        new() { ExerciseId = barbellRow.Id, Sets = 3, Reps = 10, Weight = 40, RestSeconds = 90, OrderIndex = 2, CreatedAt = now.AddDays(-18) },
                        new() { ExerciseId = overheadPress.Id, Sets = 3, Reps = 10, Weight = 25, RestSeconds = 90, OrderIndex = 3, CreatedAt = now.AddDays(-18) },
                        new() { ExerciseId = dbFlyes.Id, Sets = 3, Reps = 12, Weight = 12, RestSeconds = 60, OrderIndex = 4, CreatedAt = now.AddDays(-18) },
                        new() { ExerciseId = barbellCurl.Id, Sets = 2, Reps = 12, Weight = 15, RestSeconds = 60, OrderIndex = 5, CreatedAt = now.AddDays(-18) }
                    }
                },
                new()
                {
                    DayOfWeek = DayOfWeek.Thursday, Name = "Lower Body",
                    CreatedAt = now.AddDays(-18),
                    Exercises = new List<WorkoutExercise>
                    {
                        new() { ExerciseId = squat.Id, Sets = 3, Reps = 10, Weight = 60, RestSeconds = 120, OrderIndex = 1, CreatedAt = now.AddDays(-18) },
                        new() { ExerciseId = legPress.Id, Sets = 3, Reps = 12, Weight = 100, RestSeconds = 90, OrderIndex = 2, CreatedAt = now.AddDays(-18) },
                        new() { ExerciseId = legCurl.Id, Sets = 3, Reps = 12, Weight = 25, RestSeconds = 90, OrderIndex = 3, CreatedAt = now.AddDays(-18) },
                        new() { ExerciseId = calfRaise.Id, Sets = 3, Reps = 15, Weight = 40, RestSeconds = 60, OrderIndex = 4, CreatedAt = now.AddDays(-18) },
                        new() { ExerciseId = plank.Id, Sets = 3, Reps = 1, Weight = null, RestSeconds = 60, OrderIndex = 5, CreatedAt = now.AddDays(-18) }
                    }
                }
            }
        };

        await context.WorkoutPlans.AddRangeAsync(amirPlan, testUserPlan);
        await context.SaveChangesAsync();

        // ──────────────────────────────────────────────
        // WORKOUT LOGS (8 — completed workouts)
        // ──────────────────────────────────────────────
        var amirPushDay = amirPlan.Days.First(d => d.Name == "Push Day");
        var amirPullDay = amirPlan.Days.First(d => d.Name == "Pull Day");
        var amirLegDay = amirPlan.Days.First(d => d.Name == "Leg Day");
        var testUpperDay = testUserPlan.Days.First(d => d.Name == "Upper Body");
        var testLowerDay = testUserPlan.Days.First(d => d.Name == "Lower Body");

        var workoutLogs = new List<WorkoutLog>
        {
            // Amir's logs
            new()
            {
                UserId = amir, WorkoutDayId = amirPushDay.Id,
                StartedAt = now.AddDays(-54).Date.AddHours(17), CompletedAt = now.AddDays(-54).Date.AddHours(18).AddMinutes(20),
                Notes = "Dobar trening, povećao bench za 2.5kg", CreatedAt = now.AddDays(-54)
            },
            new()
            {
                UserId = amir, WorkoutDayId = amirPullDay.Id,
                StartedAt = now.AddDays(-52).Date.AddHours(7), CompletedAt = now.AddDays(-52).Date.AddHours(8).AddMinutes(15),
                Notes = "Deadlift PR — 125kg!", CreatedAt = now.AddDays(-52)
            },
            new()
            {
                UserId = amir, WorkoutDayId = amirLegDay.Id,
                StartedAt = now.AddDays(-50).Date.AddHours(7), CompletedAt = now.AddDays(-50).Date.AddHours(8).AddMinutes(30),
                Notes = "Teški squat dan, ali odradio sve setove", CreatedAt = now.AddDays(-50)
            },
            new()
            {
                UserId = amir, WorkoutDayId = amirPushDay.Id,
                StartedAt = now.AddDays(-20).Date.AddHours(7), CompletedAt = now.AddDays(-20).Date.AddHours(8).AddMinutes(10),
                Notes = null, CreatedAt = now.AddDays(-20)
            },
            new()
            {
                UserId = amir, WorkoutDayId = amirPullDay.Id,
                StartedAt = now.AddDays(-3).Date.AddHours(6).AddMinutes(30), CompletedAt = now.AddDays(-3).Date.AddHours(7).AddMinutes(50),
                Notes = "Rows su bili odlični danas", CreatedAt = now.AddDays(-3)
            },

            // Test User's logs
            new()
            {
                UserId = testUser, WorkoutDayId = testUpperDay.Id,
                StartedAt = now.AddDays(-15).Date.AddHours(17), CompletedAt = now.AddDays(-15).Date.AddHours(18).AddMinutes(10),
                Notes = "Prvi pravi trening po planu", CreatedAt = now.AddDays(-15)
            },
            new()
            {
                UserId = testUser, WorkoutDayId = testLowerDay.Id,
                StartedAt = now.AddDays(-13).Date.AddHours(10), CompletedAt = now.AddDays(-13).Date.AddHours(11).AddMinutes(5),
                Notes = "Noge su bolele 2 dana poslije :)", CreatedAt = now.AddDays(-13)
            },
            new()
            {
                UserId = testUser, WorkoutDayId = testUpperDay.Id,
                StartedAt = now.AddDays(-6).Date.AddHours(10), CompletedAt = now.AddDays(-6).Date.AddHours(11),
                Notes = "Povećao tegove na svim vježbama za 2.5kg", CreatedAt = now.AddDays(-6)
            }
        };

        await context.WorkoutLogs.AddRangeAsync(workoutLogs);
        await context.SaveChangesAsync();
    }

    private static async Task SeedMembershipPlansAsync(ApplicationDbContext context)
    {
        if (await context.MembershipPlans.AnyAsync())
            return;

        var plans = new List<MembershipPlan>
        {
            new() { Name = "Mjesečna", Description = "Standardna mjesečna članarina za pristup svim sadržajima teretane.", Price = 50m, DurationDays = 30, IsActive = true, CreatedAt = DateTime.UtcNow.AddDays(-200) },
            new() { Name = "Kvartalna", Description = "Tromjesečna članarina sa 20% popusta u odnosu na mjesečnu.", Price = 120m, DurationDays = 90, IsActive = true, CreatedAt = DateTime.UtcNow.AddDays(-200) },
            new() { Name = "Godišnja", Description = "Godišnja članarina sa najboljom cijenom — uštedite preko 30%!", Price = 400m, DurationDays = 365, IsActive = true, CreatedAt = DateTime.UtcNow.AddDays(-200) }
        };

        await context.MembershipPlans.AddRangeAsync(plans);
        await context.SaveChangesAsync();
    }

    private static async Task SeedTestMembershipsAsync(ApplicationDbContext context)
    {
        if (await context.UserMemberships.AnyAsync())
            return;

        var users = await context.Users.Where(u => u.Role == Role.User).OrderBy(u => u.Id).ToListAsync();
        var plans = await context.MembershipPlans.OrderBy(p => p.Id).ToListAsync();

        if (users.Count < 3 || plans.Count < 3)
            return;

        var now = DateTime.UtcNow;
        var mjesecna = plans[0];
        var kvartalna = plans[1];
        var godisnja = plans[2];

        var memberships = new List<UserMembership>
        {
            // User 0 (Amir) — active quarterly membership
            new()
            {
                UserId = users[0].Id, MembershipPlanId = kvartalna.Id,
                StartDate = now.AddDays(-30), EndDate = now.AddDays(60),
                Status = MembershipStatus.Active, CreatedAt = now.AddDays(-30)
            },
            // User 0 (Amir) — expired monthly (historical)
            new()
            {
                UserId = users[0].Id, MembershipPlanId = mjesecna.Id,
                StartDate = now.AddDays(-120), EndDate = now.AddDays(-90),
                Status = MembershipStatus.Expired, CreatedAt = now.AddDays(-120)
            },
            // User 1 (Lejla) — active yearly
            new()
            {
                UserId = users[1].Id, MembershipPlanId = godisnja.Id,
                StartDate = now.AddDays(-60), EndDate = now.AddDays(305),
                Status = MembershipStatus.Active, CreatedAt = now.AddDays(-60)
            },
            // User 5 (Test User) — expired monthly
            new()
            {
                UserId = users[5].Id, MembershipPlanId = mjesecna.Id,
                StartDate = now.AddDays(-45), EndDate = now.AddDays(-15),
                Status = MembershipStatus.Expired, CreatedAt = now.AddDays(-45)
            }
        };

        await context.UserMemberships.AddRangeAsync(memberships);
        await context.SaveChangesAsync();
    }
}
