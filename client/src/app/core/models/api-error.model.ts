export interface ApiError {
  error?: string;
  errors?: { [field: string]: string[] };
}
