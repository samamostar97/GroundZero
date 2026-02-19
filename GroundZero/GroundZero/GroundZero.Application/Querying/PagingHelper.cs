using Microsoft.EntityFrameworkCore;
using GroundZero.Application.Common.Models;
namespace GroundZero.Application.Querying;
public static class PagingHelper
{
    public static async Task<PagedResult<T>> ToPagedResultAsync<T>(this IQueryable<T> q, int page, int size, CancellationToken ct = default)
    {
        var total = await q.CountAsync(ct);
        var items = await q.Skip((page - 1) * size).Take(size).ToListAsync(ct);
        return new PagedResult<T>(items, total, page, size);
    }
}