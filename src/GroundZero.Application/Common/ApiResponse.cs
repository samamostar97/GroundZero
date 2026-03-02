namespace GroundZero.Application.Common;

public class ApiResponse<T>
{
    public T? Data { get; set; }
    public List<string> Errors { get; set; } = new();
    public int StatusCode { get; set; }
    public bool IsSuccess { get; set; }

    public static ApiResponse<T> Success(T data, int statusCode = 200)
    {
        return new ApiResponse<T>
        {
            Data = data,
            StatusCode = statusCode,
            IsSuccess = true
        };
    }

    public static ApiResponse<T> Fail(string error, int statusCode = 400)
    {
        return new ApiResponse<T>
        {
            Errors = new List<string> { error },
            StatusCode = statusCode,
            IsSuccess = false
        };
    }

    public static ApiResponse<T> Fail(List<string> errors, int statusCode = 400)
    {
        return new ApiResponse<T>
        {
            Errors = errors,
            StatusCode = statusCode,
            IsSuccess = false
        };
    }
}
