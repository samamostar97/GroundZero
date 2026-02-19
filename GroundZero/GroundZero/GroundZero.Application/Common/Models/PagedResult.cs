namespace GroundZero.Application.Common.Models;

public class PagedResult<T>
{
    public List<T> Items { get; set; } = [];
    public int TotalCount { get; set; }
    public int Page { get; set; }
    public int PageSize { get; set; }
    public int TotalPages => (int)Math.Ceiling(TotalCount / (double)PageSize);
    public bool HasPreviousPage => Page > 1;
    public bool HasNextPage => Page < TotalPages;
    public PagedResult() { }
    public PagedResult(List<T> items, int totalCount, int page, int pageSize)
    { Items = items; TotalCount = totalCount; Page = page; PageSize = pageSize; }
    public PagedResult<TDest> Map<TDest>(Func<T, TDest> selector) =>
        new(Items.Select(selector).ToList(), TotalCount, Page, PageSize);
}