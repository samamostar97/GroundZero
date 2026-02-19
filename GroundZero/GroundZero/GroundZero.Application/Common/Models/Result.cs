namespace GroundZero.Application.Common.Models;

public class Result
{
    public bool IsSuccess { get; }
    public string? Error { get; }
    public bool IsFailure => !IsSuccess;
    protected Result(bool ok, string? err) { IsSuccess = ok; Error = err; }
    public static Result Success() => new(true, null);
    public static Result Failure(string e) => new(false, e);
    public static Result<T> Success<T>(T v) => new(v, true, null);
    public static Result<T> Failure<T>(string e) => new(default, false, e);
}
public class Result<T> : Result
{
    public T? Value { get; }
    internal Result(T? v, bool ok, string? err) : base(ok, err) { Value = v; }
}