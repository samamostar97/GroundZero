using GroundZero.Application.Common;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using GroundZero.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Infrastructure.Repositories;

public class WorkoutPlanRepository : Repository<WorkoutPlan>, IWorkoutPlanRepository
{
    public WorkoutPlanRepository(ApplicationDbContext context) : base(context) { }

    public async Task<WorkoutPlan?> GetByIdWithDetailsAsync(int id, CancellationToken cancellationToken = default)
    {
        return await _dbSet
            .Include(wp => wp.Days)
                .ThenInclude(d => d.Exercises)
                    .ThenInclude(we => we.Exercise)
            .FirstOrDefaultAsync(wp => wp.Id == id, cancellationToken);
    }

    public async Task<PagedResult<WorkoutPlan>> GetUserPlansPagedAsync(
        int userId, string? search, int pageNumber, int pageSize,
        CancellationToken cancellationToken = default)
    {
        var query = _dbSet
            .Include(wp => wp.Days)
                .ThenInclude(d => d.Exercises)
                    .ThenInclude(we => we.Exercise)
            .Where(wp => wp.UserId == userId);

        if (!string.IsNullOrWhiteSpace(search))
        {
            var searchLower = search.ToLower();
            query = query.Where(wp =>
                wp.Name.ToLower().Contains(searchLower) ||
                (wp.Description != null && wp.Description.ToLower().Contains(searchLower)));
        }

        var totalCount = await query.CountAsync(cancellationToken);

        var items = await query
            .OrderByDescending(wp => wp.CreatedAt)
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync(cancellationToken);

        return new PagedResult<WorkoutPlan>
        {
            Items = items,
            TotalCount = totalCount,
            PageNumber = pageNumber,
            PageSize = pageSize
        };
    }

    public async Task<WorkoutDay?> GetDayByIdAsync(int dayId, CancellationToken cancellationToken = default)
    {
        return await _context.Set<WorkoutDay>()
            .Include(d => d.Exercises)
                .ThenInclude(we => we.Exercise)
            .FirstOrDefaultAsync(d => d.Id == dayId, cancellationToken);
    }

    public async Task<WorkoutDay?> GetDayByIdWithPlanAsync(int dayId, CancellationToken cancellationToken = default)
    {
        return await _context.Set<WorkoutDay>()
            .Include(d => d.WorkoutPlan)
            .Include(d => d.Exercises)
                .ThenInclude(we => we.Exercise)
            .FirstOrDefaultAsync(d => d.Id == dayId, cancellationToken);
    }

    public async Task<WorkoutExercise?> GetWorkoutExerciseByIdAsync(int id, CancellationToken cancellationToken = default)
    {
        return await _context.Set<WorkoutExercise>()
            .Include(we => we.Exercise)
            .FirstOrDefaultAsync(we => we.Id == id, cancellationToken);
    }

    public async Task<WorkoutDay> AddDayAsync(WorkoutDay day, CancellationToken cancellationToken = default)
    {
        await _context.Set<WorkoutDay>().AddAsync(day, cancellationToken);
        return day;
    }

    public async Task<WorkoutExercise> AddExerciseAsync(WorkoutExercise exercise, CancellationToken cancellationToken = default)
    {
        await _context.Set<WorkoutExercise>().AddAsync(exercise, cancellationToken);
        return exercise;
    }

    public void UpdateDay(WorkoutDay day)
    {
        _context.Set<WorkoutDay>().Update(day);
    }

    public void UpdateExercise(WorkoutExercise exercise)
    {
        _context.Set<WorkoutExercise>().Update(exercise);
    }

    public void SoftDeleteDay(WorkoutDay day)
    {
        day.IsDeleted = true;
        day.DeletedAt = DateTime.UtcNow;
        _context.Set<WorkoutDay>().Update(day);
    }

    public void SoftDeleteExercise(WorkoutExercise exercise)
    {
        exercise.IsDeleted = true;
        exercise.DeletedAt = DateTime.UtcNow;
        _context.Set<WorkoutExercise>().Update(exercise);
    }
}
