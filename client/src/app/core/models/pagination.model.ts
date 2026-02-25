export interface PagedResult<T> {
  items: T[];
  totalCount: number;
  pageNumber: number;
}

export interface PaginationRequest {
  pageNumber: number;
  pageSize: number;
}
