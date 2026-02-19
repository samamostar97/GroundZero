using System.Linq.Expressions;
namespace GroundZero.Application.Querying;
public static class SortingHelper
{
    public static IQueryable<T> ApplySort<T>(this IQueryable<T> q, string? sortBy, bool desc,
        Dictionary<string, Expression<Func<T, object>>> map)
    {
        if (string.IsNullOrWhiteSpace(sortBy) || !map.ContainsKey(sortBy.ToLower())) return q;
        var expr = map[sortBy.ToLower()];
        return desc ? q.OrderByDescending(expr) : q.OrderBy(expr);
    }
}