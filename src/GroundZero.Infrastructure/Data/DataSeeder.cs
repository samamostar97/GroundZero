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
}
